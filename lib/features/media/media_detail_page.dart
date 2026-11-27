import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/breakpoints.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/library_entry.dart';
import '../../domain/entities/library_list.dart';
import '../../domain/entities/media_item.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/media_artwork.dart';
import '../../widgets/status_pill.dart';
import '../library/entry_editor_sheet.dart';
import '../library/list_target_selector.dart';

class MediaDetailPage extends ConsumerStatefulWidget {
  const MediaDetailPage({
    super.key,
    required this.typeValue,
    required this.tmdbId,
  });

  final String typeValue;
  final int tmdbId;

  @override
  ConsumerState<MediaDetailPage> createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends ConsumerState<MediaDetailPage> {
  var _busy = false;
  int? _targetListId;

  MediaType? get _type {
    for (final type in MediaType.values) {
      if (type.value == widget.typeValue) return type;
    }
    return null;
  }

  MediaLookup get _lookup => MediaLookup(type: _type!, tmdbId: widget.tmdbId);

  LibraryEntryWithMedia? _entryFor(
    List<LibraryEntryWithMedia> library,
    MediaType type,
  ) {
    for (final item in library) {
      if (item.media.tmdbId == widget.tmdbId &&
          item.media.mediaType == type) {
        return item;
      }
    }
    return null;
  }

  Future<void> _add(
    MediaItem media, {
    LibraryStatus status = LibraryStatus.toWatch,
  }) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final targetListId = _targetListId;
      final result = await ref.read(addToLibraryProvider).call(
            media,
            status: status,
            listIds: targetListId == null ? const {} : {targetListId},
          );
      if (!mounted) return;
      final lists = ref.read(libraryListsProvider).value ??
          const <LibraryList>[];
      final list = lists.where(
        (item) => targetListId == null ? item.isDefault : item.id == targetListId,
      );
      final listName = list.isEmpty ? LibraryList.defaultName : list.first.name;
      final statusPart = result.entry.status == LibraryStatus.toWatch
          ? ''
          : ' come «${result.entry.status.label}»';
      showScenaSnackBar(
        context,
        '«${media.title}» aggiunto a «$listName»$statusPart.',
      );
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _changeStatus(
    LibraryEntryWithMedia item,
    LibraryStatus status,
  ) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(changeLibraryStatusProvider).call(item, status);
      if (!mounted) return;
      showScenaSnackBar(context, 'Stato aggiornato: ${status.label}.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _markEpisode(LibraryEntryWithMedia item) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final updated = await ref.read(markEpisodeWatchedProvider).call(item);
      if (!mounted) return;
      showScenaSnackBar(
        context,
        'Episodio segnato. Prossimo: ${updated.entry.nextEpisodeLabel ?? '—'}.',
      );
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _markWatched(LibraryEntryWithMedia item) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(markWatchedProvider).call(item);
      if (!mounted) return;
      showScenaSnackBar(context, '«${item.media.title}» segnato come visto.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete(LibraryEntryWithMedia item) async {
    final confirmed = await confirmAction(
      context,
      title: 'Rimuovere dalla libreria?',
      message: '«${item.media.title}» e i suoi eventi verranno eliminati.',
      confirmLabel: 'Rimuovi',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await ref.read(libraryRepositoryProvider).deleteEntry(item.entry.id);
      if (!mounted) return;
      showScenaSnackBar(context, 'Titolo rimosso dalla libreria.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = _type;
    if (type == null || widget.tmdbId <= 0) {
      return Scaffold(
        appBar: AppBar(title: const Text('Titolo non valido')),
        body: ErrorView(
          title: 'Collegamento non valido',
          message: 'Il tipo di contenuto o l’identificativo non sono validi.',
          onRetry: () => context.go('/'),
          retryLabel: 'Torna alla home',
        ),
      );
    }

    final library = ref.watch(libraryProvider).value ?? const [];
    final entry = _entryFor(library, type);
    final details = ref.watch(mediaDetailsProvider(_lookup));

    return details.when(
      data: (value) => _buildPage(value, entry),
      loading: () {
        if (entry != null) {
          return _buildPage(
            MediaDetails(media: entry.media),
            entry,
            loadingOverlay: true,
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, stackTrace) {
        if (entry != null) {
          return _buildPage(
            MediaDetails(media: entry.media),
            entry,
            errorMessage: userMessageFor(error),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: ErrorView(
            title: 'Non riesco a caricare il titolo',
            message: userMessageFor(error),
            onRetry: () => ref.invalidate(mediaDetailsProvider(_lookup)),
          ),
        );
      },
    );
  }

  Widget _buildPage(
    MediaDetails details,
    LibraryEntryWithMedia? entry, {
    bool loadingOverlay = false,
    String? errorMessage,
  }) {
    final media = details.media;
    final theme = Theme.of(context);
    final isTv = media.mediaType == MediaType.tv;
    final backdrop = media.backdropPath;
    final poster = media.posterPath;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(mediaDetailsProvider(_lookup)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: context.isCompact ? 270 : 350,
              backgroundColor: theme.colorScheme.surface,
              leading: IconButton.filledTonal(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/library');
                  }
                },
                icon: const Icon(Icons.arrow_back_rounded),
                tooltip: 'Indietro',
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    MediaArtwork(
                      path: backdrop ?? poster,
                      backdrop: backdrop != null,
                      borderRadius: 0,
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.surface.withValues(alpha: 0.18),
                            theme.colorScheme.surface.withValues(alpha: 0.55),
                            theme.colorScheme.surface,
                          ],
                          stops: const [0, 0.62, 1],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: Breakpoints.contentMaxWidth,
                  ),
                  child: Padding(
                    padding: context.pagePadding.copyWith(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (loadingOverlay) const LinearProgressIndicator(),
                        if (errorMessage != null) ...[
                          _InfoBanner(
                            message:
                                'Dati TMDB non disponibili ora: mostro i '
                                'metadati salvati. $errorMessage',
                            warning: true,
                          ),
                          const SizedBox(height: 14),
                        ],
                        if (details.isFromCache) ...[
                          const _InfoBanner(
                            message:
                                'Dettagli dalla cache locale: potrebbero non '
                                'essere aggiornati.',
                          ),
                          const SizedBox(height: 14),
                        ],
                        _HeaderSection(
                          media: media,
                          entry: entry,
                          isTv: isTv,
                        ),
                        const SizedBox(height: 22),
                        _ActionsSection(
                          media: media,
                          entry: entry,
                          busy: _busy,
                          targetListId: _targetListId,
                          onTargetListChanged: (listId) =>
                              setState(() => _targetListId = listId),
                          onAdd: (status) => _add(media, status: status),
                          onStatus: (status) =>
                              entry == null ? null : _changeStatus(entry, status),
                          onMarkEpisode: () =>
                              entry == null ? null : _markEpisode(entry),
                          onMarkWatched: () =>
                              entry == null ? null : _markWatched(entry),
                          onEdit: entry == null
                              ? null
                              : () => showLibraryEditor(context, entry),
                          onDelete: entry == null ? null : () => _delete(entry),
                        ),
                        if (entry != null &&
                            (entry.entry.personalNote?.trim().isNotEmpty ??
                                false)) ...[
                          const SizedBox(height: 20),
                          _PersonalNote(entry: entry),
                        ],
                        const SizedBox(height: 24),
                        _Section(
                          title: 'Trama',
                          child: Text(
                            media.overview.trim().isEmpty
                                ? 'Nessuna trama disponibile.'
                                : media.overview.trim(),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.55,
                            ),
                          ),
                        ),
                        if (media.genres.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          _Section(
                            title: 'Generi',
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final genre in media.genres)
                                  Chip(label: Text(genre.name)),
                              ],
                            ),
                          ),
                        ],
                        if (details.directors.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          _Section(
                            title: isTv ? 'Creato da' : 'Regia',
                            child: Text(
                              details.directors.join(', '),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                        if (details.cast.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          _Section(
                            title: 'Cast',
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final member in details.cast)
                                  Chip(
                                    avatar: const Icon(
                                      Icons.person_outline_rounded,
                                      size: 16,
                                    ),
                                    label: Text(
                                      member.character == null ||
                                              member.character!.isEmpty
                                          ? member.name
                                          : '${member.name} · '
                                              '${member.character}',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    required this.media,
    required this.entry,
    required this.isTv,
  });

  final MediaItem media;
  final LibraryEntryWithMedia? entry;
  final bool isTv;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final meta = <String>[
      if (media.releaseYear != null) '${media.releaseYear}',
      if (isTv) ...[
        if (media.numberOfSeasons != null) '${media.numberOfSeasons} stagioni',
        if (media.numberOfEpisodes != null) '${media.numberOfEpisodes} episodi',
        media.durationLabel(),
      ] else
        media.durationLabel(),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'poster:${media.key}',
          child: MediaPoster(
            media: media,
            width: context.isCompact ? 108 : 160,
            height: context.isCompact ? 162 : 240,
            borderRadius: 16,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                media.title,
                style: (context.isCompact
                        ? theme.textTheme.headlineMedium
                        : theme.textTheme.displaySmall)
                    ?.copyWith(height: 1.05),
              ),
              if (media.originalTitle != null &&
                  media.originalTitle!.trim().isNotEmpty &&
                  media.originalTitle != media.title) ...[
                const SizedBox(height: 4),
                Text(
                  media.originalTitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                meta.join(' · '),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  if (media.tmdbVoteAverage > 0)
                    _RatingBadge(
                      icon: Icons.star_rounded,
                      label:
                          'TMDB ${media.tmdbVoteAverage.toStringAsFixed(1)}/10',
                      color: context.scenaColors.gold,
                    ),
                  if (entry != null)
                    LibraryStatusPill(status: entry!.entry.status),
                  if (entry?.entry.personalRating != null)
                    _RatingBadge(
                      icon: Icons.person_rounded,
                      label: '${entry!.entry.personalRating}/10',
                      color: theme.colorScheme.secondary,
                    ),
                  if (entry?.entry.nextEpisodeLabel != null)
                    _RatingBadge(
                      icon: Icons.play_circle_outline_rounded,
                      label: entry!.entry.nextEpisodeLabel!,
                      color: theme.colorScheme.primary,
                    ),
                ],
              ),
              if (media.tvStatus != null && isTv) ...[
                const SizedBox(height: 8),
                Text(
                  'Stato serie: ${media.tvStatus}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _ActionsSection extends StatelessWidget {
  const _ActionsSection({
    required this.media,
    required this.entry,
    required this.busy,
    required this.targetListId,
    required this.onTargetListChanged,
    required this.onAdd,
    required this.onStatus,
    required this.onMarkEpisode,
    required this.onMarkWatched,
    required this.onEdit,
    required this.onDelete,
  });

  final MediaItem media;
  final LibraryEntryWithMedia? entry;
  final bool busy;
  final int? targetListId;
  final ValueChanged<int?> onTargetListChanged;
  final ValueChanged<LibraryStatus> onAdd;
  final ValueChanged<LibraryStatus>? onStatus;
  final VoidCallback? onMarkEpisode;
  final VoidCallback? onMarkWatched;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTv = media.mediaType == MediaType.tv;
    if (entry == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Non è ancora nella tua libreria',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Salvalo per includerlo nelle proposte della serata.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            ListTargetSelector(
              value: targetListId,
              onChanged: onTargetListChanged,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: busy ? null : () => onAdd(LibraryStatus.toWatch),
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text('Aggiungi alla libreria'),
                ),
                OutlinedButton.icon(
                  onPressed: busy
                      ? null
                      : () => onAdd(
                            isTv
                                ? LibraryStatus.inProgress
                                : LibraryStatus.completed,
                          ),
                  icon: Icon(
                    isTv
                        ? Icons.play_arrow_rounded
                        : Icons.check_circle_outline_rounded,
                  ),
                  label: Text(isTv ? 'Inizia a guardare' : 'Ho già visto'),
                ),
              ],
            ),
          ],
        ),
      );
    }

    final item = entry!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LibraryStatusPill(status: item.entry.status),
              const SizedBox(width: 8),
              if (item.entry.nextEpisodeLabel != null)
                Text(
                  'Prossimo: ${item.entry.nextEpisodeLabel}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              const Spacer(),
              if (busy)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (isTv)
                FilledButton.icon(
                  onPressed: busy ? null : onMarkEpisode,
                  icon: const Icon(Icons.skip_next_rounded),
                  label: const Text('Segna episodio'),
                )
              else
                FilledButton.icon(
                  onPressed: busy ? null : onMarkWatched,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Segna come visto'),
                ),
              OutlinedButton.icon(
                onPressed: busy ? null : onEdit,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Modifica'),
              ),
              PopupMenuButton<LibraryStatus>(
                enabled: !busy,
                onSelected: onStatus,
                tooltip: 'Cambia stato',
                itemBuilder: (context) => [
                  for (final status in LibraryStatus.values)
                    PopupMenuItem(
                      value: status,
                      child: Row(
                        children: [
                          if (status == item.entry.status)
                            Icon(
                              Icons.check_rounded,
                              size: 18,
                              color: context.scenaColors.gold,
                            )
                          else
                            const SizedBox(width: 18),
                          const SizedBox(width: 8),
                          Text(status.label),
                        ],
                      ),
                    ),
                ],
                child: const _MenuButtonLabel(
                  icon: Icons.swap_horiz_rounded,
                  label: 'Cambia stato',
                ),
              ),
              TextButton.icon(
                onPressed: busy ? null : onDelete,
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                ),
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Rimuovi'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuButtonLabel extends StatelessWidget {
  const _MenuButtonLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

class _PersonalNote extends StatelessWidget {
  const _PersonalNote({required this.entry});

  final LibraryEntryWithMedia entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _Section(
      title: 'La tua nota',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          entry.entry.personalNote!,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.45,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.message, this.warning = false});

  final String message;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        warning ? context.scenaColors.warning : theme.colorScheme.secondary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            warning ? Icons.warning_amber_rounded : Icons.info_outline_rounded,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
