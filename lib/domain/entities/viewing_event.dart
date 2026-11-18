import 'enums.dart';

class ViewingEvent {
  const ViewingEvent({
    this.id,
    required this.libraryEntryId,
    required this.eventType,
    this.season,
    this.episode,
    required this.occurredAt,
    this.note,
  });

  final int? id;
  final int libraryEntryId;
  final ViewingEventType eventType;
  final int? season;
  final int? episode;
  final DateTime occurredAt;
  final String? note;
}
