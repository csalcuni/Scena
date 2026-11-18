import 'enums.dart';

class DismissedSuggestion {
  const DismissedSuggestion({
    this.id,
    required this.tmdbId,
    required this.mediaType,
    required this.reason,
    required this.dismissedAt,
  });

  final int? id;
  final int tmdbId;
  final MediaType mediaType;
  final String reason;
  final DateTime dismissedAt;

  String get key => '${mediaType.value}:$tmdbId';
}
