import '../entities/enums.dart';
import '../entities/media_item.dart';

abstract interface class MediaRepository {
  Future<MediaPage> search({
    required String query,
    required MediaType type,
    int page = 1,
  });

  Future<MediaDetails> getDetails({
    required MediaType type,
    required int tmdbId,
  });

  Future<List<Genre>> getGenres(MediaType type);

  Future<ImageConfig> getImageConfig();
}
