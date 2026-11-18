import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scena/core/errors/app_exception.dart';
import 'package:scena/data/local/drift/app_database.dart';
import 'package:scena/data/local/repositories/drift_backup_repository.dart';
import 'package:scena/data/local/repositories/drift_cache_store.dart';
import 'package:scena/data/local/repositories/drift_library_repository.dart';
import 'package:scena/data/local/repositories/drift_preferences_repository.dart';
import 'package:scena/domain/entities/dismissed_suggestion.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/entities/user_preferences.dart';
import 'package:scena/domain/entities/viewing_event.dart';

void main() {
  late AppDatabase database;
  late DriftLibraryRepository library;
  late DriftViewingEventRepository events;
  late DriftPreferencesRepository preferences;
  late DriftDismissedSuggestionRepository dismissals;
  late DriftBackupRepository backup;
  late DriftCacheStore cache;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    library = DriftLibraryRepository(database);
    events = DriftViewingEventRepository(database);
    preferences = DriftPreferencesRepository(database);
    dismissals = DriftDismissedSuggestionRepository(database);
    backup = DriftBackupRepository(database);
    cache = DriftCacheStore(database);
  });

  tearDown(() async {
    await database.close();
  });

  MediaItem movie({
    int id = 1,
    String title = 'Il padrino',
    int? runtime = 175,
  }) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.movie,
      title: title,
      originalTitle: 'The Godfather',
      overview: 'Una dinastia criminale.',
      posterPath: '/poster.jpg',
      backdropPath: '/backdrop.jpg',
      releaseDate: DateTime(1972),
      runtimeMinutes: runtime,
      genres: GenreCatalog.byIds(const [GenreCatalog.dramaId]),
      tmdbVoteAverage: 8.7,
    );
  }

  MediaItem series({int id = 2, String title = 'The Bear'}) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.tv,
      title: title,
      overview: 'Una cucina caotica.',
      releaseDate: DateTime(2022),
      genres: GenreCatalog.byIds(const [GenreCatalog.comedyId]),
      tmdbVoteAverage: 8.3,
      numberOfSeasons: 3,
      numberOfEpisodes: 28,
      episodeRuntimeMinutes: 30,
      tvStatus: 'Running',
    );
  }

  group('DriftLibraryRepository', () {
    test('inserisce media e voce e li rilegge', () async {
      final item = await library.addMedia(
        media: movie(),
        status: LibraryStatus.toWatch,
      );

      expect(item.entry.status, LibraryStatus.toWatch);
      expect(item.media.tmdbId, 1);
      expect(item.media.genres, GenreCatalog.byIds(const [18]));

      final all = await library.getAll();
      expect(all, hasLength(1));

      final byId = await library.findById(item.entry.id);
      expect(byId!.media.title, 'Il padrino');

      final byMedia = await library.findByMedia(
        type: MediaType.movie,
        tmdbId: 1,
      );
      expect(byMedia!.entry.id, item.entry.id);
    });

    test('non duplica una voce esistente ma aggiorna i metadati', () async {
      final first = await library.addMedia(
        media: movie(title: 'Titolo vecchio'),
        status: LibraryStatus.toWatch,
      );

      final second = await library.addMedia(
        media: movie(title: 'Titolo nuovo', runtime: 180),
        status: LibraryStatus.completed,
      );

      expect(second.entry.id, first.entry.id);
      expect(second.entry.status, LibraryStatus.toWatch);
      expect(second.media.title, 'Titolo nuovo');
      expect(second.media.runtimeMinutes, 180);
      expect(await library.getAll(), hasLength(1));
    });

    test('aggiorna la voce con voto, note, tag ed episodi', () async {
      final item = await library.addMedia(
        media: series(),
        status: LibraryStatus.inProgress,
        currentSeason: 1,
        currentEpisode: 2,
      );
      final now = DateTime(2026, 5, 20, 21);

      await library.saveEntry(
        item.entry.copyWith(
          status: LibraryStatus.paused,
          personalRating: 9,
          personalNote: 'Da riprendere',
          tags: const ['cucina', 'breve'],
          currentSeason: 2,
          currentEpisode: 5,
          lastActivityAt: now,
          updatedAt: now,
        ),
      );

      final reloaded = await library.findById(item.entry.id);
      expect(reloaded!.entry.status, LibraryStatus.paused);
      expect(reloaded.entry.personalRating, 9);
      expect(reloaded.entry.personalNote, 'Da riprendere');
      expect(reloaded.entry.tags, ['cucina', 'breve']);
      expect(reloaded.entry.currentSeason, 2);
      expect(reloaded.entry.currentEpisode, 5);
      expect(reloaded.entry.lastActivityAt, now);
      expect(reloaded.media.title, 'The Bear');
    });

    test('elimina la voce e i relativi eventi', () async {
      final item = await library.addMedia(
        media: movie(),
        status: LibraryStatus.toWatch,
      );
      await events.add(
        ViewingEvent(
          libraryEntryId: item.entry.id,
          eventType: ViewingEventType.started,
          occurredAt: DateTime(2026),
        ),
      );

      await library.deleteEntry(item.entry.id);

      expect(await library.getAll(), isEmpty);
      expect(await events.forEntry(item.entry.id), isEmpty);
    });

    test('watchAll emette la lista ordinata per attività recente', () async {
      final first = await library.addMedia(
        media: movie(id: 10, title: 'Vecchio'),
        status: LibraryStatus.toWatch,
      );
      final second = await library.addMedia(
        media: movie(id: 11, title: 'Recente'),
        status: LibraryStatus.toWatch,
      );
      await library.saveEntry(
        first.entry.copyWith(
          lastActivityAt: DateTime(2025),
          updatedAt: DateTime(2025),
        ),
      );
      await library.saveEntry(
        second.entry.copyWith(
          lastActivityAt: DateTime(2026),
          updatedAt: DateTime(2026),
        ),
      );

      final items = await library.watchAll().first;
      expect(items.map((item) => item.media.title), ['Recente', 'Vecchio']);
    });
  });

  group('DriftPreferencesRepository', () {
    test('crea i valori di default al primo accesso', () async {
      final defaults = await preferences.getPreferences();

      expect(defaults.onboardingCompleted, isFalse);
      expect(defaults.preferredRuntimeMinutes, 120);
      expect(defaults.themeMode, AppThemeMode.system);

      final row = await database
          .select(database.userPreferencesTable)
          .getSingleOrNull();
      expect(row, isNotNull);
    });

    test('salva e rilegge tutte le preferenze', () async {
      const expected = UserPreferences(
        streamingServices: ['netflix', 'mubi'],
        preferredGenres: [35, 18],
        avoidedGenres: [27],
        preferredRuntimeMinutes: 90,
        hardExclusions: HardExclusions(
          keywords: ['zombie'],
          genreIds: [53],
          mediaTypes: [MediaType.tv],
        ),
        themeMode: AppThemeMode.dark,
        onboardingCompleted: true,
      );

      await preferences.savePreferences(expected);
      final loaded = await preferences.getPreferences();

      expect(loaded.streamingServices, ['netflix', 'mubi']);
      expect(loaded.preferredGenres, [35, 18]);
      expect(loaded.avoidedGenres, [27]);
      expect(loaded.preferredRuntimeMinutes, 90);
      expect(loaded.hardExclusions.keywords, ['zombie']);
      expect(loaded.hardExclusions.genreIds, [53]);
      expect(loaded.hardExclusions.mediaTypes, [MediaType.tv]);
      expect(loaded.themeMode, AppThemeMode.dark);
      expect(loaded.onboardingCompleted, isTrue);
    });
  });

  group('DriftViewingEventRepository', () {
    test('filtra per voce e ordina dal più recente', () async {
      final first = await library.addMedia(
        media: movie(id: 20),
        status: LibraryStatus.inProgress,
      );
      final second = await library.addMedia(
        media: series(id: 21),
        status: LibraryStatus.inProgress,
      );
      await events.add(
        ViewingEvent(
          libraryEntryId: first.entry.id,
          eventType: ViewingEventType.started,
          occurredAt: DateTime(2026, 1, 1),
        ),
      );
      await events.add(
        ViewingEvent(
          libraryEntryId: first.entry.id,
          eventType: ViewingEventType.completed,
          occurredAt: DateTime(2026, 2, 1),
        ),
      );
      await events.add(
        ViewingEvent(
          libraryEntryId: second.entry.id,
          eventType: ViewingEventType.started,
          occurredAt: DateTime(2026, 3, 1),
        ),
      );

      final firstEvents = await events.forEntry(first.entry.id);
      expect(firstEvents, hasLength(2));
      expect(firstEvents.first.eventType, ViewingEventType.completed);
      expect(firstEvents.last.eventType, ViewingEventType.started);
    });
  });

  group('DriftDismissedSuggestionRepository', () {
    test('salva, elenca e azzera gli scarti', () async {
      final dismissed = DismissedSuggestion(
        tmdbId: 99,
        mediaType: MediaType.movie,
        reason: 'Non mi va',
        dismissedAt: DateTime(2026, 5, 20),
      );

      await dismissals.dismiss(dismissed);
      final all = await dismissals.getAll();
      expect(all, hasLength(1));
      expect(all.single.tmdbId, 99);
      expect(all.single.reason, 'Non mi va');

      await dismissals.clear();
      expect(await dismissals.getAll(), isEmpty);
    });
  });

  group('DriftBackupRepository', () {
    Future<void> seed() async {
      await preferences.savePreferences(
        const UserPreferences(
          preferredGenres: [35],
          preferredRuntimeMinutes: 100,
          onboardingCompleted: true,
        ),
      );
      final movieItem = await library.addMedia(
        media: movie(id: 30, title: 'Film da salvare'),
        status: LibraryStatus.completed,
      );
      await library.saveEntry(
        movieItem.entry.copyWith(
          personalRating: 8,
          personalNote: 'Molto bello',
          tags: const ['classico'],
        ),
      );
      final seriesItem = await library.addMedia(
        media: series(id: 31, title: 'Serie in corso'),
        status: LibraryStatus.inProgress,
        currentSeason: 2,
        currentEpisode: 3,
      );
      await events.add(
        ViewingEvent(
          libraryEntryId: seriesItem.entry.id,
          eventType: ViewingEventType.episodeWatched,
          season: 2,
          episode: 2,
          occurredAt: DateTime(2026, 5, 19),
        ),
      );
      await dismissals.dismiss(
        DismissedSuggestion(
          tmdbId: 99,
          mediaType: MediaType.movie,
          reason: 'Non stasera',
          dismissedAt: DateTime(2026, 5, 18),
        ),
      );
    }

    test('esporta e reimporta tutti i dati', () async {
      await seed();

      final json = await backup.exportJson();
      expect(json, contains('"format": "scena-backup"'));
      expect(json, contains('Film da salvare'));

      await backup.clearAll();
      expect(await library.getAll(), isEmpty);
      expect(await dismissals.getAll(), isEmpty);
      final afterClear = await preferences.getPreferences();
      expect(afterClear.onboardingCompleted, isFalse);

      final summary = await backup.importJson(json);
      expect(summary.mediaCount, 2);
      expect(summary.entryCount, 2);
      expect(summary.eventCount, 1);
      expect(summary.dismissedCount, 1);

      final restored = await library.getAll();
      expect(restored, hasLength(2));
      final film = restored.firstWhere((item) => item.media.title == 'Film da salvare');
      expect(film.entry.status, LibraryStatus.completed);
      expect(film.entry.personalRating, 8);
      expect(film.entry.personalNote, 'Molto bello');
      expect(film.entry.tags, ['classico']);

      final serie = restored.firstWhere((item) => item.media.title == 'Serie in corso');
      expect(serie.entry.currentSeason, 2);
      expect(serie.entry.currentEpisode, 3);
      expect(await events.forEntry(serie.entry.id), hasLength(1));

      final restoredPreferences = await preferences.getPreferences();
      expect(restoredPreferences.onboardingCompleted, isTrue);
      expect(restoredPreferences.preferredGenres, [35]);
      expect(await dismissals.getAll(), hasLength(1));
    });

    test('rifiuta un JSON non valido', () async {
      expect(
        () => backup.importJson('{"format":"altro"}'),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => backup.importJson('non json'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta una versione non supportata', () async {
      expect(
        () => backup.importJson(
          '{"format":"scena-backup","version":99}',
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('DriftCacheStore', () {
    test('scrive, sovrascrive e rilegge il payload', () async {
      final cachedAt = DateTime(2026, 5, 20);

      await cache.write('movie:1', {'title': 'Prima'}, cachedAt: cachedAt);
      final first = await cache.read('movie:1');
      expect(first!.data['title'], 'Prima');
      expect(first.cachedAt, cachedAt);

      await cache.write('movie:1', {'title': 'Seconda'});
      final second = await cache.read('movie:1');
      expect(second!.data['title'], 'Seconda');
    });

    test('restituisce null per chiavi assenti', () async {
      expect(await cache.read('assente'), isNull);
    });
  });
}
