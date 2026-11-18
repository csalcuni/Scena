import '../../../domain/entities/enums.dart';
import '../../../domain/entities/genre_catalog.dart';
import '../../../domain/entities/media_item.dart';
import '../models/tmdb_models.dart';

abstract final class TmdbMapper {
  static MediaPage movieSearchPage(TmdbMovieSearchResponse response) {
    return MediaPage(
      items: response.results.map(movieSummary).toList(growable: false),
      page: response.page,
      totalPages: response.totalPages,
      totalResults: response.totalResults,
    );
  }

  static MediaPage tvSearchPage(TmdbTvSearchResponse response) {
    return MediaPage(
      items: response.results.map(tvSummary).toList(growable: false),
      page: response.page,
      totalPages: response.totalPages,
      totalResults: response.totalResults,
    );
  }

  static MediaItem movieSummary(TmdbMovieSummary dto) {
    return MediaItem(
      tmdbId: dto.id,
      mediaType: MediaType.movie,
      title: dto.title.isEmpty ? dto.originalTitle : dto.title,
      originalTitle: dto.originalTitle,
      posterPath: dto.posterPath,
      backdropPath: dto.backdropPath,
      overview: dto.overview,
      releaseDate: _parseDate(dto.releaseDate),
      genres: GenreCatalog.byIds(dto.genreIds),
      tmdbVoteAverage: dto.voteAverage,
      isAdult: dto.adult,
    );
  }

  static MediaItem tvSummary(TmdbTvSummary dto) {
    return MediaItem(
      tmdbId: dto.id,
      mediaType: MediaType.tv,
      title: dto.name.isEmpty ? dto.originalName : dto.name,
      originalTitle: dto.originalName,
      posterPath: dto.posterPath,
      backdropPath: dto.backdropPath,
      overview: dto.overview,
      releaseDate: _parseDate(dto.firstAirDate),
      genres: GenreCatalog.byIds(dto.genreIds),
      tmdbVoteAverage: dto.voteAverage,
      isAdult: dto.adult,
    );
  }

  static MediaDetails movieDetails(TmdbMovieDetails dto) {
    final genres = dto.genres
        .map((genre) => Genre(id: genre.id, name: genre.name))
        .toList(growable: false);
    final media = MediaItem(
      tmdbId: dto.id,
      mediaType: MediaType.movie,
      title: dto.title.isEmpty ? dto.originalTitle : dto.title,
      originalTitle: dto.originalTitle,
      posterPath: dto.posterPath,
      backdropPath: dto.backdropPath,
      overview: dto.overview,
      releaseDate: _parseDate(dto.releaseDate),
      runtimeMinutes: dto.runtime,
      genres: genres,
      tmdbVoteAverage: dto.voteAverage,
      isAdult: dto.adult,
    );
    return MediaDetails(
      media: media,
      cast: _cast(dto.credits),
      directors: _crewDirectors(dto.credits),
    );
  }

  static MediaDetails tvDetails(TmdbTvDetails dto) {
    final genres = dto.genres
        .map((genre) => Genre(id: genre.id, name: genre.name))
        .toList(growable: false);
    final positiveRuntimes =
        dto.episodeRunTime.where((value) => value > 0).toList(growable: false);
    final episodeRuntime =
        positiveRuntimes.isEmpty ? null : positiveRuntimes.first;
    final creators = dto.createdBy
        .map((creator) => creator.name)
        .where((name) => name.trim().isNotEmpty)
        .toList(growable: false);
    final crewDirectors = _crewDirectors(dto.credits);
    final media = MediaItem(
      tmdbId: dto.id,
      mediaType: MediaType.tv,
      title: dto.name.isEmpty ? dto.originalName : dto.name,
      originalTitle: dto.originalName,
      posterPath: dto.posterPath,
      backdropPath: dto.backdropPath,
      overview: dto.overview,
      releaseDate: _parseDate(dto.firstAirDate),
      genres: genres,
      tmdbVoteAverage: dto.voteAverage,
      numberOfSeasons: dto.numberOfSeasons,
      numberOfEpisodes: dto.numberOfEpisodes,
      episodeRuntimeMinutes: episodeRuntime,
      tvStatus: dto.status,
      isAdult: dto.adult,
    );
    return MediaDetails(
      media: media,
      cast: _cast(dto.credits),
      directors: [
        ...creators,
        ...crewDirectors.where((name) => !creators.contains(name)),
      ],
    );
  }

  static List<Genre> genresFromResponse(TmdbGenreResponse response) {
    return response.genres
        .map((genre) => Genre(id: genre.id, name: genre.name))
        .toList(growable: false);
  }

  static ImageConfig imageConfig(TmdbConfigurationResponse response) {
    final images = response.images;
    if (images == null) return ImageConfig.fallback;
    final baseUrl = images.secureBaseUrl.isNotEmpty
        ? images.secureBaseUrl
        : images.baseUrl.isNotEmpty
            ? images.baseUrl
            : ImageConfig.fallback.baseUrl;
    return ImageConfig(
      baseUrl: baseUrl.endsWith('/') ? baseUrl : '$baseUrl/',
      posterSize: _pickSize(images.posterSizes, 'w500'),
      backdropSize: _pickSize(images.backdropSizes, 'w780'),
      profileSize: _pickSize(images.profileSizes, 'w185'),
    );
  }

  static List<CastMember> _cast(TmdbCredits? credits) {
    final cast = credits?.cast ?? const <TmdbCastMember>[];
    return cast
        .take(8)
        .map(
          (member) => CastMember(
            name: member.name,
            character: member.character,
            profilePath: member.profilePath,
          ),
        )
        .toList(growable: false);
  }

  static List<String> _crewDirectors(TmdbCredits? credits) {
    final crew = credits?.crew ?? const <TmdbCrewMember>[];
    return crew
        .where((member) => member.job.toLowerCase() == 'director')
        .map((member) => member.name)
        .where((name) => name.trim().isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  static DateTime? _parseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }

  static String _pickSize(List<String> sizes, String preferred) {
    if (sizes.contains(preferred)) return preferred;
    if (sizes.contains('original')) return 'original';
    if (sizes.isEmpty) return preferred;
    return sizes.last;
  }
}
