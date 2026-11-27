import 'enums.dart';
import 'library_entry.dart';
import 'media_item.dart';

class EveningRequest {
  const EveningRequest({
    this.availableMinutes,
    this.mood = Mood.light,
    this.context = ViewingContext.solo,
    this.noHorror = false,
    this.noRomance = false,
    this.familyOnly = false,
    this.subtitlesAccepted = true,
    this.listIds = const {},
  });

  /// `null` significa tempo illimitato.
  final int? availableMinutes;
  final Mood mood;
  final ViewingContext context;
  final bool noHorror;
  final bool noRomance;
  final bool familyOnly;
  final bool subtitlesAccepted;

  /// Liste da cui scegliere le proposte. Vuoto significa tutte le liste.
  final Set<int> listIds;

  bool get unlimited => availableMinutes == null;

  String get timeLabel => availableMinutes == null
      ? 'Tempo illimitato'
      : '$availableMinutes minuti';

  EveningRequest copyWith({
    int? availableMinutes,
    bool clearAvailableMinutes = false,
    Mood? mood,
    ViewingContext? context,
    bool? noHorror,
    bool? noRomance,
    bool? familyOnly,
    bool? subtitlesAccepted,
    Set<int>? listIds,
  }) {
    return EveningRequest(
      availableMinutes: clearAvailableMinutes
          ? null
          : (availableMinutes ?? this.availableMinutes),
      mood: mood ?? this.mood,
      context: context ?? this.context,
      noHorror: noHorror ?? this.noHorror,
      noRomance: noRomance ?? this.noRomance,
      familyOnly: familyOnly ?? this.familyOnly,
      subtitlesAccepted: subtitlesAccepted ?? this.subtitlesAccepted,
      listIds: listIds ?? this.listIds,
    );
  }
}

class Suggestion {
  const Suggestion({
    required this.media,
    this.entry,
    required this.score,
    required this.reason,
    required this.status,
    this.isTooLong = false,
    this.isDurationUnknown = false,
    required this.estimatedMinutes,
  });

  final MediaItem media;
  final LibraryEntry? entry;
  final double score;
  final String reason;
  final SuggestionStatus status;
  final bool isTooLong;
  final bool isDurationUnknown;
  final int? estimatedMinutes;

  bool get isInLibrary => entry != null;
  String get key => media.key;

  Suggestion withEntry(LibraryEntry? value) {
    return Suggestion(
      media: media,
      entry: value,
      score: score,
      reason: reason,
      status: status,
      isTooLong: isTooLong,
      isDurationUnknown: isDurationUnknown,
      estimatedMinutes: estimatedMinutes,
    );
  }
}

class RecommendationResult {
  const RecommendationResult({
    required this.suggestions,
    this.relaxationNote,
    this.relaxed = false,
    this.totalEligible = 0,
  });

  final List<Suggestion> suggestions;
  final String? relaxationNote;
  final bool relaxed;
  final int totalEligible;

  bool get isEmpty => suggestions.isEmpty;
}

class SurprisePick {
  const SurprisePick({
    required this.candidate,
    required this.reason,
    this.exhausted = false,
  });

  final LibraryEntryWithMedia? candidate;
  final String reason;
  final bool exhausted;

  bool get hasPick => candidate != null;
}
