import '../../../domain/entities/media_item.dart';

class CachedPayload {
  const CachedPayload({required this.data, required this.cachedAt});

  final Map<String, dynamic> data;
  final DateTime cachedAt;
}

abstract interface class TmdbCacheStore {
  Future<CachedPayload?> read(String key);

  Future<void> write(
    String key,
    Map<String, dynamic> data, {
    DateTime? cachedAt,
  });
}

/// Implementazione in-memory usata da test e mock.
class MemoryTmdbCacheStore implements TmdbCacheStore {
  final Map<String, CachedPayload> _entries = {};

  @override
  Future<CachedPayload?> read(String key) async => _entries[key];

  @override
  Future<void> write(
    String key,
    Map<String, dynamic> data, {
    DateTime? cachedAt,
  }) async {
    _entries[key] = CachedPayload(
      data: data,
      cachedAt: cachedAt ?? DateTime.now(),
    );
  }
}

/// Configurazione immagini usata quando TMDB non è raggiungibile.
const ImageConfig fallbackImageConfig = ImageConfig(
  baseUrl: 'https://image.tmdb.org/t/p/',
);
