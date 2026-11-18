import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/providers.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/snackbars.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/evening.dart';
import '../../../domain/entities/library_entry.dart';
import '../../../widgets/media_artwork.dart';
import '../../../widgets/status_pill.dart';

class SuggestionCard extends ConsumerStatefulWidget {
  const SuggestionCard({super.key, required this.suggestion});

  final Suggestion suggestion;

  @override
  ConsumerState<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends ConsumerState<SuggestionCard> {
  var _busy = false;

  Suggestion get suggestion => widget.suggestion;

  Future<void> _dismiss() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(dismissedSuggestionsProvider.notifier)
          .dismiss(suggestion);
      if (!mounted) return;
      showScenaSnackBar(
        context,
        '«${suggestion.media.title}» non verrà più proposto.',
      );
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _quickAction() async {
    if (_busy) return;
    final entry = suggestion.entry;
    if (entry == null) {
      context.push(
        '/media/${suggestion.media.mediaType.value}/${suggestion.media.tmdbId}',
      );
      return;
    }
    setState(() => _busy = true);
    final item = LibraryEntryWithMedia(
      entry: entry,
      media: suggestion.media,
    );
    try {
      if (suggestion.media.mediaType == MediaType.tv) {
        await ref.read(markEpisodeWatchedProvider).call(item);
        if (!mounted) return;
        final season = (entry.currentSeason ?? 1).toString().padLeft(2, '0');
        final episode =
            ((entry.currentEpisode ?? 1) + 1).toString().padLeft(2, '0');
        showScenaSnackBar(
          context,
          'Episodio segnato. Prossimo: S$season · E$episode.',
        );
      } else {
        await ref.read(markWatchedProvider).call(item);
        if (!mounted) return;
        showScenaSnackBar(context, '«${suggestion.media.title}» segnato come visto.');
      }
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = suggestion.media;
    final isTv = media.mediaType == MediaType.tv;
    final meta = <String>[
      if (media.releaseYear != null) '${media.releaseYear}',
      media.durationLabel(),
      if (media.tmdbVoteAverage > 0)
        '${media.tmdbVoteAverage.toStringAsFixed(1)}/10',
    ];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/media/${media.mediaType.value}/${media.tmdbId}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'poster:${media.key}',
                child: MediaPoster(
                  media: media,
                  width: 96,
                  height: 142,
                  borderRadius: 12,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            media.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        if (_busy)
                          const Padding(
                            padding: EdgeInsets.only(left: 8, top: 2),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meta.join(' · '),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        SuggestionStatusPill(status: suggestion.status),
                        if (isTv && suggestion.entry?.nextEpisodeLabel != null)
                          _MetaPill(
                            icon: Icons.play_circle_outline_rounded,
                            label: suggestion.entry!.nextEpisodeLabel!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.scenaColors.gold.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 15,
                            color: context.scenaColors.gold,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              suggestion.reason,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        FilledButton.tonal(
                          onPressed: _busy
                              ? null
                              : () => context.push(
                                    '/media/${media.mediaType.value}/${media.tmdbId}',
                                  ),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(0, 38),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          child: const Text('Apri'),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          onPressed: _busy ? null : _quickAction,
                          tooltip: isTv
                              ? 'Segna prossimo episodio'
                              : 'Segna come visto',
                          icon: Icon(
                            isTv
                                ? Icons.skip_next_rounded
                                : Icons.check_circle_outline_rounded,
                            size: 22,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _busy ? null : _dismiss,
                          tooltip: 'Scarta questa proposta',
                          icon: const Icon(Icons.close_rounded, size: 20),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
