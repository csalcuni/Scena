import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scena/app/providers.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/repositories/media_repository.dart';
import 'package:scena/features/search/search_controller.dart';

class _SearchMediaRepository implements MediaRepository {
  _SearchMediaRepository({required this.results, required this.details});

  final List<MediaItem> results;
  final Map<String, MediaItem> details;
  var detailCalls = 0;

  @override
  Future<MediaPage> search({
    required String query,
    required MediaType type,
    int page = 1,
  }) async {
    return MediaPage(
      items: results
          .where((item) => item.mediaType == type)
          .toList(growable: false),
      page: 1,
      totalPages: 1,
      totalResults: results.length,
    );
  }

  @override
  Future<MediaDetails> getDetails({
    required MediaType type,
    required int tmdbId,
  }) async {
    detailCalls++;
    final media = details['${type.value}:$tmdbId'];
    if (media == null) {
      throw StateError('Dettaglio non disponibile per $type/$tmdbId');
    }
    return MediaDetails(media: media);
  }

  @override
  Future<List<Genre>> getGenres(MediaType type) async => const [];

  @override
  Future<ImageConfig> getImageConfig() async => ImageConfig.fallback;
}

void main() {
  test(
    'la ricerca arricchisce film e serie con la durata dai dettagli',
    () async {
      final movie = MediaItem(
        tmdbId: 11,
        mediaType: MediaType.movie,
        title: 'Dune',
        releaseDate: DateTime(2021),
        genres: GenreCatalog.byIds(const [878, 12]),
      );
      final series = MediaItem(
        tmdbId: 12,
        mediaType: MediaType.tv,
        title: 'The Bear',
        releaseDate: DateTime(2022),
        genres: GenreCatalog.byIds(const [35, 18]),
      );
      final repository = _SearchMediaRepository(
        results: [movie, series],
        details: {
          'movie:11': movie.copyWith(runtimeMinutes: 155),
          'tv:12': series.copyWith(
            episodeRuntimeMinutes: 30,
            numberOfSeasons: 3,
            numberOfEpisodes: 28,
            tvStatus: 'Running',
          ),
        },
      );
      final container = ProviderContainer(
        overrides: [mediaRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await container
          .read(searchProvider.notifier)
          .search(query: 'Dune', type: MediaType.movie);

      final state = container.read(searchProvider);
      expect(repository.detailCalls, 1);
      expect(state.items.single.runtimeMinutes, 155);
      expect(state.items.single.durationLabel(), '2h 35min');

      await container
          .read(searchProvider.notifier)
          .search(query: 'The Bear', type: MediaType.tv);

      final tvState = container.read(searchProvider);
      expect(repository.detailCalls, 2);
      expect(tvState.items.single.episodeRuntimeMinutes, 30);
      expect(tvState.items.single.numberOfEpisodes, 28);
      expect(tvState.items.single.durationLabel(), '28 ep. · ~30 min/ep');
    },
  );

  test('non richiede i dettagli se la durata è già presente', () async {
    final movie = MediaItem(
      tmdbId: 21,
      mediaType: MediaType.movie,
      title: 'Parasite',
      runtimeMinutes: 132,
    );
    final repository = _SearchMediaRepository(
      results: [movie],
      details: const {},
    );
    final container = ProviderContainer(
      overrides: [mediaRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container
        .read(searchProvider.notifier)
        .search(query: 'Parasite', type: MediaType.movie);

    expect(repository.detailCalls, 0);
    expect(container.read(searchProvider).items.single.runtimeMinutes, 132);
  });
}
