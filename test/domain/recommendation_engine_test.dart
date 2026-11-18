import 'package:flutter_test/flutter_test.dart';
import 'package:scena/domain/entities/dismissed_suggestion.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/evening.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/library_entry.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/entities/user_preferences.dart';
import 'package:scena/domain/usecases/recommendation_engine.dart';

void main() {
  const engine = RecommendationEngine();
  final now = DateTime(2026, 5, 20, 20);

  MediaItem movie({
    required int id,
    String? title,
    List<int> genres = const [18],
    int? runtime = 100,
    double vote = 7,
  }) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.movie,
      title: title ?? 'Film $id',
      overview: 'Trama del film $id',
      genres: GenreCatalog.byIds(genres),
      runtimeMinutes: runtime,
      tmdbVoteAverage: vote,
      releaseDate: DateTime(2020),
    );
  }

  MediaItem tv({
    required int id,
    String? title,
    List<int> genres = const [18],
    int? episodeRuntime = 40,
    int seasons = 2,
    int episodes = 20,
    double vote = 7,
  }) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.tv,
      title: title ?? 'Serie $id',
      overview: 'Trama della serie $id',
      genres: GenreCatalog.byIds(genres),
      episodeRuntimeMinutes: episodeRuntime,
      numberOfSeasons: seasons,
      numberOfEpisodes: episodes,
      tmdbVoteAverage: vote,
      releaseDate: DateTime(2021),
    );
  }

  LibraryEntryWithMedia entry(
    MediaItem media, {
    LibraryStatus status = LibraryStatus.toWatch,
    List<String> tags = const [],
    DateTime? createdAt,
    DateTime? lastActivityAt,
    int? season,
    int? episode,
  }) {
    return LibraryEntryWithMedia(
      media: media,
      entry: LibraryEntry(
        id: media.tmdbId,
        mediaItemId: media.tmdbId,
        status: status,
        tags: tags,
        currentSeason: season,
        currentEpisode: episode,
        lastActivityAt: lastActivityAt ?? now.subtract(const Duration(days: 3)),
        createdAt: createdAt ?? now.subtract(const Duration(days: 30)),
        updatedAt: lastActivityAt ?? now.subtract(const Duration(days: 3)),
      ),
    );
  }

  group('RecommendationEngine', () {
    test('libreria vuota produce una nota esplicativa', () {
      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 120),
        library: const [],
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      expect(result.suggestions, isEmpty);
      expect(result.relaxationNote, contains('libreria è vuota'));
    });

    test('restituisce al massimo tre proposte e è deterministico', () {
      final library = [
        for (var index = 1; index <= 5; index++)
          entry(movie(id: index, title: 'Film $index', vote: 7 + index / 10)),
      ];

      final first = engine.recommend(
        request: const EveningRequest(availableMinutes: 120),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
        limit: 10,
      );
      final second = engine.recommend(
        request: const EveningRequest(availableMinutes: 120),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
        limit: 10,
      );

      expect(first.suggestions, hasLength(3));
      expect(first.totalEligible, 5);
      expect(
        first.suggestions.map((item) => item.media.title),
        second.suggestions.map((item) => item.media.title),
      );
    });

    test('esclude i titoli troppo lunghi quando ci sono alternative', () {
      final library = [
        for (var index = 1; index <= 4; index++)
          entry(movie(id: index, runtime: 90)),
        entry(movie(id: 99, title: 'Lunghissimo', runtime: 180)),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 100),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      expect(result.relaxed, isFalse);
      expect(result.suggestions, hasLength(3));
      expect(
        result.suggestions.every((item) => !item.isTooLong),
        isTrue,
      );
      expect(
        result.suggestions.map((item) => item.media.tmdbId),
        isNot(contains(99)),
      );
    });

    test('allenta il vincolo di durata quando le alternative sono poche', () {
      final library = [
        entry(movie(id: 1, runtime: 90)),
        entry(movie(id: 2, runtime: 180)),
        entry(movie(id: 3, runtime: 170)),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 100),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      expect(result.relaxed, isTrue);
      expect(result.relaxationNote, isNotNull);
      expect(result.suggestions, hasLength(3));
      expect(result.suggestions.where((item) => item.isTooLong), hasLength(2));
      expect(
        result.suggestions
            .firstWhere((item) => item.isTooLong)
            .reason
            .toLowerCase(),
        contains('alternative'),
      );
    });

    test('rispetta il vincolo niente horror', () {
      final library = [
        entry(movie(id: 1, genres: const [GenreCatalog.horrorId])),
        entry(movie(id: 2, genres: const [GenreCatalog.comedyId])),
        entry(movie(id: 3, genres: const [GenreCatalog.dramaId])),
        entry(movie(id: 4, genres: const [GenreCatalog.actionId])),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 120, noHorror: true),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      expect(
        result.suggestions
            .any((item) => item.media.genreIds.contains(GenreCatalog.horrorId)),
        isFalse,
      );
    });

    test('famiglia esclude i generi sensibili', () {
      final library = [
        entry(movie(id: 1, genres: const [GenreCatalog.crimeId])),
        entry(movie(id: 2, genres: const [GenreCatalog.familyId])),
        entry(movie(id: 3, genres: const [GenreCatalog.animationId])),
        entry(movie(id: 4, genres: const [GenreCatalog.comedyId])),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 120, familyOnly: true),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      expect(
        result.suggestions
            .any((item) => item.media.genreIds.contains(GenreCatalog.crimeId)),
        isFalse,
      );
      expect(result.suggestions, isNotEmpty);
    });

    test('umore e generi preferiti cambiano la classifica', () {
      final library = [
        entry(
          movie(
            id: 1,
            title: 'Commedia',
            genres: const [GenreCatalog.comedyId],
            vote: 7,
          ),
        ),
        entry(
          movie(
            id: 2,
            title: 'Dramma',
            genres: const [GenreCatalog.dramaId],
            vote: 7,
          ),
        ),
        entry(
          movie(
            id: 3,
            title: 'Avventura',
            genres: const [GenreCatalog.adventureId],
            vote: 7,
          ),
        ),
      ];

      final result = engine.recommend(
        request: const EveningRequest(
          availableMinutes: 120,
          mood: Mood.light,
        ),
        library: library,
        preferences: const UserPreferences(preferredGenres: [35]),
        dismissals: const [],
        now: now,
      );

      expect(result.suggestions.first.media.title, 'Commedia');
    });

    test('i generi evitati abbassano il punteggio', () {
      final library = [
        entry(
          movie(
            id: 1,
            title: 'Solo dramma',
            genres: const [GenreCatalog.dramaId],
            vote: 7,
          ),
        ),
        entry(
          movie(
            id: 2,
            title: 'Dramma thriller',
            genres: const [GenreCatalog.dramaId, GenreCatalog.thrillerId],
            vote: 7,
          ),
        ),
      ];

      final result = engine.recommend(
        request: const EveningRequest(
          availableMinutes: 120,
          mood: Mood.dramatic,
        ),
        library: library,
        preferences: const UserPreferences(avoidedGenres: [53]),
        dismissals: const [],
        now: now,
      );

      expect(result.suggestions.first.media.title, 'Solo dramma');
    });

    test('uno scarto recente penalizza il titolo', () {
      final library = [
        entry(movie(id: 1, title: 'Scartato')),
        entry(movie(id: 2, title: 'Mantenuto')),
      ];
      final dismissals = [
        DismissedSuggestion(
          tmdbId: 1,
          mediaType: MediaType.movie,
          reason: 'Non mi va',
          dismissedAt: now,
        ),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 120),
        library: library,
        preferences: const UserPreferences(),
        dismissals: dismissals,
        now: now,
      );

      expect(result.suggestions.first.media.title, 'Mantenuto');
    });

    test('per le serie usa la durata episodica e lo stato serie', () {
      final library = [
        entry(
          tv(id: 1, title: 'The Bear', episodeRuntime: 30),
          status: LibraryStatus.inProgress,
          season: 2,
          episode: 4,
        ),
        entry(tv(id: 2, episodeRuntime: 45)),
        entry(tv(id: 3, episodeRuntime: 50)),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 90),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      final bear = result.suggestions.firstWhere(
        (item) => item.media.title == 'The Bear',
      );
      expect(bear.estimatedMinutes, 30);
      expect(bear.status, SuggestionStatus.alreadyStarted);
      expect(bear.reason.toLowerCase(), contains('prossimo episodio'));
      expect(bear.reason, contains('S02'));
    });

    test('durata sconosciuta produce stato dedicato', () {
      final library = [
        entry(movie(id: 1, runtime: null, title: 'Ignoto')),
        entry(movie(id: 2, runtime: 90)),
        entry(movie(id: 3, runtime: 90)),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 100),
        library: library,
        preferences: const UserPreferences(),
        dismissals: const [],
        now: now,
      );

      final unknown = result.suggestions.firstWhere(
        (item) => item.media.title == 'Ignoto',
      );
      expect(unknown.isDurationUnknown, isTrue);
      expect(unknown.status, SuggestionStatus.unknownDuration);
      expect(unknown.reason.toLowerCase(), contains('durata non nota'));
    });

    test('i no assoluti escludono anche per parola chiave', () {
      final library = [
        entry(movie(id: 1, title: 'Zombie Night')),
        entry(movie(id: 2, title: 'Commedia tranquilla')),
        entry(movie(id: 3, title: 'Dramma quieto')),
      ];

      final result = engine.recommend(
        request: const EveningRequest(availableMinutes: 120),
        library: library,
        preferences: const UserPreferences(
          hardExclusions: HardExclusions(keywords: ['zombie']),
        ),
        dismissals: const [],
        now: now,
      );

      expect(
        result.suggestions.any((item) => item.media.title == 'Zombie Night'),
        isFalse,
      );
    });
  });
}
