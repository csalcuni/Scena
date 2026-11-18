import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/library_entry.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/entities/viewing_event.dart';
import 'package:scena/domain/repositories/library_repository.dart';
import 'package:scena/domain/usecases/library_usecases.dart';

void main() {
  final now = DateTime(2026, 5, 20, 21);

  MediaItem movie({int id = 1, String title = 'Film'}) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.movie,
      title: title,
      overview: 'Trama di $title',
      genres: GenreCatalog.byIds(const [GenreCatalog.dramaId]),
      runtimeMinutes: 100,
      tmdbVoteAverage: 7.5,
      releaseDate: DateTime(2020),
    );
  }

  MediaItem series({int id = 2, String title = 'Serie'}) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.tv,
      title: title,
      overview: 'Trama di $title',
      genres: GenreCatalog.byIds(const [GenreCatalog.comedyId]),
      numberOfSeasons: 3,
      numberOfEpisodes: 24,
      episodeRuntimeMinutes: 30,
      tmdbVoteAverage: 8,
      releaseDate: DateTime(2021),
    );
  }

  late FakeLibraryRepository library;
  late FakeViewingEventRepository events;

  setUp(() {
    library = FakeLibraryRepository(now: now);
    events = FakeViewingEventRepository();
  });

  group('AddToLibrary', () {
    test('aggiunge un film con lo stato richiesto e senza eventi', () async {
      final addToLibrary = AddToLibrary(library, events);

      final result = await addToLibrary(
        movie(id: 10, title: 'Il film'),
        now: now,
      );

      expect(result.media.tmdbId, 10);
      expect(result.entry.status, LibraryStatus.toWatch);
      expect(result.entry.currentSeason, isNull);
      expect(result.entry.currentEpisode, isNull);
      expect(await library.getAll(), hasLength(1));
      expect(events.events, isEmpty);
    });

    test('registra un evento quando si parte da In corso', () async {
      final addToLibrary = AddToLibrary(library, events);

      await addToLibrary(
        series(id: 20),
        status: LibraryStatus.inProgress,
        now: now,
      );

      expect(events.events, hasLength(1));
      expect(events.events.single.eventType, ViewingEventType.started);
      expect(events.events.single.occurredAt, now);
    });

    test('non duplica un titolo già presente e conserva il suo stato', () async {
      final addToLibrary = AddToLibrary(library, events);
      final first = await addToLibrary(
        series(id: 21),
        status: LibraryStatus.inProgress,
        now: now,
      );

      final second = await addToLibrary(
        series(id: 21, title: 'Titolo aggiornato'),
        status: LibraryStatus.completed,
        now: now.add(const Duration(hours: 1)),
      );

      expect(second.entry.id, first.entry.id);
      expect(second.entry.status, LibraryStatus.inProgress);
      expect(second.entry.currentSeason, 1);
      expect(second.entry.currentEpisode, 1);
      expect(await library.getAll(), hasLength(1));
      expect(events.events, hasLength(1));
    });
  });

  group('ChangeLibraryStatus', () {
    Future<LibraryEntryWithMedia> seeded({
      LibraryStatus status = LibraryStatus.toWatch,
      MediaItem? media,
      int? season,
      int? episode,
    }) async {
      return library.addMedia(
        media: media ?? movie(),
        status: status,
        currentSeason: season,
        currentEpisode: episode,
      );
    }

    test('passare a In corso inizializza la prima puntata di una serie', () async {
      final changeStatus = ChangeLibraryStatus(library, events);
      final item = await seeded(media: series(id: 5));

      final updated = await changeStatus(
        item,
        LibraryStatus.inProgress,
        now: now,
      );

      expect(updated.status, LibraryStatus.inProgress);
      expect(updated.currentSeason, 1);
      expect(updated.currentEpisode, 1);
      expect(updated.lastActivityAt, now);
      expect(events.events.single.eventType, ViewingEventType.started);
      expect(events.events.single.season, isNull);
      expect(events.events.single.episode, isNull);
    });

    test('riprendere una serie in pausa registra il resume', () async {
      final changeStatus = ChangeLibraryStatus(library, events);
      final item = await seeded(
        media: series(id: 6),
        status: LibraryStatus.paused,
        season: 2,
        episode: 4,
      );

      final updated = await changeStatus(
        item,
        LibraryStatus.inProgress,
        now: now,
      );

      expect(updated.currentSeason, 2);
      expect(updated.currentEpisode, 4);
      expect(events.events.single.eventType, ViewingEventType.resumed);
      expect(events.events.single.season, 2);
      expect(events.events.single.episode, 4);
    });

    test('completato e abbandonato producono eventi dedicati', () async {
      final changeStatus = ChangeLibraryStatus(library, events);
      final item = await seeded();

      await changeStatus(item, LibraryStatus.completed, now: now);
      await changeStatus(item, LibraryStatus.abandoned, now: now);
      await changeStatus(item, LibraryStatus.paused, now: now);

      expect(
        events.events.map((event) => event.eventType),
        [
          ViewingEventType.completed,
          ViewingEventType.abandoned,
          ViewingEventType.paused,
        ],
      );
      expect((await library.findById(item.entry.id))!.entry.status,
          LibraryStatus.paused);
    });
  });

  group('UpdateLibraryEntry', () {
    test('aggiorna voto, note, tag e puntata', () async {
      final item = await library.addMedia(
        media: series(id: 7),
        status: LibraryStatus.inProgress,
        currentSeason: 1,
        currentEpisode: 1,
      );
      final update = UpdateLibraryEntry(library);

      final updated = await update(
        item.entry,
        rating: 8,
        note: 'Bella puntata',
        tags: const ['confortante', 'breve'],
        currentSeason: 2,
        currentEpisode: 3,
        now: now,
      );

      expect(updated.personalRating, 8);
      expect(updated.personalNote, 'Bella puntata');
      expect(updated.tags, ['confortante', 'breve']);
      expect(updated.currentSeason, 2);
      expect(updated.currentEpisode, 3);
      expect(updated.updatedAt, now);

      final reloaded = await library.findById(item.entry.id);
      expect(reloaded!.entry.personalRating, 8);
      expect(reloaded.entry.tags, ['confortante', 'breve']);
    });

    test('clearRating e clearNote azzerano i campi', () async {
      final item = await library.addMedia(
        media: movie(id: 8),
        status: LibraryStatus.toWatch,
      );
      final update = UpdateLibraryEntry(library);
      await update(item.entry, rating: 7, note: 'Da rivedere', now: now);

      final cleared = await update(
        item.entry.copyWith(personalRating: 7, personalNote: 'Da rivedere'),
        clearRating: true,
        clearNote: true,
        now: now,
      );

      expect(cleared.personalRating, isNull);
      expect(cleared.personalNote, isNull);
    });
  });

  group('MarkEpisodeWatched', () {
    test('avanza di una puntata e registra l’evento', () async {
      final item = await library.addMedia(
        media: series(id: 9),
        status: LibraryStatus.inProgress,
        currentSeason: 2,
        currentEpisode: 5,
      );
      final markEpisode = MarkEpisodeWatched(library, events);

      final updated = await markEpisode(item, now: now);

      expect(updated.entry.status, LibraryStatus.inProgress);
      expect(updated.entry.currentSeason, 2);
      expect(updated.entry.currentEpisode, 6);
      expect(updated.entry.lastActivityAt, now);
      expect(events.events.single.eventType, ViewingEventType.episodeWatched);
      expect(events.events.single.season, 2);
      expect(events.events.single.episode, 5);
    });

    test('parte da S1E1 quando la serie non ha puntate impostate', () async {
      final item = await library.addMedia(
        media: series(id: 10),
        status: LibraryStatus.toWatch,
      );
      final markEpisode = MarkEpisodeWatched(library, events);

      final updated = await markEpisode(item, now: now);

      expect(updated.entry.currentSeason, 1);
      expect(updated.entry.currentEpisode, 2);
      expect(events.events.single.episode, 1);
    });

    test('rifiuta i film', () async {
      final item = await library.addMedia(
        media: movie(id: 11),
        status: LibraryStatus.toWatch,
      );
      final markEpisode = MarkEpisodeWatched(library, events);

      expect(
        () => markEpisode(item, now: now),
        throwsArgumentError,
      );
    });
  });

  group('MarkWatched', () {
    test('un film passa a Visto con evento completed', () async {
      final item = await library.addMedia(
        media: movie(id: 12),
        status: LibraryStatus.inProgress,
      );
      final markWatched = MarkWatched(library, events);

      final updated = await markWatched(item, now: now);

      expect(updated.status, LibraryStatus.completed);
      expect(events.events.single.eventType, ViewingEventType.completed);
    });

    test('una serie avanza l’episodio invece di chiudersi', () async {
      final item = await library.addMedia(
        media: series(id: 13),
        status: LibraryStatus.inProgress,
        currentSeason: 1,
        currentEpisode: 2,
      );
      final markWatched = MarkWatched(library, events);

      final updated = await markWatched(item, now: now);

      expect(updated.status, LibraryStatus.inProgress);
      expect(updated.currentEpisode, 3);
      expect(events.events.single.eventType, ViewingEventType.episodeWatched);
    });
  });

  test('nextEpisodeLabel formatta stagione e episodio', () {
    final entry = LibraryEntry(
      id: 1,
      mediaItemId: 1,
      status: LibraryStatus.inProgress,
      currentSeason: 2,
      currentEpisode: 4,
      lastActivityAt: now,
      createdAt: now,
      updatedAt: now,
    );

    expect(entry.nextEpisodeLabel, 'S02 · E04');
  });
}

