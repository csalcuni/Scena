import 'dart:convert';

import 'enums.dart';

class HardExclusions {
  const HardExclusions({
    this.keywords = const [],
    this.genreIds = const [],
    this.mediaTypes = const [],
  });

  final List<String> keywords;
  final List<int> genreIds;
  final List<MediaType> mediaTypes;

  bool get isEmpty =>
      keywords.isEmpty && genreIds.isEmpty && mediaTypes.isEmpty;

  bool blocks({
    required String title,
    required String overview,
    required MediaType mediaType,
    required Set<int> genres,
    List<String> tags = const [],
  }) {
    if (mediaTypes.contains(mediaType)) return true;
    if (genres.any(genreIds.contains)) return true;
    if (keywords.isEmpty) return false;
    final haystack = [
      title,
      overview,
      ...tags,
    ].join(' ').toLowerCase();
    return keywords
        .map((keyword) => keyword.trim().toLowerCase())
        .where((keyword) => keyword.isNotEmpty)
        .any(haystack.contains);
  }

  HardExclusions copyWith({
    List<String>? keywords,
    List<int>? genreIds,
    List<MediaType>? mediaTypes,
  }) {
    return HardExclusions(
      keywords: keywords ?? this.keywords,
      genreIds: genreIds ?? this.genreIds,
      mediaTypes: mediaTypes ?? this.mediaTypes,
    );
  }

  Map<String, dynamic> toJson() => {
        'keywords': keywords,
        'genreIds': genreIds,
        'mediaTypes': mediaTypes.map((type) => type.value).toList(),
      };

  factory HardExclusions.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HardExclusions();
    return HardExclusions(
      keywords: (json['keywords'] as List? ?? const [])
          .whereType<String>()
          .toList(growable: false),
      genreIds: (json['genreIds'] as List? ?? const [])
          .whereType<num>()
          .map((id) => id.toInt())
          .toList(growable: false),
      mediaTypes: (json['mediaTypes'] as List? ?? const [])
          .whereType<String>()
          .map(MediaType.fromValue)
          .toList(growable: false),
    );
  }
}

class UserPreferences {
  const UserPreferences({
    this.streamingServices = const [],
    this.preferredGenres = const [],
    this.avoidedGenres = const [],
    this.preferredRuntimeMinutes = 120,
    this.hardExclusions = const HardExclusions(),
    this.themeMode = AppThemeMode.system,
    this.onboardingCompleted = false,
  });

  final List<String> streamingServices;
  final List<int> preferredGenres;
  final List<int> avoidedGenres;
  final int preferredRuntimeMinutes;
  final HardExclusions hardExclusions;
  final AppThemeMode themeMode;
  final bool onboardingCompleted;

  UserPreferences copyWith({
    List<String>? streamingServices,
    List<int>? preferredGenres,
    List<int>? avoidedGenres,
    int? preferredRuntimeMinutes,
    HardExclusions? hardExclusions,
    AppThemeMode? themeMode,
    bool? onboardingCompleted,
  }) {
    return UserPreferences(
      streamingServices: streamingServices ?? this.streamingServices,
      preferredGenres: preferredGenres ?? this.preferredGenres,
      avoidedGenres: avoidedGenres ?? this.avoidedGenres,
      preferredRuntimeMinutes:
          preferredRuntimeMinutes ?? this.preferredRuntimeMinutes,
      hardExclusions: hardExclusions ?? this.hardExclusions,
      themeMode: themeMode ?? this.themeMode,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'streamingServices': streamingServices,
        'preferredGenres': preferredGenres,
        'avoidedGenres': avoidedGenres,
        'preferredRuntimeMinutes': preferredRuntimeMinutes,
        'hardExclusions': hardExclusions.toJson(),
        'themeMode': themeMode.value,
        'onboardingCompleted': onboardingCompleted,
      };

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      streamingServices: (json['streamingServices'] as List? ?? const [])
          .whereType<String>()
          .toList(growable: false),
      preferredGenres: (json['preferredGenres'] as List? ?? const [])
          .whereType<num>()
          .map((id) => id.toInt())
          .toList(growable: false),
      avoidedGenres: (json['avoidedGenres'] as List? ?? const [])
          .whereType<num>()
          .map((id) => id.toInt())
          .toList(growable: false),
      preferredRuntimeMinutes:
          (json['preferredRuntimeMinutes'] as num?)?.toInt() ?? 120,
      hardExclusions: HardExclusions.fromJson(
        json['hardExclusions'] as Map<String, dynamic>?,
      ),
      themeMode: AppThemeMode.fromValue(json['themeMode'] as String? ?? 'system'),
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
    );
  }

  static List<String> decodeStringList(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded.whereType<String>().toList(growable: false);
  }

  static List<int> decodeIntList(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded
        .whereType<num>()
        .map((id) => id.toInt())
        .toList(growable: false);
  }
}
