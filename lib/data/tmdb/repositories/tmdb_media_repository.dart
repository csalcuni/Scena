import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/genre_catalog.dart';
import '../../../domain/entities/media_item.dart';
import '../../../domain/repositories/media_repository.dart';
import '../datasources/tmdb_api_client.dart';
import '../datasources/tmdb_cache_store.dart';
import '../mappers/tmdb_mapper.dart';
import '../models/tmdb_models.dart';

class TmdbMediaRepository implements MediaRepository {
  TmdbMediaRepository({
    required this.client,
    required this.cache,
  });

  final TmdbApiClient client;
  final TmdbCacheStore cache;

  String get _language => client.language;

  @override
  Future<MediaPage> search({
    required String query,
    required MediaType type,
    int page = 1,
  }) async {
    final normalized = query.trim().toLowerCase();
    final key = 'search:${type.value}:$_language:$normalized:$page';
    final data = await _withCache(
      key,
      () => type == MediaType.movie
          ? client.searchMovies(query, page: page)
          : client.searchTv(query, page: page),
    );
    try {
      final decoded = data.data;
      final parsed = type == MediaType.movie
          ? TmdbMapper.movieSearchPage(
              TmdbMovieSearchResponse.fromJson(decoded),
            )
          : TmdbMapper.tvSearchPage(
              TmdbTvSearchResponse.fromJson(decoded),
            );
      if (!data.fromCache) return parsed;
      return MediaPage(
        items: parsed.items,
        page: parsed.page,
        totalPages: parsed.totalPages,
        totalResults: parsed.totalResults,
        isFromCache: true,
      );
    } on Object catch (error) {
      throw InvalidResponseException(cause: error);
    }
  }

  @override
  Future<MediaDetails> getDetails({
    required MediaType type,
    required int tmdbId,
  }) async {
    final key = 'details:${type.value}:$_language:$tmdbId';
    final data = await _withCache(
      key,
      () => type == MediaType.movie
          ? client.movieDetails(tmdbId)
          : client.tvDetails(tmdbId),
    );
    try {
      final parsed = type == MediaType.movie
          ? TmdbMapper.movieDetails(
              TmdbMovieDetails.fromJson(data.data),
            )
          : TmdbMapper.tvDetails(
              TmdbTvDetails.fromJson(data.data),
            );
      if (!data.fromCache) return parsed;
      return MediaDetails(
        media: parsed.media,
        cast: parsed.cast,
        directors: parsed.directors,
        isFromCache: true,
      );
    } on AppException {
      rethrow;
    } on Object catch (error) {
      throw InvalidResponseException(cause: error);
    }
  }

  @override
  Future<List<Genre>> getGenres(MediaType type) async {
    final key = 'genres:${type.value}:$_language';
    try {
      final data = await _withCache(
        key,
        () => client.genres(type.value),
        allowOfflineFallback: false,
      );
      final response = TmdbGenreResponse.fromJson(data.data);
      final genres = TmdbMapper.genresFromResponse(response);
      return genres.isEmpty
          ? (type == MediaType.movie ? GenreCatalog.movies : GenreCatalog.tv)
          : genres;
    } on Object {
      return type == MediaType.movie ? GenreCatalog.movies : GenreCatalog.tv;
    }
  }

  @override
  Future<ImageConfig> getImageConfig() async {
    const key = 'configuration';
    try {
      final data = await _withCache(
        key,
        client.configuration,
        allowOfflineFallback: false,
      );
      final response = TmdbConfigurationResponse.fromJson(data.data);
      return TmdbMapper.imageConfig(response);
    } on Object {
      final cached = await cache.read(key);
      if (cached != null) {
        try {
          return TmdbMapper.imageConfig(
            TmdbConfigurationResponse.fromJson(cached.data),
          );
        } on Object {
          return fallbackImageConfig;
        }
      }
      return fallbackImageConfig;
    }
  }

  Future<_DataWithOrigin> _withCache(
    String key,
    Future<Map<String, dynamic>> Function() remote, {
    bool allowOfflineFallback = true,
  }) async {
    try {
      final data = await remote();
      await cache.write(key, data);
      return _DataWithOrigin(data, fromCache: false);
    } on ApiConfigurationException {
      rethrow;
    } on AppException catch (error) {
      if (!allowOfflineFallback) rethrow;
      final cached = await cache.read(key);
      if (cached != null) {
        return _DataWithOrigin(cached.data, fromCache: true);
      }
      if (error is NetworkException) {
        throw OfflineCacheMissException(cause: error);
      }
      rethrow;
    } on Object catch (error) {
      throw InvalidResponseException(cause: error);
    }
  }
}

class _DataWithOrigin {
  const _DataWithOrigin(this.data, {required this.fromCache});

  final Map<String, dynamic> data;
  final bool fromCache;
}

class UnconfiguredMediaRepository implements MediaRepository {
  const UnconfiguredMediaRepository();

  @override
  Future<MediaPage> search({
    required String query,
    required MediaType type,
    int page = 1,
  }) {
    throw const ApiConfigurationException();
  }

  @override
  Future<MediaDetails> getDetails({
    required MediaType type,
    required int tmdbId,
  }) {
    throw const ApiConfigurationException();
  }

  @override
  Future<List<Genre>> getGenres(MediaType type) async {
    return type == MediaType.movie ? GenreCatalog.movies : GenreCatalog.tv;
  }

  @override
  Future<ImageConfig> getImageConfig() async => ImageConfig.fallback;
}
