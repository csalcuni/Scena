import 'package:drift/drift.dart';

import '../../../domain/entities/dismissed_suggestion.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/library_entry.dart';
import '../../../domain/entities/library_list.dart';
import '../../../domain/entities/media_item.dart';
import '../../../domain/entities/viewing_event.dart';
import '../../../domain/repositories/library_repository.dart';
import '../drift/app_database.dart';

class DriftLibraryRepository implements LibraryRepository {
  const DriftLibraryRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<LibraryEntryWithMedia>> watchAll() {
    final query = _joinQuery()
      ..orderBy([
        OrderingTerm.desc(_database.libraryEntries.lastActivityAt),
      ]);
    return query.watch().map(_mapRows);
  }

  @override
  Future<List<LibraryEntryWithMedia>> getAll() async {
    final query = _joinQuery()
      ..orderBy([
        OrderingTerm.desc(_database.libraryEntries.lastActivityAt),
      ]);
    return _mapRows(await query.get());
  }

  @override
  Future<LibraryEntryWithMedia?> findById(int id) {
    return _find(_database.libraryEntries.id.equals(id));
  }

  @override
  Future<LibraryEntryWithMedia?> findByMedia({
    required MediaType type,
    required int tmdbId,
  }) {
    return _find(
      _database.mediaItems.tmdbId.equals(tmdbId) &
          _database.mediaItems.mediaType.equals(type.value),
    );
  }