class FakeLibraryRepository implements LibraryRepository {
  FakeLibraryRepository({required this.now});

  final DateTime now;
  final List<LibraryEntryWithMedia> _items = [];
  final List<StreamController<List<LibraryEntryWithMedia>>> _controllers = [];
  var _nextId = 1;

  List<LibraryEntryWithMedia> get items => List.unmodifiable(_items);

  void _notify() {
    final snapshot = List<LibraryEntryWithMedia>.unmodifiable(_items);
    for (final controller in _controllers) {
      controller.add(snapshot);
    }
  }

  @override
  Future<LibraryEntryWithMedia> addMedia({
    required MediaItem media,
    required LibraryStatus status,
    int? currentSeason,
    int? currentEpisode,
  }) async {
    final existing = await findByMedia(
      type: media.mediaType,
      tmdbId: media.tmdbId,
    );
    if (existing != null) return existing;

    final id = _nextId++;
    final entry = LibraryEntry(
      id: id,
      mediaItemId: media.tmdbId,
      status: status,
      currentSeason: currentSeason,
      currentEpisode: currentEpisode,
      lastActivityAt: now,
      createdAt: now,
      updatedAt: now,
    );
    final item = LibraryEntryWithMedia(
      entry: entry,
      media: media.copyWith(localId: media.tmdbId),
    );
    _items.add(item);
    _notify();
    return item;
  }

