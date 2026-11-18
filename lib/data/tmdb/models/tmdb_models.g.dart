// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TmdbGenreDto _$TmdbGenreDtoFromJson(Map<String, dynamic> json) =>
    _TmdbGenreDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$TmdbGenreDtoToJson(_TmdbGenreDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_TmdbGenreResponse _$TmdbGenreResponseFromJson(Map<String, dynamic> json) =>
    _TmdbGenreResponse(
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => TmdbGenreDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TmdbGenreDto>[],
    );

Map<String, dynamic> _$TmdbGenreResponseToJson(_TmdbGenreResponse instance) =>
    <String, dynamic>{'genres': instance.genres};

_TmdbMovieSummary _$TmdbMovieSummaryFromJson(Map<String, dynamic> json) =>
    _TmdbMovieSummary(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      id: (json['id'] as num).toInt(),
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String? ?? '',
      title: json['title'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$TmdbMovieSummaryToJson(_TmdbMovieSummary instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'vote_average': instance.voteAverage,
    };

_TmdbTvSummary _$TmdbTvSummaryFromJson(Map<String, dynamic> json) =>
    _TmdbTvSummary(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] as String? ?? '',
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$TmdbTvSummaryToJson(_TmdbTvSummary instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
    };

_TmdbMovieSearchResponse _$TmdbMovieSearchResponseFromJson(
  Map<String, dynamic> json,
) => _TmdbMovieSearchResponse(
  page: (json['page'] as num?)?.toInt() ?? 1,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => TmdbMovieSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TmdbMovieSummary>[],
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
  totalResults: (json['total_results'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TmdbMovieSearchResponseToJson(
  _TmdbMovieSearchResponse instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};

_TmdbTvSearchResponse _$TmdbTvSearchResponseFromJson(
  Map<String, dynamic> json,
) => _TmdbTvSearchResponse(
  page: (json['page'] as num?)?.toInt() ?? 1,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => TmdbTvSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TmdbTvSummary>[],
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
  totalResults: (json['total_results'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TmdbTvSearchResponseToJson(
  _TmdbTvSearchResponse instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};

_TmdbCastMember _$TmdbCastMemberFromJson(Map<String, dynamic> json) =>
    _TmdbCastMember(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      character: json['character'] as String?,
      profilePath: json['profile_path'] as String?,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TmdbCastMemberToJson(_TmdbCastMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.profilePath,
      'order': instance.order,
    };

_TmdbCrewMember _$TmdbCrewMemberFromJson(Map<String, dynamic> json) =>
    _TmdbCrewMember(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      job: json['job'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$TmdbCrewMemberToJson(_TmdbCrewMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'job': instance.job,
      'profile_path': instance.profilePath,
    };

_TmdbCredits _$TmdbCreditsFromJson(Map<String, dynamic> json) => _TmdbCredits(
  cast:
      (json['cast'] as List<dynamic>?)
          ?.map((e) => TmdbCastMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TmdbCastMember>[],
  crew:
      (json['crew'] as List<dynamic>?)
          ?.map((e) => TmdbCrewMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TmdbCrewMember>[],
);

Map<String, dynamic> _$TmdbCreditsToJson(_TmdbCredits instance) =>
    <String, dynamic>{'cast': instance.cast, 'crew': instance.crew};

_TmdbMovieDetails _$TmdbMovieDetailsFromJson(Map<String, dynamic> json) =>
    _TmdbMovieDetails(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String? ?? '',
      runtime: (json['runtime'] as num?)?.toInt(),
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => TmdbGenreDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TmdbGenreDto>[],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      adult: json['adult'] as bool? ?? false,
      credits: json['credits'] == null
          ? null
          : TmdbCredits.fromJson(json['credits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TmdbMovieDetailsToJson(_TmdbMovieDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'vote_average': instance.voteAverage,
      'adult': instance.adult,
      'credits': instance.credits,
    };

_TmdbCreatedBy _$TmdbCreatedByFromJson(Map<String, dynamic> json) =>
    _TmdbCreatedBy(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$TmdbCreatedByToJson(_TmdbCreatedBy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
    };

_TmdbTvDetails _$TmdbTvDetailsFromJson(Map<String, dynamic> json) =>
    _TmdbTvDetails(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] as String? ?? '',
      episodeRunTime:
          (json['episode_run_time'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => TmdbGenreDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TmdbGenreDto>[],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt(),
      numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt(),
      status: json['status'] as String? ?? '',
      createdBy:
          (json['created_by'] as List<dynamic>?)
              ?.map((e) => TmdbCreatedBy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TmdbCreatedBy>[],
      originCountry:
          (json['originCountry'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      adult: json['adult'] as bool? ?? false,
      credits: json['credits'] == null
          ? null
          : TmdbCredits.fromJson(json['credits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TmdbTvDetailsToJson(_TmdbTvDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate,
      'episode_run_time': instance.episodeRunTime,
      'genres': instance.genres,
      'vote_average': instance.voteAverage,
      'number_of_seasons': instance.numberOfSeasons,
      'number_of_episodes': instance.numberOfEpisodes,
      'status': instance.status,
      'created_by': instance.createdBy,
      'originCountry': instance.originCountry,
      'adult': instance.adult,
      'credits': instance.credits,
    };

_TmdbImageConfiguration _$TmdbImageConfigurationFromJson(
  Map<String, dynamic> json,
) => _TmdbImageConfiguration(
  baseUrl: json['base_url'] as String? ?? '',
  secureBaseUrl: json['secure_base_url'] as String? ?? '',
  posterSizes:
      (json['poster_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  backdropSizes:
      (json['backdrop_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  profileSizes:
      (json['profile_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$TmdbImageConfigurationToJson(
  _TmdbImageConfiguration instance,
) => <String, dynamic>{
  'base_url': instance.baseUrl,
  'secure_base_url': instance.secureBaseUrl,
  'poster_sizes': instance.posterSizes,
  'backdrop_sizes': instance.backdropSizes,
  'profile_sizes': instance.profileSizes,
};

_TmdbConfigurationResponse _$TmdbConfigurationResponseFromJson(
  Map<String, dynamic> json,
) => _TmdbConfigurationResponse(
  images: json['images'] == null
      ? null
      : TmdbImageConfiguration.fromJson(json['images'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TmdbConfigurationResponseToJson(
  _TmdbConfigurationResponse instance,
) => <String, dynamic>{'images': instance.images};
