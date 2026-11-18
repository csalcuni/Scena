import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:scena/app/app.dart';
import 'package:scena/app/providers.dart';
import 'package:scena/data/local/drift/app_database.dart';
import 'package:scena/data/local/repositories/drift_library_repository.dart';
import 'package:scena/data/local/repositories/drift_preferences_repository.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/entities/user_preferences.dart';
import 'package:scena/domain/repositories/media_repository.dart';

/// Catalogo deterministico senza immagini di rete, pensato per i widget test.
class FakeMediaRepository implements MediaRepository {
  static final List<MediaItem> catalog = [
    MediaItem(
      tmdbId: 1,
      mediaType: MediaType.movie,
      title: 'Dune - Parte due',
      originalTitle: 'Dune: Part Two',
      overview: 'Paul Atreides torna su Arrakis.',
      releaseDate: DateTime(2024),
      runtimeMinutes: 166,
      genres: GenreCatalog.byIds(const [878, 12]),
      tmdbVoteAverage: 8.2,
    ),
    MediaItem(
      tmdbId: 2,
      mediaType: MediaType.movie,
      title: 'Parasite',
      originalTitle: '기생충',
      overview: 'Una famiglia si infiltra in una casa benestante.',
      releaseDate: DateTime(2019),
      runtimeMinutes: 132,
      genres: GenreCatalog.byIds(const [35, 18, 53]),
      tmdbVoteAverage: 8.5,
    ),
    MediaItem(
      tmdbId: 3,
      mediaType: MediaType.movie,
      title: 'La città incantata',
      originalTitle: '千と千尋の神隠し',
      overview: 'Una bambina entra in un mondo di spiriti.',
      releaseDate: DateTime(2001),
      runtimeMinutes: 125,
      genres: GenreCatalog.byIds(const [16, 10751, 14]),
      tmdbVoteAverage: 8.5,
    ),
    MediaItem(
      tmdbId: 10,
      mediaType: MediaType.tv,
      title: 'The Bear',
      originalTitle: 'The Bear',
      overview: 'Un giovane chef gestisce il ristorante di famiglia.',
      releaseDate: DateTime(2022),
      genres: GenreCatalog.byIds(const [35, 18]),
      tmdbVoteAverage: 8.3,
      numberOfSeasons: 3,
      numberOfEpisodes: 28,
      episodeRuntimeMinutes: 30,
      tvStatus: 'Running',
    ),
  ];

  @override
  Future<MediaDetails> getDetails({
    required MediaType type,
    required int tmdbId,
  }) async {
    final item = catalog.firstWhere(
      (media) => media.mediaType == type && media.tmdbId == tmdbId,
    );
    return MediaDetails(
      media: item,
      cast: const [CastMember(name: 'Interprete Demo', character: 'Sé')],
      directors: const ['Regista Demo'],
    );
  }

  @override
  Future<List<Genre>> getGenres(MediaType type) async {
    return type == MediaType.movie ? GenreCatalog.movies : GenreCatalog.tv;
  }

  @override
  Future<ImageConfig> getImageConfig() async => ImageConfig.fallback;

  @override
  Future<MediaPage> search({
    required String query,
    required MediaType type,
    int page = 1,
  }) async {
    final normalized = query.trim().toLowerCase();
    final matches = catalog
        .where((item) => item.mediaType == type)
        .where(
          (item) =>
              item.title.toLowerCase().contains(normalized) ||
              (item.originalTitle ?? '').toLowerCase().contains(normalized),
        )
        .toList(growable: false);
    return MediaPage(
      items: matches,
      page: 1,
      totalPages: 1,
      totalResults: matches.length,
    );
  }
}

MediaItem testMovie({
  required int id,
  required String title,
  int runtime = 100,
  List<int> genres = const [GenreCatalog.comedyId],
}) {
  return MediaItem(
    tmdbId: id,
    mediaType: MediaType.movie,
    title: title,
    overview: 'Trama di $title',
    releaseDate: DateTime(2020),
    runtimeMinutes: runtime,
    genres: GenreCatalog.byIds(genres),
    tmdbVoteAverage: 7.5,
  );
}

MediaItem testSeries({
  required int id,
  required String title,
  int episodeRuntime = 30,
}) {
  return MediaItem(
    tmdbId: id,
    mediaType: MediaType.tv,
    title: title,
    overview: 'Trama di $title',
    releaseDate: DateTime(2022),
    genres: GenreCatalog.byIds(const [GenreCatalog.comedyId]),
    tmdbVoteAverage: 8,
    numberOfSeasons: 3,
    numberOfEpisodes: 24,
    episodeRuntimeMinutes: episodeRuntime,
    tvStatus: 'Running',
  );
}

class TestHarness {
  TestHarness._(this.database, this.container);

  final AppDatabase database;
  final ProviderContainer container;

  static Future<TestHarness> create({
    UserPreferences preferences = const UserPreferences(
      onboardingCompleted: true,
    ),
    bool writePreferences = true,
    List<MediaItem> library = const [],
    Map<MediaItem, LibraryStatus> statuses = const {},
    MediaRepository? mediaRepository,
  }) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final preferencesRepository = DriftPreferencesRepository(database);
    if (writePreferences) {
      await preferencesRepository.savePreferences(preferences);
    }
    final libraryRepository = DriftLibraryRepository(database);
    for (final media in library) {
      await libraryRepository.addMedia(
        media: media,
        status: statuses[media] ?? LibraryStatus.toWatch,
      );
    }
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(database),
        mediaRepositoryProvider.overrideWithValue(
          mediaRepository ?? FakeMediaRepository(),
        ),
      ],
    );
    return TestHarness._(database, container);
  }

  Future<void> dispose() async {
    container.dispose();
    await database.close();
  }
}

Future<void> pumpScena(WidgetTester tester, TestHarness harness) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: harness.container,
      child: const ScenaApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void useViewport(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}
