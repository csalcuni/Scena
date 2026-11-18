import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../app/providers.dart';
import '../domain/entities/media_item.dart';

/// Poster o backdrop con fallback grafico quando TMDB non ha un'immagine.
class MediaArtwork extends ConsumerWidget {
  const MediaArtwork({
    super.key,
    required this.path,
    this.backdrop = false,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
  });

  final String? path;
  final bool backdrop;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config =
        ref.watch(imageConfigProvider).value ?? ImageConfig.fallback;
    final url = backdrop
        ? config.backdropUrl(path)
        : config.posterUrl(path);
    final radius = BorderRadius.circular(borderRadius);
    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        width: width,
        height: height,
        child: url == null
            ? _ArtworkFallback(width: width, height: height)
            : CachedNetworkImage(
                imageUrl: url,
                fit: fit,
                width: width,
                height: height,
                fadeInDuration: const Duration(milliseconds: 220),
                placeholder: (context, value) => _ArtworkPlaceholder(
                  width: width,
                  height: height,
                ),
                errorWidget: (context, value, error) => _ArtworkFallback(
                  width: width,
                  height: height,
                ),
              ),
      ),
    );
  }
}

class MediaPoster extends StatelessWidget {
  const MediaPoster({
    super.key,
    required this.media,
    this.width,
    this.height,
    this.borderRadius = 16,
  });

  final MediaItem media;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return MediaArtwork(
      path: media.posterPath,
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }
}

class _ArtworkPlaceholder extends StatelessWidget {
  const _ArtworkPlaceholder({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      alignment: Alignment.center,
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}

class _ArtworkFallback extends StatelessWidget {
  const _ArtworkFallback({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.surfaceContainerHigh,
            scheme.surfaceContainerHighest,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.movie_outlined,
        size: 34,
        color: scheme.outline,
      ),
    );
  }
}
