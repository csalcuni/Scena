import 'dart:convert';

import 'enums.dart';

class Genre {
  const Genre({required this.id, required this.name});

  final int id;
  final String name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
    );
  }

  static List<Genre> listFromJson(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Genre.fromJson)
        .toList(growable: false);
  }

  static String listToJson(List<Genre> genres) {
    return jsonEncode(genres.map((genre) => genre.toJson()).toList());
  }

  @override
  bool operator ==(Object other) =>
      other is Genre && other.id == id && other.name == name;

  @override
  int get hashCode => Object.hash(id, name);
}

class MediaItem {
  const MediaItem({
    this.localId,
    required this.tmdbId,
    required this.mediaType,
    required this.title,
    this.originalTitle,
    this.posterPath,
    this.backdropPath,
    this.overview = '',
    this.releaseDate,
    this.runtimeMinutes,
    this.genres = const [],
    this.tmdbVoteAverage = 0,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.episodeRuntimeMinutes,
    this.tvStatus,
    this.isAdult = false,
    this.createdAt,
    this.updatedAt,
  });

  final int? localId;
  final int tmdbId;
  final MediaType mediaType;
  final String title;
  final String? originalTitle;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final DateTime? releaseDate;
  final int? runtimeMinutes;
  final List<Genre> genres;
  final double tmdbVoteAverage;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final int? episodeRuntimeMinutes;
  final String? tvStatus;
  final bool isAdult;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String get key => '${mediaType.value}:$tmdbId';
  int? get releaseYear => releaseDate?.year;
  Set<int> get genreIds => genres.map((genre) => genre.id).toSet();

  bool get hasKnownDuration => estimatedMinutes(null) != null;

  int? estimatedMinutes(int? fallbackEpisodeMinutes) {
    if (mediaType == MediaType.movie) return runtimeMinutes;
    return episodeRuntimeMinutes ?? fallbackEpisodeMinutes;
  }

  String durationLabel({int? fallbackEpisodeMinutes}) {
    if (mediaType == MediaType.tv) {
      final episodeMinutes =
          episodeRuntimeMinutes ?? fallbackEpisodeMinutes ?? 45;
      final count = numberOfEpisodes;
      if (count != null && count > 0) {
        return '$count ep. · ~$episodeMinutes min/ep';
      }
      return '~$episodeMinutes min/ep';
    }
    final runtime = runtimeMinutes;
    if (runtime == null || runtime <= 0) return 'Durata sconosciuta';
    return formatMinutes(runtime);
  }

  MediaItem copyWith({
    int? localId,
    int? tmdbId,
    MediaType? mediaType,
    String? title,
    String? originalTitle,
    String? posterPath,
    String? backdropPath,
    String? overview,
    DateTime? releaseDate,
    int? runtimeMinutes,
    List<Genre>? genres,
    double? tmdbVoteAverage,
    int? numberOfSeasons,
    int? numberOfEpisodes,
    int? episodeRuntimeMinutes,
    String? tvStatus,
    bool? isAdult,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MediaItem(
      localId: localId ?? this.localId,
      tmdbId: tmdbId ?? this.tmdbId,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      runtimeMinutes: runtimeMinutes ?? this.runtimeMinutes,
      genres: genres ?? this.genres,
      tmdbVoteAverage: tmdbVoteAverage ?? this.tmdbVoteAverage,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      episodeRuntimeMinutes:
          episodeRuntimeMinutes ?? this.episodeRuntimeMinutes,
      tvStatus: tvStatus ?? this.tvStatus,
      isAdult: isAdult ?? this.isAdult,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CastMember {
  const CastMember({
    required this.name,
    this.character,
    this.profilePath,
  });

  final String name;
  final String? character;
  final String? profilePath;
}

class MediaDetails {
  const MediaDetails({
    required this.media,
    this.cast = const [],
    this.directors = const [],
    this.isFromCache = false,
  });

  final MediaItem media;
  final List<CastMember> cast;
  final List<String> directors;
  final bool isFromCache;
}

class MediaPage {
  const MediaPage({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.totalResults,
    this.isFromCache = false,
  });

  final List<MediaItem> items;
  final int page;
  final int totalPages;
  final int totalResults;
  final bool isFromCache;

  bool get hasNextPage => page < totalPages;
}

class ImageConfig {
  const ImageConfig({
    required this.baseUrl,
    this.posterSize = 'w500',
    this.backdropSize = 'w780',
    this.profileSize = 'w185',
  });

  static const fallback = ImageConfig(
    baseUrl: 'https://image.tmdb.org/t/p/',
  );

  final String baseUrl;
  final String posterSize;
  final String backdropSize;
  final String profileSize;

  String? posterUrl(String? path) => _url(path, posterSize);
  String? backdropUrl(String? path) => _url(path, backdropSize);
  String? profileUrl(String? path) => _url(path, profileSize);

  String? _url(String? path, String size) {
    final value = path?.trim();
    if (value == null || value.isEmpty) return null;
    return '$baseUrl$size$value';
  }
}

String formatMinutes(int minutes) {
  if (minutes < 60) return '$minutes min';
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  return rest == 0 ? '${hours}h' : '${hours}h ${rest}min';
}
