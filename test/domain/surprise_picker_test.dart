import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/evening.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/library_entry.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/entities/user_preferences.dart';
import 'package:scena/domain/usecases/surprise_picker.dart';

void main() {
  final now = DateTime(2026, 5, 20, 21);

  MediaItem movie({
    required int id,
    String? title,
    List<int> genres = const [18],
    int? runtime = 100,
  }) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.movie,
      title: title ?? 'Film $id',
      overview: 'Trama $id',
      genres: GenreCatalog.byIds(genres),
      runtimeMinutes: runtime,
      tmdbVoteAverage: 7,
    );
  }

  LibraryEntryWithMedia entry(
    MediaItem media, {
    LibraryStatus status = LibraryStatus.toWatch,
    List<String> tags = const [],
  }) {
    return LibraryEntryWithMedia(
      media: media,
      entry: LibraryEntry(
        id: media.tmdbId,
        mediaItemId: media.tmdbId,
        status: status,
        tags: tags,
        lastActivityAt: now.subtract(const Duration(days: 10)),
        createdAt: now.subtract(const Duration(days: 60)),
        updatedAt: now.subtract(const Duration(days: 10)),
      ),
    );
  }

  test('estrae un titolo elegibile ed è deterministico con seed', () {
    final library = [
      for (var index = 1; index <= 5; index++) entry(movie(id: index)),
    ];
    final pickerA = SurprisePicker(random: Random(42));
    final pickerB = SurprisePicker(random: Random(42));

    final a = pickerA.pick(
      library: library,
      request: const EveningRequest(availableMinutes: 120),
      preferences: const UserPreferences(),
      now: now,
    );
    final b = pickerB.pick(
      library: library,
      request: const EveningRequest(availableMinutes: 120),
      preferences: const UserPreferences(),
      now: now,
    );

    expect(a.hasPick, isTrue);
    expect(b.candidate!.key, a.candidate!.key);
    expect(a.reason, startsWith('Estratto per te:'));
  });

  test('ignora i titoli visti e abbandonati', () {
    final library = [
      entry(movie(id: 1), status: LibraryStatus.completed),
      entry(movie(id: 2), status: LibraryStatus.abandoned),
      entry(movie(id: 3, title: 'Disponibile')),
    ];

    final pick = SurprisePicker(random: Random(7)).pick(
      library: library,
      request: const EveningRequest(),
      preferences: const UserPreferences(),
      now: now,
    );

    expect(pick.hasPick, isTrue);
    expect(pick.candidate!.media.title, 'Disponibile');
  });

  test('quando non ci sono titoli resta esausto', () {
    final pick = SurprisePicker(random: Random(1)).pick(
      library: [
        entry(movie(id: 1), status: LibraryStatus.completed),
      ],
      request: const EveningRequest(),
      preferences: const UserPreferences(),
      now: now,
    );

    expect(pick.hasPick, isFalse);
    expect(pick.exhausted, isTrue);
  });

  test('rispetta niente horror e le esclusioni di parole chiave', () {
    final library = [
      entry(
        movie(
          id: 1,
          title: 'Horror',
          genres: const [GenreCatalog.horrorId],
        ),
      ),
      entry(movie(id: 2, title: 'Zombie Movie')),
      entry(movie(id: 3, title: 'Commedia', genres: const [35])),
    ];

    final pick = SurprisePicker(random: Random(3)).pick(
      library: library,
      request: const EveningRequest(noHorror: true),
      preferences: const UserPreferences(
        hardExclusions: HardExclusions(keywords: ['zombie']),
      ),
      now: now,
    );

    expect(pick.hasPick, isTrue);
    expect(pick.candidate!.media.title, 'Commedia');
  });

  test('preferisce un titolo compatibile con il tempo disponibile', () {
    final library = [
      entry(movie(id: 1, title: 'Corto', runtime: 80)),
      entry(movie(id: 2, title: 'Lungo', runtime: 180)),
    ];

    final pick = SurprisePicker(random: Random(11)).pick(
      library: library,
      request: const EveningRequest(availableMinutes: 90),
      preferences: const UserPreferences(),
      now: now,
    );

    expect(pick.candidate!.media.title, 'Corto');
    expect(pick.reason, contains('90 minuti'));
  });

  test('le chiavi escluse evitano ripetizioni', () {
    final library = [
      entry(movie(id: 1, title: 'Primo')),
      entry(movie(id: 2, title: 'Secondo')),
    ];
    final picker = SurprisePicker(random: Random(5));
    final first = picker.pick(
      library: library,
      request: const EveningRequest(),
      preferences: const UserPreferences(),
      now: now,
    );

    final second = picker.pick(
      library: library,
      request: const EveningRequest(),
      preferences: const UserPreferences(),
      excludedKeys: {first.candidate!.key},
      now: now,
    );

    expect(second.candidate!.key, isNot(first.candidate!.key));
  });
}