  @override
  Future<void> deleteEntry(int id) async {
    _items.removeWhere((item) => item.entry.id == id);
    _notify();
  }

  @override
  Future<LibraryEntryWithMedia?> findById(int id) async {
    for (final item in _items) {
      if (item.entry.id == id) return item;
    }
    return null;
  }

  @override
  Future<LibraryEntryWithMedia?> findByMedia({
    required MediaType type,
    required int tmdbId,
  }) async {
    for (final item in _items) {
      if (item.media.mediaType == type && item.media.tmdbId == tmdbId) {
        return item;
      }
    }
    return null;
  }

  @override
  Future<List<LibraryEntryWithMedia>> getAll() async => items;

  @override
  Future<LibraryEntry> saveEntry(LibraryEntry entry) async {
    final index = _items.indexWhere((item) => item.entry.id == entry.id);
    if (index < 0) {
      throw StateError('Voce non trovata: ${entry.id}');
    }
    _items[index] = _items[index].copyWith(entry: entry);
    _notify();
    return entry;
  }

  @override
  Stream<List<LibraryEntryWithMedia>> watchAll() {
    final controller = StreamController<List<LibraryEntryWithMedia>>();
    _controllers.add(controller);
    controller.add(List<LibraryEntryWithMedia>.unmodifiable(_items));
    controller.onCancel = () {
      _controllers.remove(controller);
      return controller.close();
    };
    return controller.stream;
  }
}

class FakeViewingEventRepository implements ViewingEventRepository {
  final List<ViewingEvent> events = [];

  @override
  Future<void> add(ViewingEvent event) async {
    events.add(event);
  }

  @override
  Future<List<ViewingEvent>> forEntry(int libraryEntryId) async {
    return events
        .where((event) => event.libraryEntryId == libraryEntryId)
        .toList(growable: false);
  }

  @override
  Stream<List<ViewingEvent>> watchForEntry(int libraryEntryId) {
    return Stream.value(
      events
          .where((event) => event.libraryEntryId == libraryEntryId)
          .toList(growable: false),
    );
  }
}
