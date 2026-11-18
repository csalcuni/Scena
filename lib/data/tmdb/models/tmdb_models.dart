import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_models.freezed.dart';
part 'tmdb_models.g.dart';

@freezed
abstract class TmdbGenreDto with _$TmdbGenreDto {
  const factory TmdbGenreDto({
    required int id,
    @Default('') String name,
  }) = _TmdbGenreDto;

  factory TmdbGenreDto.fromJson(Map<String, dynamic> json) =>
      _$TmdbGenreDtoFromJson(json);
}

@freezed
abstract class TmdbGenreResponse with _$TmdbGenreResponse {
  const factory TmdbGenreResponse({
    @Default(<TmdbGenreDto>[]) List<TmdbGenreDto> genres,
  }) = _TmdbGenreResponse;

  factory TmdbGenreResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbGenreResponseFromJson(json);
}

@freezed
abstract class TmdbMovieSummary with _$TmdbMovieSummary {
  const factory TmdbMovieSummary({
    @Default(false) bool adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'genre_ids') @Default(<int>[]) List<int> genreIds,
    required int id,
    @JsonKey(name: 'original_title') @Default('') String originalTitle,
    @Default('') String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') @Default('') String releaseDate,
    @Default('') String title,
    @JsonKey(name: 'vote_average') @Default(0) double voteAverage,
  }) = _TmdbMovieSummary;

  factory TmdbMovieSummary.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieSummaryFromJson(json);
}

@freezed
abstract class TmdbTvSummary with _$TmdbTvSummary {
  const factory TmdbTvSummary({
    @Default(false) bool adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'first_air_date') @Default('') String firstAirDate,
    @JsonKey(name: 'genre_ids') @Default(<int>[]) List<int> genreIds,
    required int id,
    @Default('') String name,
    @JsonKey(name: 'original_name') @Default('') String originalName,
    @Default('') String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'vote_average') @Default(0) double voteAverage,
  }) = _TmdbTvSummary;

  factory TmdbTvSummary.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvSummaryFromJson(json);
}

@freezed
abstract class TmdbMovieSearchResponse with _$TmdbMovieSearchResponse {
  const factory TmdbMovieSearchResponse({
    @Default(1) int page,
    @Default(<TmdbMovieSummary>[]) List<TmdbMovieSummary> results,
    @JsonKey(name: 'total_pages') @Default(0) int totalPages,
    @JsonKey(name: 'total_results') @Default(0) int totalResults,
  }) = _TmdbMovieSearchResponse;

  factory TmdbMovieSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieSearchResponseFromJson(json);
}

@freezed
abstract class TmdbTvSearchResponse with _$TmdbTvSearchResponse {
  const factory TmdbTvSearchResponse({
    @Default(1) int page,
    @Default(<TmdbTvSummary>[]) List<TmdbTvSummary> results,
    @JsonKey(name: 'total_pages') @Default(0) int totalPages,
    @JsonKey(name: 'total_results') @Default(0) int totalResults,
  }) = _TmdbTvSearchResponse;

  factory TmdbTvSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvSearchResponseFromJson(json);
}

@freezed
abstract class TmdbCastMember with _$TmdbCastMember {
  const factory TmdbCastMember({
    required int id,
    @Default('') String name,
    String? character,
    @JsonKey(name: 'profile_path') String? profilePath,
    @Default(0) int order,
  }) = _TmdbCastMember;

  factory TmdbCastMember.fromJson(Map<String, dynamic> json) =>
      _$TmdbCastMemberFromJson(json);
}

@freezed
abstract class TmdbCrewMember with _$TmdbCrewMember {
  const factory TmdbCrewMember({
    required int id,
    @Default('') String name,
    @Default('') String job,
    @JsonKey(name: 'profile_path') String? profilePath,
  }) = _TmdbCrewMember;

  factory TmdbCrewMember.fromJson(Map<String, dynamic> json) =>
      _$TmdbCrewMemberFromJson(json);
}

@freezed
abstract class TmdbCredits with _$TmdbCredits {
  const factory TmdbCredits({
    @Default(<TmdbCastMember>[]) List<TmdbCastMember> cast,
    @Default(<TmdbCrewMember>[]) List<TmdbCrewMember> crew,
  }) = _TmdbCredits;

  factory TmdbCredits.fromJson(Map<String, dynamic> json) =>
      _$TmdbCreditsFromJson(json);
}

@freezed
abstract class TmdbMovieDetails with _$TmdbMovieDetails {
  const factory TmdbMovieDetails({
    required int id,
    @Default('') String title,
    @JsonKey(name: 'original_title') @Default('') String originalTitle,
    @Default('') String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'release_date') @Default('') String releaseDate,
    int? runtime,
    @Default(<TmdbGenreDto>[]) List<TmdbGenreDto> genres,
    @JsonKey(name: 'vote_average') @Default(0) double voteAverage,
    @Default(false) bool adult,
    TmdbCredits? credits,
  }) = _TmdbMovieDetails;

  factory TmdbMovieDetails.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieDetailsFromJson(json);
}

@freezed
abstract class TmdbCreatedBy with _$TmdbCreatedBy {
  const factory TmdbCreatedBy({
    required int id,
    @Default('') String name,
    @JsonKey(name: 'profile_path') String? profilePath,
  }) = _TmdbCreatedBy;

  factory TmdbCreatedBy.fromJson(Map<String, dynamic> json) =>
      _$TmdbCreatedByFromJson(json);
}

@freezed
abstract class TmdbTvDetails with _$TmdbTvDetails {
  const factory TmdbTvDetails({
    required int id,
    @Default('') String name,
    @JsonKey(name: 'original_name') @Default('') String originalName,
    @Default('') String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'first_air_date') @Default('') String firstAirDate,
    @JsonKey(name: 'episode_run_time') @Default(<int>[]) List<int> episodeRunTime,
    @Default(<TmdbGenreDto>[]) List<TmdbGenreDto> genres,
    @JsonKey(name: 'vote_average') @Default(0) double voteAverage,
    @JsonKey(name: 'number_of_seasons') int? numberOfSeasons,
    @JsonKey(name: 'number_of_episodes') int? numberOfEpisodes,
    @Default('') String status,
    @JsonKey(name: 'created_by') @Default(<TmdbCreatedBy>[]) List<TmdbCreatedBy> createdBy,
    @Default(<String>[]) List<String> originCountry,
    @Default(false) bool adult,
    TmdbCredits? credits,
  }) = _TmdbTvDetails;

  factory TmdbTvDetails.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvDetailsFromJson(json);
}

@freezed
abstract class TmdbImageConfiguration with _$TmdbImageConfiguration {
  const factory TmdbImageConfiguration({
    @JsonKey(name: 'base_url') @Default('') String baseUrl,
    @JsonKey(name: 'secure_base_url') @Default('') String secureBaseUrl,
    @JsonKey(name: 'poster_sizes') @Default(<String>[]) List<String> posterSizes,
    @JsonKey(name: 'backdrop_sizes') @Default(<String>[]) List<String> backdropSizes,
    @JsonKey(name: 'profile_sizes') @Default(<String>[]) List<String> profileSizes,
  }) = _TmdbImageConfiguration;

  factory TmdbImageConfiguration.fromJson(Map<String, dynamic> json) =>
      _$TmdbImageConfigurationFromJson(json);
}

@freezed
abstract class TmdbConfigurationResponse with _$TmdbConfigurationResponse {
  const factory TmdbConfigurationResponse({
    TmdbImageConfiguration? images,
  }) = _TmdbConfigurationResponse;

  factory TmdbConfigurationResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbConfigurationResponseFromJson(json);
}