  @override
  Future<LibraryEntryWithMedia> addMedia({
    required MediaItem media,
    required LibraryStatus status,
    int? currentSeason,
    int? currentEpisode,
    Set<int> listIds = const {},
  }) async {
    return _database.transaction(() async {
      final now = DateTime.now();
      final mediaRow = await _upsertMedia(media, now);
      final existingEntry = await (_database.select(_database.libraryEntries)
            ..where((table) => table.mediaItemId.equals(mediaRow.id)))
          .getSingleOrNull();
      if (existingEntry == null) {
        await _database.into(_database.libraryEntries).insert(
              LibraryEntriesCompanion.insert(
                mediaItemId: mediaRow.id,
                status: status.value,
                currentSeason: Value(currentSeason),
                currentEpisode: Value(currentEpisode),
                lastActivityAt: now,
                createdAt: now,
                updatedAt: now,
              ),
            );
      }
      final entryRow = existingEntry ??
          await (_database.select(_database.libraryEntries)
                ..where((table) => table.mediaItemId.equals(mediaRow.id)))
              .getSingle();

      final validListIds = await _validListIds(listIds);
      final targetListIds =
          validListIds.isEmpty ? {await _defaultListId(now)} : validListIds;
      for (final listId in targetListIds) {
        await _database.into(_database.libraryListEntries).insert(
              LibraryListEntriesCompanion.insert(
                listId: listId,
                libraryEntryId: entryRow.id,
                addedAt: now,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }

      return LibraryEntryWithMedia(
        entry: _entryFromRow(
          entryRow,
          listIds: await _listIdsForEntry(entryRow.id),
        ),
        media: _mediaFromRow(mediaRow),
      );
    });
  }

  @override
  Future<LibraryEntry> saveEntry(LibraryEntry entry) async {
    await (_database.update(_database.libraryEntries)
          ..where((table) => table.id.equals(entry.id)))
        .write(
      LibraryEntriesCompanion(
        status: Value(entry.status.value),
        personalRating: Value(entry.personalRating),
        personalNote: Value(entry.personalNote),
        tagsJson: Value(LibraryEntry.tagsToJson(entry.tags)),
        currentSeason: Value(entry.currentSeason),
        currentEpisode: Value(entry.currentEpisode),
        lastActivityAt: Value(entry.lastActivityAt),
        updatedAt: Value(entry.updatedAt),
      ),
    );
    return entry;
  }

  @override
  Future<void> deleteEntry(int id) async {
    await (_database.delete(_database.libraryEntries)
          ..where((table) => table.id.equals(id)))
        .go();
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinQuery() {
    return _database.select(_database.libraryEntries).join([
      innerJoin(
        _database.mediaItems,
        _database.mediaItems.id.equalsExp(_database.libraryEntries.mediaItemId),
      ),
      leftOuterJoin(
        _database.libraryListEntries,
        _database.libraryListEntries.libraryEntryId
            .equalsExp(_database.libraryEntries.id),
      ),
    ]);
  }

  Future<LibraryEntryWithMedia?> _find(Expression<bool> predicate) async {
    final query = _joinQuery()..where(predicate);
    final rows = await query.get();
    if (rows.isEmpty) return null;
    return _mapRows(rows).first;
  }

  Future<Set<int>> _listIdsForEntry(int entryId) async {
    final rows = await (_database.select(_database.libraryListEntries)
          ..where((table) => table.libraryEntryId.equals(entryId)))
        .get();
    return rows.map((row) => row.listId).toSet();
  }

  Future<Set<int>> _validListIds(Set<int> listIds) async {
    if (listIds.isEmpty) return const {};
    final rows = await (_database.select(_database.libraryLists)
          ..where((table) => table.id.isIn(listIds)))
        .get();
    return rows.map((row) => row.id).toSet();
  }

  Future<int> _defaultListId(DateTime now) async {
    final existingDefault = await (_database.select(_database.libraryLists)
          ..where((table) => table.isDefault.equals(true)))
        .getSingleOrNull();
    if (existingDefault != null) return existingDefault.id;

    final namedDefault = await (_database.select(_database.libraryLists)
          ..where(
            (table) => table.name.lower().equals(
                  LibraryList.defaultName.toLowerCase(),
                ),
          ))
        .getSingleOrNull();
    if (namedDefault != null) {
      await (_database.update(_database.libraryLists)
            ..where((table) => table.id.equals(namedDefault.id)))
          .write(const LibraryListsCompanion(isDefault: Value(true)));
      return namedDefault.id;
    }

    return _database.into(_database.libraryLists).insert(
          LibraryListsCompanion.insert(
            name: LibraryList.defaultName,
            isDefault: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<MediaItemRow> _upsertMedia(MediaItem media, DateTime now) async {
    final existing = await (_database.select(_database.mediaItems)
          ..where(
            (table) =>
                table.tmdbId.equals(media.tmdbId) &
                table.mediaType.equals(media.mediaType.value),
          ))
        .getSingleOrNull();
    final companion = MediaItemsCompanion.insert(
      tmdbId: media.tmdbId,
      mediaType: media.mediaType.value,
      title: media.title,
      originalTitle: Value(media.originalTitle),
      posterPath: Value(media.posterPath),
      backdropPath: Value(media.backdropPath),
      overview: Value(media.overview),
      releaseDate: Value(media.releaseDate?.toIso8601String()),
      runtimeMinutes: Value(media.runtimeMinutes),
      genresJson: Value(Genre.listToJson(media.genres)),
      tmdbVoteAverage: Value(media.tmdbVoteAverage),
      numberOfSeasons: Value(media.numberOfSeasons),
      numberOfEpisodes: Value(media.numberOfEpisodes),
      episodeRuntimeMinutes: Value(media.episodeRuntimeMinutes),
      tvStatus: Value(media.tvStatus),
      isAdult: Value(media.isAdult),
      createdAt: now,
      updatedAt: now,
    );
    if (existing == null) {
      final id = await _database.into(_database.mediaItems).insert(companion);
      return (await (_database.select(_database.mediaItems)
                ..where((table) => table.id.equals(id)))
              .getSingle());
    }
    await (_database.update(_database.mediaItems)
          ..where((table) => table.id.equals(existing.id)))
        .write(
      companion.copyWith(
        createdAt: Value(existing.createdAt),
        updatedAt: Value(now),
      ),
    );
    return (await (_database.select(_database.mediaItems)
              ..where((table) => table.id.equals(existing.id)))
          .getSingle());
  }

  List<LibraryEntryWithMedia> _mapRows(
    List<TypedResult> rows,
  ) {
    final order = <int>[];
    final mediaByEntry = <int, MediaItem>{};
    final entryById = <int, LibraryEntryRow>{};
    final listIdsByEntry = <int, Set<int>>{};

    for (final row in rows) {
      final entryRow = row.readTable(_database.libraryEntries);
      final mediaRow = row.readTable(_database.mediaItems);
      final listRow = row.readTableOrNull(_database.libraryListEntries);

      if (!entryById.containsKey(entryRow.id)) {
        order.add(entryRow.id);
        entryById[entryRow.id] = entryRow;
        mediaByEntry[entryRow.id] = _mediaFromRow(mediaRow);
        listIdsByEntry[entryRow.id] = <int>{};
      }
      if (listRow != null) {
        listIdsByEntry[entryRow.id]!.add(listRow.listId);
      }
    }

    return order
        .map(
          (id) => LibraryEntryWithMedia(
            entry: _entryFromRow(
              entryById[id]!,
              listIds: listIdsByEntry[id] ?? const {},
            ),
            media: mediaByEntry[id]!,
          ),
        )
        .toList(growable: false);
  }

  LibraryEntry _entryFromRow(
    LibraryEntryRow row, {
    Set<int> listIds = const {},
  }) {
    return LibraryEntry(
      id: row.id,
      mediaItemId: row.mediaItemId,
      status: LibraryStatus.fromValue(row.status),
      personalRating: row.personalRating,
      personalNote: row.personalNote,
      tags: LibraryEntry.tagsFromJson(row.tagsJson),
      listIds: listIds,
      currentSeason: row.currentSeason,
      currentEpisode: row.currentEpisode,
      lastActivityAt: row.lastActivityAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  MediaItem _mediaFromRow(MediaItemRow row) {
    return MediaItem(
      localId: row.id,
      tmdbId: row.tmdbId,
      mediaType: MediaType.fromValue(row.mediaType),
      title: row.title,
      originalTitle: row.originalTitle,
      posterPath: row.posterPath,
      backdropPath: row.backdropPath,
      overview: row.overview,
      releaseDate: _parseDate(row.releaseDate),
      runtimeMinutes: row.runtimeMinutes,
      genres: Genre.listFromJson(row.genresJson),
      tmdbVoteAverage: row.tmdbVoteAverage,
      numberOfSeasons: row.numberOfSeasons,
      numberOfEpisodes: row.numberOfEpisodes,
      episodeRuntimeMinutes: row.episodeRuntimeMinutes,
      tvStatus: row.tvStatus,
      isAdult: row.isAdult,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }
}

class DriftViewingEventRepository implements ViewingEventRepository {
  const DriftViewingEventRepository(this._database);

  final AppDatabase _database;

  @override
  Future<void> add(ViewingEvent event) async {
    await _database.into(_database.viewingEvents).insert(
          ViewingEventsCompanion.insert(
            libraryEntryId: event.libraryEntryId,
            eventType: event.eventType.value,
            season: Value(event.season),
            episode: Value(event.episode),
            occurredAt: event.occurredAt,
            note: Value(event.note),
          ),
        );
  }

  @override
  Future<List<ViewingEvent>> forEntry(int libraryEntryId) async {
    final query = _database.select(_database.viewingEvents)
      ..where((table) => table.libraryEntryId.equals(libraryEntryId))
      ..orderBy([(table) => OrderingTerm.desc(table.occurredAt)]);
    return (await query.get()).map(_map).toList(growable: false);
  }

  @override
  Stream<List<ViewingEvent>> watchForEntry(int libraryEntryId) {
    final query = _database.select(_database.viewingEvents)
      ..where((table) => table.libraryEntryId.equals(libraryEntryId))
      ..orderBy([(table) => OrderingTerm.desc(table.occurredAt)]);
    return query.watch().map(
          (rows) => rows.map(_map).toList(growable: false),
        );
  }

  ViewingEvent _map(ViewingEventRow row) {
    return ViewingEvent(
      id: row.id,
      libraryEntryId: row.libraryEntryId,
      eventType: ViewingEventType.fromValue(row.eventType),
      season: row.season,
      episode: row.episode,
      occurredAt: row.occurredAt,
      note: row.note,
    );
  }
}

class DriftDismissedSuggestionRepository
    implements DismissedSuggestionRepository {
  const DriftDismissedSuggestionRepository(this._database);

  final AppDatabase _database;

  @override
  Future<List<DismissedSuggestion>> getAll() async {
    final query = _database.select(_database.dismissedSuggestions)
      ..orderBy([(table) => OrderingTerm.desc(table.dismissedAt)]);
    final rows = await query.get();
    return rows
        .map(
          (row) => DismissedSuggestion(
            id: row.id,
            tmdbId: row.tmdbId,
            mediaType: MediaType.fromValue(row.mediaType),
            reason: row.reason,
            dismissedAt: row.dismissedAt,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> dismiss(DismissedSuggestion suggestion) async {
    await _database.into(_database.dismissedSuggestions).insert(
          DismissedSuggestionsCompanion.insert(
            tmdbId: suggestion.tmdbId,
            mediaType: suggestion.mediaType.value,
            reason: suggestion.reason,
            dismissedAt: suggestion.dismissedAt,
          ),
        );
  }

  @override
  Future<void> clear() async {
    await _database.delete(_database.dismissedSuggestions).go();
  }
}
