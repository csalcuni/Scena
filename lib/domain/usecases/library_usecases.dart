import '../entities/enums.dart';
import '../entities/library_entry.dart';
import '../entities/media_item.dart';
import '../entities/viewing_event.dart';
import '../repositories/library_repository.dart';

class AddToLibrary {
  const AddToLibrary(this._library, this._events);

  final LibraryRepository _library;
  final ViewingEventRepository _events;

  Future<LibraryEntryWithMedia> call(
    MediaItem media, {
    LibraryStatus status = LibraryStatus.toWatch,
    Set<int> listIds = const {},
    DateTime? now,
  }) async {
    final existing = await _library.findByMedia(
      type: media.mediaType,
      tmdbId: media.tmdbId,
    );
    final timestamp = now ?? DateTime.now();
    final isTv = media.mediaType == MediaType.tv;
    final result = await _library.addMedia(
      media: media,
      status: existing?.entry.status ?? status,
      currentSeason: isTv ? (existing?.entry.currentSeason ?? 1) : null,
      currentEpisode: isTv ? (existing?.entry.currentEpisode ?? 1) : null,
      listIds: listIds,
    );

    if (existing == null && status == LibraryStatus.inProgress) {
      await _events.add(
        ViewingEvent(
          libraryEntryId: result.entry.id,
          eventType: ViewingEventType.started,
          occurredAt: timestamp,
        ),
      );
    }
    return result;
  }
}

class ChangeLibraryStatus {
  const ChangeLibraryStatus(this._library, this._events);

  final LibraryRepository _library;
  final ViewingEventRepository _events;

  Future<LibraryEntry> call(
    LibraryEntryWithMedia item,
    LibraryStatus status, {
    String? note,
    DateTime? now,
  }) async {
    final timestamp = now ?? DateTime.now();
    final isTv = item.media.mediaType == MediaType.tv;
    var nextSeason = item.entry.currentSeason;
    var nextEpisode = item.entry.currentEpisode;
    if (isTv && status == LibraryStatus.inProgress) {
      nextSeason ??= 1;
      nextEpisode ??= 1;
    }
    final updated = item.entry.copyWith(
      status: status,
      currentSeason: nextSeason,
      currentEpisode: nextEpisode,
      lastActivityAt: timestamp,
      updatedAt: timestamp,
      personalNote: note,
    );
    await _library.saveEntry(updated);

    ViewingEventType? eventType;
    switch (status) {
      case LibraryStatus.inProgress:
        eventType = item.entry.status == LibraryStatus.paused
            ? ViewingEventType.resumed
            : ViewingEventType.started;
      case LibraryStatus.paused:
        eventType = ViewingEventType.paused;
      case LibraryStatus.completed:
        eventType = ViewingEventType.completed;
      case LibraryStatus.abandoned:
        eventType = ViewingEventType.abandoned;
      case LibraryStatus.toWatch:
        eventType = null;
    }

    if (eventType != null) {
      await _events.add(
        ViewingEvent(
          libraryEntryId: item.entry.id,
          eventType: eventType,
          season: isTv ? item.entry.currentSeason : null,
          episode: isTv ? item.entry.currentEpisode : null,
          occurredAt: timestamp,
          note: note,
        ),
      );
    }
    return updated;
  }
}

class UpdateLibraryEntry {
  const UpdateLibraryEntry(this._library);

  final LibraryRepository _library;

  Future<LibraryEntry> call(
    LibraryEntry entry, {
    LibraryStatus? status,
    int? rating,
    bool clearRating = false,
    String? note,
    bool clearNote = false,
    List<String>? tags,
    int? currentSeason,
    int? currentEpisode,
    DateTime? now,
  }) {
    final timestamp = now ?? DateTime.now();
    return _library.saveEntry(
      entry.copyWith(
        status: status,
        personalRating: rating,
        clearRating: clearRating,
        personalNote: note,
        clearNote: clearNote,
        tags: tags,
        currentSeason: currentSeason,
        currentEpisode: currentEpisode,
        lastActivityAt: timestamp,
        updatedAt: timestamp,
      ),
    );
  }
}

class MarkEpisodeWatched {
  const MarkEpisodeWatched(this._library, this._events);

  final LibraryRepository _library;
  final ViewingEventRepository _events;

  Future<LibraryEntryWithMedia> call(
    LibraryEntryWithMedia item, {
    DateTime? now,
  }) async {
    if (item.media.mediaType != MediaType.tv) {
      throw ArgumentError('Solo le serie hanno episodi.');
    }
    final timestamp = now ?? DateTime.now();
    final season = item.entry.currentSeason ?? 1;
    final episode = item.entry.currentEpisode ?? 1;
    final updated = item.entry.copyWith(
      status: LibraryStatus.inProgress,
      currentSeason: season,
      currentEpisode: episode + 1,
      lastActivityAt: timestamp,
      updatedAt: timestamp,
    );
    await _library.saveEntry(updated);
    await _events.add(
      ViewingEvent(
        libraryEntryId: item.entry.id,
        eventType: ViewingEventType.episodeWatched,
        season: season,
        episode: episode,
        occurredAt: timestamp,
      ),
    );
    return item.copyWith(entry: updated);
  }
}

class MarkWatched {
  const MarkWatched(this._library, this._events);

  final LibraryRepository _library;
  final ViewingEventRepository _events;

  Future<LibraryEntry> call(
    LibraryEntryWithMedia item, {
    DateTime? now,
  }) {
    if (item.media.mediaType == MediaType.tv) {
      return MarkEpisodeWatched(_library, _events)
          .call(item, now: now)
          .then((value) => value.entry);
    }
    final timestamp = now ?? DateTime.now();
    final updated = item.entry.copyWith(
      status: LibraryStatus.completed,
      lastActivityAt: timestamp,
      updatedAt: timestamp,
    );
    return _library.saveEntry(updated).then((entry) async {
      await _events.add(
        ViewingEvent(
          libraryEntryId: entry.id,
          eventType: ViewingEventType.completed,
          occurredAt: timestamp,
        ),
      );
      return entry;
    });
  }
}
