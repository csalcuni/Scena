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
import '../../widgets/confirm_dialog.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/media_artwork.dart';
import '../../widgets/scena_logo.dart';
import '../../widgets/status_pill.dart';
import 'entry_editor_sheet.dart';
import 'library_lists_sheet.dart';
import 'list_dialogs.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  final TextEditingController _searchController = TextEditingController();
  var _query = '';
  List<LibraryStatus>? _statusFilter;
  int? _listFilter;

  static const _filters = <_LibraryFilter>[
    _LibraryFilter(label: 'Tutti', statuses: null),
    _LibraryFilter(
      label: 'Da vedere',
      statuses: [LibraryStatus.toWatch],
    ),
    _LibraryFilter(
      label: 'In corso',
      statuses: [LibraryStatus.inProgress, LibraryStatus.paused],
    ),
    _LibraryFilter(
      label: 'Visto',
      statuses: [LibraryStatus.completed],
    ),
    _LibraryFilter(
      label: 'Abbandonato',
      statuses: [LibraryStatus.abandoned],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesFilter(LibraryStatus status) {
    final filter = _statusFilter;
    return filter == null || filter.contains(status);
  }

  List<LibraryEntryWithMedia> _applyFilters(
    List<LibraryEntryWithMedia> items,
  ) {
    final query = _query.trim().toLowerCase();
    return items.where((item) {
      if (!_matchesFilter(item.entry.status)) return false;
      final listFilter = _listFilter;
      if (listFilter != null && !item.entry.listIds.contains(listFilter)) {
        return false;
      }
      if (query.isEmpty) return true;
      final haystack = [
        item.media.title,
        item.media.originalTitle ?? '',
        item.media.overview,
        ...item.entry.tags,
        item.entry.personalNote ?? '',
      ].join(' ').toLowerCase();
      return haystack.contains(query);
    }).toList(growable: false);
  }

  Future<void> _markWatched(LibraryEntryWithMedia item) async {
    try {
      if (item.media.mediaType == MediaType.tv) {
        await ref.read(markEpisodeWatchedProvider).call(item);
        if (!mounted) return;
        showScenaSnackBar(context, 'Prossimo episodio segnato.');
      } else {
        await ref.read(markWatchedProvider).call(item);
        if (!mounted) return;
        showScenaSnackBar(context, '«${item.media.title}» segnato come visto.');
      }
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    }
  }

  Future<void> _delete(LibraryEntryWithMedia item) async {
    final confirmed = await confirmAction(
      context,
      title: 'Rimuovere dalla libreria?',
      message: '«${item.media.title}» e i suoi eventi verranno eliminati. '
          'La cache di ricerca non viene toccata.',
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
    final library = ref.watch(libraryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const ScenaLogo(size: 30),
        actions: [
          IconButton(
            onPressed: () => context.go('/search'),
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Aggiungi un titolo',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: context.pagePadding,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.contentMaxWidth,
              ),
              child: library.when(
                data: (items) => _buildContent(context, items),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => ErrorView(
                  title: 'Non riesco a leggere la libreria',
                  message: userMessageFor(error),
                  onRetry: () => ref.invalidate(libraryProvider),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<LibraryEntryWithMedia> items,
  ) {
    final lists =
        ref.watch(libraryListsProvider).value ?? const <LibraryList>[];
    final listNames = {for (final list in lists) list.id: list.name};
    final scopedItems = _listFilter == null
        ? items
        : items
            .where((item) => item.entry.listIds.contains(_listFilter))
            .toList(growable: false);

    if (items.isEmpty) {
      return EmptyState(
        icon: Icons.video_library_outlined,
        title: 'La tua libreria è vuota',
        message:
            'Cerca un film o una serie e salvalo qui. Scena userà la tua '
            'libreria per costruire le proposte della serata.',
        actions: [
          FilledButton.icon(
            onPressed: () => context.go('/search'),
            icon: const Icon(Icons.search_rounded),
            label: const Text('Cerca un titolo'),
          ),
          OutlinedButton.icon(
            onPressed: () => showLibraryListsSheet(context),
            icon: const Icon(Icons.playlist_play_rounded),
            label: const Text('Gestisci le liste'),
          ),
        ],
      );
    }

    final filtered = _applyFilters(items);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'La tua libreria',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            TextButton.icon(
              onPressed: () => showLibraryListsSheet(context),
              icon: const Icon(Icons.playlist_play_rounded),
              label: const Text('Liste'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${items.length} ${items.length == 1 ? 'titolo salvato' : 'titoli salvati'} · '
          'tutto sul dispositivo',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 20),
        _LibraryStats(
          items: scopedItems,
          selected: _statusFilter,
          onSelected: (statuses) => setState(() {
            _statusFilter = statuses;
          }),
        ),
        const SizedBox(height: 18),
        _ListFilters(
          lists: lists,
          selectedId: _listFilter,
          onSelected: (listId) => setState(() => _listFilter = listId),
          onCreate: () async {
            final list = await createLibraryList(context, ref);
            if (list != null && mounted) {
              setState(() => _listFilter = list.id);
            }
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: 'Filtra per titolo, tag o nota…',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: _query.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Pulisci',
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final filter in _filters)
              ChoiceChip(
                label: Text(filter.label),
                selected: _sameFilter(_statusFilter, filter.statuses),
                onSelected: (_) => setState(() {
                  _statusFilter = filter.statuses;
                }),
              ),
          ],
        ),
        const SizedBox(height: 20),
        if (filtered.isEmpty)
          EmptyState(
            icon: Icons.filter_alt_off_rounded,
            title: 'Nessun titolo corrisponde',
            message: 'Prova a cambiare filtro o a cercare un’altra parola.',
            compact: true,
            actions: [
              OutlinedButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _query = '';
                    _statusFilter = null;
                    _listFilter = null;
                  });
                },
                child: const Text('Azzera filtri'),
              ),
            ],
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 700) {
                return Column(
                  children: [
                    for (var index = 0; index < filtered.length; index++) ...[
                      if (index > 0) const SizedBox(height: 10),
                      _LibraryListCard(
                        item: filtered[index],
                        listNames: listNames,
                        onOpen: () => _open(filtered[index]),
                        onEdit: () => showLibraryEditor(context, filtered[index]),
                        onMarkWatched: () => _markWatched(filtered[index]),
                        onDelete: () => _delete(filtered[index]),
                      ),
                    ],
                  ],
                );
              }
              final columns = constraints.maxWidth >= 1150
                  ? 4
                  : constraints.maxWidth >= 900
                      ? 3
                      : 2;
              const gap = 14.0;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final item in filtered)
                    SizedBox(
                      width: width,
                      child: _LibraryGridCard(
                        item: item,
                        listNames: listNames,
                        onOpen: () => _open(item),
                        onEdit: () => showLibraryEditor(context, item),
                        onMarkWatched: () => _markWatched(item),
                        onDelete: () => _delete(item),
                      ),
                    ),
                ],
              );
            },
          ),
      ],
    );
  }

  void _open(LibraryEntryWithMedia item) {
    context.push(
      '/media/${item.media.mediaType.value}/${item.media.tmdbId}',
    );
  }

  bool _sameFilter(List<LibraryStatus>? a, List<LibraryStatus>? b) {
    if (a == null || b == null) return a == b;
    return a.length == b.length && a.every(b.contains);
  }
}

