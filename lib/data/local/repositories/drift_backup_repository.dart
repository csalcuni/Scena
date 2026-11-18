import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/user_preferences.dart';
import '../../../domain/repositories/backup_repository.dart';
import '../drift/app_database.dart';

class DriftBackupRepository implements BackupRepository {
  const DriftBackupRepository(this._database);

  static const String format = 'scena-backup';
  static const int backupVersion = 1;

  final AppDatabase _database;

  @override
  Future<String> exportJson() async {
    final preferencesRow = await _database
        .select(_database.userPreferencesTable)
        .getSingleOrNull();
    final mediaRows = await _database.select(_database.mediaItems).get();
    final entryRows = await _database.select(_database.libraryEntries).get();
    final eventRows = await _database.select(_database.viewingEvents).get();
    final dismissedRows =
        await _database.select(_database.dismissedSuggestions).get();

    final mediaById = {for (final row in mediaRows) row.id: row};
    final entryById = {for (final row in entryRows) row.id: row};

    final data = <String, dynamic>{
      'format': format,
      'version': backupVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'preferences': preferencesRow == null
          ? const UserPreferences().toJson()
          : _preferencesToJson(preferencesRow),
      'mediaItems': mediaRows.map(_mediaToJson).toList(growable: false),
      'libraryEntries': entryRows
          .map(
            (row) => _entryToJson(
              row,
              _mediaKey(mediaById[row.mediaItemId]),
            ),
          )
          .toList(growable: false),
      'viewingEvents': eventRows
          .map(
            (row) => _eventToJson(
              row,
              _mediaKey(mediaById[entryById[row.libraryEntryId]?.mediaItemId]),
            ),
          )
          .where((event) => event['entryMediaKey'] != null)
          .toList(growable: false),
      'dismissedSuggestions': dismissedRows
          .map(
            (row) => {
              'tmdbId': row.tmdbId,
              'mediaType': row.mediaType,
              'reason': row.reason,
              'dismissedAt': row.dismissedAt.toIso8601String(),
            },
          )
          .toList(growable: false),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  @override
  Future<BackupImportSummary> importJson(String json) async {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map<String, dynamic>) {
        throw const ValidationException('Il backup deve essere un oggetto JSON.');
      }
      if (decoded['format'] != format) {
        throw const ValidationException('Formato backup non riconosciuto.');
      }
      final version = _int(decoded['version'], fallback: 0);
      if (version < 1 || version > backupVersion) {
        throw const ValidationException('Versione del backup non supportata.');
      }

      final mediaList = _listOfMaps(decoded['mediaItems']);
      final entryList = _listOfMaps(decoded['libraryEntries']);
      final eventList = _listOfMaps(decoded['viewingEvents']);
      final dismissedList = _listOfMaps(decoded['dismissedSuggestions']);
      final preferencesRaw = decoded['preferences'];
      final preferences = preferencesRaw is Map<String, dynamic>
          ? UserPreferences.fromJson(preferencesRaw)
          : const UserPreferences();

      return await _database.transaction(() async {
        await _deleteUserData();
        final mediaIds = <String, int>{};
        for (final item in mediaList) {
          final key = _mediaKeyFromJson(item);
          if (mediaIds.containsKey(key)) {
            throw const ValidationException(
              'Il backup contiene titoli duplicati.',
            );
          }
          final id = await _database.into(_database.mediaItems).insert(
                _mediaCompanion(item),
              );
          mediaIds[key] = id;
        }

        final entryIds = <String, int>{};
        for (final item in entryList) {
          final mediaKey = _string(item['mediaKey']);
          final mediaId = mediaIds[mediaKey];
          if (mediaId == null) {
            throw const ValidationException(
              'Una voce di libreria punta a un titolo mancante.',
            );
          }
          if (entryIds.containsKey(mediaKey)) {
            throw const ValidationException(
              'Il backup contiene voci di libreria duplicate.',
            );
          }
          final id = await _database.into(_database.libraryEntries).insert(
                _entryCompanion(mediaId, item),
              );
          entryIds[mediaKey] = id;
        }

        for (final event in eventList) {
          final entryId = entryIds[_string(event['entryMediaKey'])];
          if (entryId == null) continue;
          await _database.into(_database.viewingEvents).insert(
                ViewingEventsCompanion.insert(
                  libraryEntryId: entryId,
                  eventType: _string(event['eventType'], fallback: 'started'),
                  season: Value(_nullableInt(event['season'])),
                  episode: Value(_nullableInt(event['episode'])),
                  occurredAt: _date(event['occurredAt']),
                  note: Value(_nullableString(event['note'])),
                ),
              );
        }

        for (final dismissed in dismissedList) {
          await _database.into(_database.dismissedSuggestions).insert(
                DismissedSuggestionsCompanion.insert(
                  tmdbId: _int(dismissed['tmdbId']),
                  mediaType: _string(dismissed['mediaType']),
                  reason: _string(dismissed['reason']),
                  dismissedAt: _date(dismissed['dismissedAt']),
                ),
              );
        }

        await _database.into(_database.userPreferencesTable).insert(
              UserPreferencesTableCompanion.insert(
                id: const Value(1),
                streamingServicesJson: Value(
                  jsonEncode(preferences.streamingServices),
                ),
                preferredGenresJson: Value(
                  jsonEncode(preferences.preferredGenres),
                ),
                avoidedGenresJson: Value(
                  jsonEncode(preferences.avoidedGenres),
                ),
                preferredRuntimeMinutes: Value(
                  preferences.preferredRuntimeMinutes,
                ),
                hardExclusionsJson: Value(
                  jsonEncode(preferences.hardExclusions.toJson()),
                ),
                themeMode: Value(preferences.themeMode.value),
                onboardingCompleted: Value(preferences.onboardingCompleted),
              ),
            );

        return BackupImportSummary(
          mediaCount: mediaList.length,
          entryCount: entryList.length,
          eventCount: eventList.length,
          dismissedCount: dismissedList.length,
        );
      });
    } on AppException {
      rethrow;
    } on Object catch (error) {
      throw ValidationException(
        'Il backup non è valido o è incompleto. ${error.toString()}',
      );
    }
  }

