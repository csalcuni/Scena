import 'dart:convert';

import 'enums.dart';
import 'media_item.dart';

class LibraryEntry {
  const LibraryEntry({
    required this.id,
    required this.mediaItemId,
    required this.status,
    this.personalRating,
    this.personalNote,
    this.tags = const [],
    this.currentSeason,
    this.currentEpisode,
    required this.lastActivityAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int mediaItemId;
  final LibraryStatus status;
  final int? personalRating;
  final String? personalNote;
  final List<String> tags;

  /// Per le serie indica il prossimo episodio da guardare (non l'ultimo visto).
  final int? currentSeason;
  final int? currentEpisode;
  final DateTime lastActivityAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  String? get nextEpisodeLabel {
    if (currentSeason == null || currentEpisode == null) return null;
    return 'S${currentSeason.toString().padLeft(2, '0')} · '
        'E${currentEpisode.toString().padLeft(2, '0')}';
  }

  LibraryEntry copyWith({
    int? id,
    int? mediaItemId,
    LibraryStatus? status,
    int? personalRating,
    bool clearRating = false,
    String? personalNote,
    bool clearNote = false,
    List<String>? tags,
    int? currentSeason,
    int? currentEpisode,
    DateTime? lastActivityAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LibraryEntry(
      id: id ?? this.id,
      mediaItemId: mediaItemId ?? this.mediaItemId,
      status: status ?? this.status,
      personalRating:
          clearRating ? null : (personalRating ?? this.personalRating),
      personalNote: clearNote ? null : (personalNote ?? this.personalNote),
      tags: tags ?? this.tags,
      currentSeason: currentSeason ?? this.currentSeason,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static List<String> tagsFromJson(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded.whereType<String>().toList(growable: false);
  }

  static String tagsToJson(List<String> tags) => jsonEncode(tags);
}

class LibraryEntryWithMedia {
  const LibraryEntryWithMedia({required this.entry, required this.media});

  final LibraryEntry entry;
  final MediaItem media;

  String get key => media.key;

  LibraryEntryWithMedia copyWith({LibraryEntry? entry, MediaItem? media}) {
    return LibraryEntryWithMedia(
      entry: entry ?? this.entry,
      media: media ?? this.media,
    );
  }
}