class _LibraryFilter {
  const _LibraryFilter({required this.label, required this.statuses});

  final String label;
  final List<LibraryStatus>? statuses;
}

class _ListFilters extends StatelessWidget {
  const _ListFilters({
    required this.lists,
    required this.selectedId,
    required this.onSelected,
    required this.onCreate,
  });

  final List<LibraryList> lists;
  final int? selectedId;
  final ValueChanged<int?> onSelected;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Liste',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: const Text('Tutte le liste'),
              selected: selectedId == null,
              onSelected: (_) => onSelected(null),
            ),
            for (final list in lists)
              ChoiceChip(
                avatar: Icon(
                  list.isDefault
                      ? Icons.bookmark_rounded
                      : Icons.playlist_play_rounded,
                  size: 16,
                ),
                label: Text(
                  list.isDefault ? '${list.name} (predefinita)' : list.name,
                ),
                selected: selectedId == list.id,
                onSelected: (_) => onSelected(list.id),
              ),
            ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 16),
              label: const Text('Nuova'),
              onPressed: onCreate,
            ),
          ],
        ),
      ],
    );
  }
}

class _LibraryStats extends StatelessWidget {
  const _LibraryStats({
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final List<LibraryEntryWithMedia> items;
  final List<LibraryStatus>? selected;
  final ValueChanged<List<LibraryStatus>?> onSelected;

  @override
  Widget build(BuildContext context) {
    final counts = <LibraryStatus, int>{
      for (final status in LibraryStatus.values) status: 0,
    };
    for (final item in items) {
      counts.update(item.entry.status, (value) => value + 1);
    }
    final started =
        (counts[LibraryStatus.inProgress] ?? 0) + (counts[LibraryStatus.paused] ?? 0);
    final entries = [
      (
        label: 'Tutti',
        count: items.length,
        icon: Icons.video_library_outlined,
        statuses: null,
      ),
      (
        label: 'Da vedere',
        count: counts[LibraryStatus.toWatch] ?? 0,
        icon: Icons.bookmark_outline_rounded,
        statuses: [LibraryStatus.toWatch],
      ),
      (
        label: 'In corso',
        count: started,
        icon: Icons.play_circle_outline_rounded,
        statuses: [LibraryStatus.inProgress, LibraryStatus.paused],
      ),
      (
        label: 'Visti',
        count: counts[LibraryStatus.completed] ?? 0,
        icon: Icons.check_circle_outline_rounded,
        statuses: [LibraryStatus.completed],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 720 ? 4 : 2;
        const gap = 10.0;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final entry in entries)
              SizedBox(
                width: width,
                child: _StatCard(
                  label: entry.label,
                  count: entry.count,
                  icon: entry.icon,
                  selected: entry.statuses == null
                      ? selected == null
                      : selected != null &&
                          selected!.length == entry.statuses!.length &&
                          selected!.every(entry.statuses!.contains),
                  onTap: () => onSelected(entry.statuses),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: selected
          ? context.scenaColors.gold.withValues(alpha: 0.14)
          : theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? context.scenaColors.gold.withValues(alpha: 0.5)
                  : theme.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: selected
                    ? context.scenaColors.gold
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$count',
                      style: theme.textTheme.titleLarge?.copyWith(height: 1.1),
                    ),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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

class _LibraryListCard extends StatelessWidget {
  const _LibraryListCard({
    required this.item,
    required this.listNames,
    required this.onOpen,
    required this.onEdit,
    required this.onMarkWatched,
    required this.onDelete,
  });

  final LibraryEntryWithMedia item;
  final Map<int, String> listNames;
  final VoidCallback onOpen;
  final VoidCallback onEdit;
  final VoidCallback onMarkWatched;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = item.entry;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaPoster(
                media: item.media,
                width: 76,
                height: 114,
                borderRadius: 10,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.media.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        _ItemMenu(
                          item: item,
                          onEdit: onEdit,
                          onMarkWatched: onMarkWatched,
                          onDelete: onDelete,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        if (item.media.releaseYear != null)
                          '${item.media.releaseYear}',
                        item.media.mediaType.label,
                        item.media.durationLabel(),
                      ].join(' · '),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        LibraryStatusPill(status: entry.status, dense: true),
                        if (entry.nextEpisodeLabel != null)
                          _SmallPill(label: entry.nextEpisodeLabel!),
                        if (entry.personalRating != null)
                          _SmallPill(label: '${entry.personalRating}/10'),
                        for (final listId in entry.listIds)
                          if (listNames[listId] != null)
                            _SmallPill(label: listNames[listId]!),
                      ],
                    ),
                    if (entry.personalNote?.trim().isNotEmpty ?? false) ...[
                      const SizedBox(height: 8),
                      Text(
                        entry.personalNote!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (entry.tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          for (final tag in entry.tags.take(4))
                            _SmallPill(label: '#$tag'),
                        ],
                      ),
                    ],
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

class _LibraryGridCard extends StatelessWidget {
  const _LibraryGridCard({
    required this.item,
    required this.listNames,
    required this.onOpen,
    required this.onEdit,
    required this.onMarkWatched,
    required this.onDelete,
  });

  final LibraryEntryWithMedia item;
  final Map<int, String> listNames;
  final VoidCallback onOpen;
  final VoidCallback onEdit;
  final VoidCallback onMarkWatched;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = item.entry;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: MediaPoster(
                    media: item.media,
                    borderRadius: 0,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: LibraryStatusPill(status: entry.status, dense: true),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Material(
                    color: theme.colorScheme.surface.withValues(alpha: 0.86),
                    shape: const CircleBorder(),
                    child: _ItemMenu(
                      item: item,
                      onEdit: onEdit,
                      onMarkWatched: onMarkWatched,
                      onDelete: onDelete,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.media.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    [
                      if (item.media.releaseYear != null)
                        '${item.media.releaseYear}',
                      if (entry.nextEpisodeLabel != null)
                        entry.nextEpisodeLabel!
                      else
                        entry.status.label,
                    ].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (entry.listIds.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      entry.listIds
                          .map((id) => listNames[id])
                          .whereType<String>()
                          .join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  if (entry.personalRating != null ||
                      entry.tags.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (entry.personalRating != null) ...[
                          Icon(
                            Icons.star_rounded,
                            size: 15,
                            color: context.scenaColors.gold,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${entry.personalRating}/10',
                            style: theme.textTheme.labelSmall,
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (entry.tags.isNotEmpty)
                          Expanded(
                            child: Text(
                              entry.tags.take(2).map((tag) => '#$tag').join(' '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemMenu extends StatelessWidget {
  const _ItemMenu({
    required this.item,
    required this.onEdit,
    required this.onMarkWatched,
    required this.onDelete,
  });

  final LibraryEntryWithMedia item;
  final VoidCallback onEdit;
  final VoidCallback onMarkWatched;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_ItemAction>(
      tooltip: 'Azioni',
      icon: const Icon(Icons.more_vert_rounded, size: 20),
      onSelected: (action) {
        switch (action) {
          case _ItemAction.edit:
            onEdit();
          case _ItemAction.markWatched:
            onMarkWatched();
          case _ItemAction.delete:
            onDelete();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _ItemAction.edit,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.edit_outlined),
            title: Text('Modifica'),
          ),
        ),
        PopupMenuItem(
          value: _ItemAction.markWatched,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              item.media.mediaType == MediaType.tv
                  ? Icons.skip_next_rounded
                  : Icons.check_circle_outline_rounded,
            ),
            title: Text(
              item.media.mediaType == MediaType.tv
                  ? 'Segna episodio'
                  : 'Segna come visto',
            ),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: _ItemAction.delete,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.delete_outline_rounded),
            title: Text('Rimuovi'),
          ),
        ),
      ],
    );
  }
}

enum _ItemAction { edit, markWatched, delete }

class _SmallPill extends StatelessWidget {
  const _SmallPill({required this.label});

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
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