  @override
  Future<void> clearAll() async {
    await _database.transaction(() async {
      await _deleteUserData();
      await _database.delete(_database.cachedEntries).go();
    });
  }

  Future<void> _deleteUserData() async {
    await _database.delete(_database.viewingEvents).go();
    await _database.delete(_database.libraryEntries).go();
    await _database.delete(_database.mediaItems).go();
    await _database.delete(_database.dismissedSuggestions).go();
    await _database.delete(_database.userPreferencesTable).go();
  }

  Map<String, dynamic> _mediaToJson(MediaItemRow row) {
    return {
      'tmdbId': row.tmdbId,
      'mediaType': row.mediaType,
      'title': row.title,
      'originalTitle': row.originalTitle,
      'posterPath': row.posterPath,
      'backdropPath': row.backdropPath,
      'overview': row.overview,
      'releaseDate': row.releaseDate,
      'runtimeMinutes': row.runtimeMinutes,
      'genres': jsonDecode(row.genresJson),
      'tmdbVoteAverage': row.tmdbVoteAverage,
      'numberOfSeasons': row.numberOfSeasons,
      'numberOfEpisodes': row.numberOfEpisodes,
      'episodeRuntimeMinutes': row.episodeRuntimeMinutes,
      'tvStatus': row.tvStatus,
      'adult': row.isAdult,
      'createdAt': row.createdAt.toIso8601String(),
      'updatedAt': row.updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _entryToJson(
    LibraryEntryRow row,
    String? mediaKey,
  ) {
    return {
      'mediaKey': mediaKey,
      'status': row.status,
      'personalRating': row.personalRating,
      'personalNote': row.personalNote,
      'tags': jsonDecode(row.tagsJson),
      'currentSeason': row.currentSeason,
      'currentEpisode': row.currentEpisode,
      'lastActivityAt': row.lastActivityAt.toIso8601String(),
      'createdAt': row.createdAt.toIso8601String(),
      'updatedAt': row.updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _eventToJson(ViewingEventRow row, String? mediaKey) {
    return {
      'entryMediaKey': mediaKey,
      'eventType': row.eventType,
      'season': row.season,
      'episode': row.episode,
      'occurredAt': row.occurredAt.toIso8601String(),
      'note': row.note,
    };
  }

  Map<String, dynamic> _preferencesToJson(UserPreferenceRow row) {
    return UserPreferences(
      streamingServices: UserPreferences.decodeStringList(
        row.streamingServicesJson,
      ),
      preferredGenres: UserPreferences.decodeIntList(row.preferredGenresJson),
      avoidedGenres: UserPreferences.decodeIntList(row.avoidedGenresJson),
      preferredRuntimeMinutes: row.preferredRuntimeMinutes,
      hardExclusions: _decodeHardExclusions(row.hardExclusionsJson),
      themeMode: AppThemeMode.fromValue(row.themeMode),
      onboardingCompleted: row.onboardingCompleted,
    ).toJson();
  }

  HardExclusions _decodeHardExclusions(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return HardExclusions.fromJson(decoded);
      }
    } on FormatException {
      return const HardExclusions();
    }
    return const HardExclusions();
  }

  MediaItemsCompanion _mediaCompanion(Map<String, dynamic> item) {
    final genres = item['genres'];
    return MediaItemsCompanion.insert(
      tmdbId: _int(item['tmdbId']),
      mediaType: _string(item['mediaType']),
      title: _string(item['title']),
      originalTitle: Value(_nullableString(item['originalTitle'])),
      posterPath: Value(_nullableString(item['posterPath'])),
      backdropPath: Value(_nullableString(item['backdropPath'])),
      overview: Value(_string(item['overview'], fallback: '')),
      releaseDate: Value(_nullableString(item['releaseDate'])),
      runtimeMinutes: Value(_nullableInt(item['runtimeMinutes'])),
      genresJson: Value(genres is List ? jsonEncode(genres) : '[]'),
      tmdbVoteAverage: Value(_double(item['tmdbVoteAverage'])),
      numberOfSeasons: Value(_nullableInt(item['numberOfSeasons'])),
      numberOfEpisodes: Value(_nullableInt(item['numberOfEpisodes'])),
      episodeRuntimeMinutes: Value(
        _nullableInt(item['episodeRuntimeMinutes']),
      ),
      tvStatus: Value(_nullableString(item['tvStatus'])),
      isAdult: Value(item['adult'] == true),
      createdAt: _date(item['createdAt']),
      updatedAt: _date(item['updatedAt']),
    );
  }

  LibraryEntriesCompanion _entryCompanion(
    int mediaId,
    Map<String, dynamic> item,
  ) {
    final tags = item['tags'];
    final status = _string(item['status'], fallback: 'to_watch');
    return LibraryEntriesCompanion.insert(
      mediaItemId: mediaId,
      status: status,
      personalRating: Value(_nullableInt(item['personalRating'])),
      personalNote: Value(_nullableString(item['personalNote'])),
      tagsJson: Value(tags is List ? jsonEncode(tags) : '[]'),
      currentSeason: Value(_nullableInt(item['currentSeason'])),
      currentEpisode: Value(_nullableInt(item['currentEpisode'])),
      lastActivityAt: _date(item['lastActivityAt']),
      createdAt: _date(item['createdAt']),
      updatedAt: _date(item['updatedAt']),
    );
  }

  List<Map<String, dynamic>> _listOfMaps(Object? value) {
    if (value == null) return const [];
    if (value is! List) {
      throw const ValidationException('Una sezione del backup non è una lista.');
    }
    return value.whereType<Map<String, dynamic>>().toList(growable: false);
  }

  String _mediaKey(MediaItemRow? row) {
    if (row == null) return '';
    return '${row.mediaType}:${row.tmdbId}';
  }

  String _mediaKeyFromJson(Map<String, dynamic> item) {
    return '${_string(item['mediaType'])}:${_int(item['tmdbId'])}';
  }

  String _string(Object? value, {String fallback = ''}) {
    return value is String ? value : fallback;
  }

  String? _nullableString(Object? value) {
    return value is String && value.trim().isNotEmpty ? value : null;
  }

  int _int(Object? value, {int fallback = 0}) {
    return value is num ? value.toInt() : fallback;
  }

  int? _nullableInt(Object? value) {
    return value is num ? value.toInt() : null;
  }

  double _double(Object? value) {
    return value is num ? value.toDouble() : 0;
  }

  DateTime _date(Object? value) {
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
    }
    return DateTime.now();
  }
}
