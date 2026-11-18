import 'dart:convert';

import '../../../core/errors/app_exception.dart';
import '../../tmdb/datasources/tmdb_cache_store.dart';
import '../drift/app_database.dart';

class DriftCacheStore implements TmdbCacheStore {
  const DriftCacheStore(this._database);

  final AppDatabase _database;

  @override
  Future<CachedPayload?> read(String key) async {
    final row = await (_database.select(_database.cachedEntries)
          ..where((table) => table.cacheKey.equals(key)))
        .getSingleOrNull();
    if (row == null) return null;
    try {
      final decoded = jsonDecode(row.payloadJson);
      if (decoded is! Map<String, dynamic>) return null;
      return CachedPayload(data: decoded, cachedAt: row.cachedAt);
    } on FormatException catch (error) {
      throw StorageException(cause: error);
    }
  }

  @override
  Future<void> write(
    String key,
    Map<String, dynamic> data, {
    DateTime? cachedAt,
  }) async {
    await _database.into(_database.cachedEntries).insertOnConflictUpdate(
          CachedEntriesCompanion.insert(
            cacheKey: key,
            payloadJson: jsonEncode(data),
            cachedAt: cachedAt ?? DateTime.now(),
          ),
        );
  }
}
