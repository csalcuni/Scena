import 'dart:async';

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
import '../../domain/entities/media_item.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/media_artwork.dart';
import '../../widgets/scena_logo.dart';
import '../../widgets/status_pill.dart';
import 'search_controller.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key, this.initialQuery, this.initialType});

  final String? initialQuery;
  final String? initialType;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController _textController;
  late MediaType _type;
  Timer? _debounce;
  final Set<String> _busyKeys = {};

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialQuery ?? '');
    _type = _parseType(widget.initialType);
    final query = widget.initialQuery?.trim() ?? '';
    if (query.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _runSearch(query, updateUrl: false);
      });
    }
  }

  @override
  void didUpdateWidget(SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final incomingQuery = widget.initialQuery?.trim() ?? '';
    final incomingType = _parseType(widget.initialType);
    final queryChanged = incomingQuery != oldWidget.initialQuery?.trim();
    final typeChanged = incomingType != _type;
    if (queryChanged && incomingQuery != _textController.text.trim()) {
      _textController.text = incomingQuery;
      _textController.selection = TextSelection.collapsed(
        offset: _textController.text.length,
      );
      if (incomingQuery.isNotEmpty) {
        _runSearch(incomingQuery, updateUrl: false);
      } else {
        ref.read(searchProvider.notifier).clear();
      }
    }
    if (typeChanged) {
      setState(() => _type = incomingType);
      if (_textController.text.trim().isNotEmpty) {
        _runSearch(_textController.text, updateUrl: false);
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }

  MediaType _parseType(String? value) {
    return value == MediaType.tv.value ? MediaType.tv : MediaType.movie;
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    setState(() {});
    if (value.trim().isEmpty) {
      ref.read(searchProvider.notifier).clear();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 380), () {
      if (!mounted) return;
      _runSearch(value, updateUrl: false);
    });
  }

  void _runSearch(String query, {required bool updateUrl}) {
    _debounce?.cancel();
    ref.read(searchProvider.notifier).search(query: query, type: _type);
    if (updateUrl) _syncUrl(query);
  }

  void _syncUrl(String query) {
    final params = <String, String>{
      if (query.trim().isNotEmpty) 'q': query.trim(),
      'type': _type.value,
    };
    final target = Uri(path: '/search', queryParameters: params).toString();
    final current = GoRouterState.of(context).uri.toString();
    if (target == current) return;
    context.replace(target);
  }

  void _setType(MediaType type) {
    if (_type == type) return;
    setState(() => _type = type);
    final query = _textController.text.trim();
    if (query.isNotEmpty) {
      _runSearch(query, updateUrl: false);
    }
    _syncUrl(query);
  }

  Future<void> _addToLibrary(
    MediaItem media, {
    LibraryStatus status = LibraryStatus.toWatch,
  }) async {
    if (_busyKeys.contains(media.key)) return;
    setState(() => _busyKeys.add(media.key));
    try {
      await ref.read(addToLibraryProvider).call(media, status: status);
      if (!mounted) return;
      showScenaSnackBar(
        context,
        '«${media.title}» aggiunto come «${status.label}».',
      );
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busyKeys.remove(media.key));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);
    final library = ref.watch(libraryProvider).value ?? const [];
    final byKey = {for (final item in library) item.key: item};

    return Scaffold(
      appBar: AppBar(title: const ScenaLogo(size: 30)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: context.pagePadding,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.contentMaxWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cerca un titolo',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Film e serie da TMDB, con cache locale per l’uso offline.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _textController,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onChanged: _onChanged,
                    onSubmitted: (value) => _runSearch(value, updateUrl: true),
                    decoration: InputDecoration(
                      hintText: 'Titolo di un film o di una serie…',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _textController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _textController.clear();
                                ref.read(searchProvider.notifier).clear();
                                setState(() {});
                                _syncUrl('');
                              },
                              icon: const Icon(Icons.close_rounded),
                              tooltip: 'Pulisci',
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SegmentedButton<MediaType>(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(
                            value: MediaType.movie,
                            icon: Icon(Icons.movie_outlined),
                            label: Text('Film'),
                          ),
                          ButtonSegment(
                            value: MediaType.tv,
                            icon: Icon(Icons.live_tv_outlined),
                            label: Text('Serie'),
                          ),
                        ],
                        selected: {_type},
                        onSelectionChanged: (value) => _setType(value.first),
                      ),
                      if (state.totalResults > 0)
                        Text(
                          '${state.totalResults} risultati',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                    ],
                  ),
                  if (state.fromCache) ...[
                    const SizedBox(height: 12),
                    _CacheBanner(),
                  ],
                  const SizedBox(height: 20),
                  _buildBody(context, state, byKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    SearchState state,
    Map<String, LibraryEntryWithMedia> libraryByKey,
  ) {
    final theme = Theme.of(context);
    if (!state.hasSearched) {
      return EmptyState(
        icon: Icons.travel_explore_rounded,
        title: 'Trova il prossimo titolo',
        message:
            'Cerca un film o una serie, poi salvalo nella libreria. Scena lo '
            'userà per le proposte della serata.',
        actions: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final example in const [
                'Dune',
                'The Bear',
                'Parasite',
                'Fleabag',
              ])
                ActionChip(
                  label: Text(example),
                  onPressed: () {
                    _textController.text = example;
                    _textController.selection = TextSelection.collapsed(
                      offset: example.length,
                    );
                    setState(() {});
                    _runSearch(example, updateUrl: true);
                  },
                ),
            ],
          ),
        ],
      );
    }

    if (state.loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 56),
        child: Center(
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 14),
              Text(
                'Cerco «${state.query}»…',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.error != null) {
      return ErrorView(
        message: state.error!,
        onRetry: () => _runSearch(_textController.text, updateUrl: true),
      );
    }

    if (state.items.isEmpty) {
      return EmptyState(
        icon: Icons.search_off_rounded,
        title: 'Nessun risultato',
        message: 'Non ho trovato «${state.query}». Controlla il titolo o '
            'prova a cambiare tra film e serie.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < state.items.length; index++) ...[
          if (index > 0) const SizedBox(height: 10),
          _SearchResultCard(
            media: state.items[index],
            entry: libraryByKey[state.items[index].key],
            busy: _busyKeys.contains(state.items[index].key),
            onOpen: () => context.push(
              '/media/${state.items[index].mediaType.value}/'
              '${state.items[index].tmdbId}',
            ),
            onAdd: (status) =>
                _addToLibrary(state.items[index], status: status),
          ),
        ],
        if (state.hasMore) ...[
          const SizedBox(height: 18),
          Center(
            child: state.loadingMore
                ? const CircularProgressIndicator()
                : OutlinedButton.icon(
                    onPressed: () => ref
                        .read(searchProvider.notifier)
                        .loadMore(),
                    icon: const Icon(Icons.expand_more_rounded),
                    label: const Text('Carica altri'),
                  ),
          ),
        ],
      ],
    );
  }
}

class _CacheBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_off_rounded, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Risultati dalla cache locale: potrebbero non essere aggiornati.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({
    required this.media,
    required this.entry,
    required this.busy,
    required this.onOpen,
    required this.onAdd,
  });

  final MediaItem media;
  final LibraryEntryWithMedia? entry;
  final bool busy;
  final VoidCallback onOpen;
  final ValueChanged<LibraryStatus> onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final genres = media.genres.take(3).map((genre) => genre.name).join(' · ');
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
                media: media,
                width: 82,
                height: 123,
                borderRadius: 10,
              ),
              const SizedBox(width: 12),
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
                        if (media.tmdbVoteAverage > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: context.scenaColors.gold.withValues(
                                alpha: 0.14,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 13,
                                  color: context.scenaColors.gold,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  media.tmdbVoteAverage.toStringAsFixed(1),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        media.mediaType.label,
                        if (media.releaseYear != null) '${media.releaseYear}',
                        media.durationLabel(),
                      ].join(' · '),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (genres.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        genres,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (media.overview.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        media.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(height: 1.35),
                      ),
                    ],
                    const SizedBox(height: 8),
                    if (entry != null)
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          LibraryStatusPill(
                            status: entry!.entry.status,
                            dense: true,
                          ),
                          TextButton(
                            onPressed: onOpen,
                            style: TextButton.styleFrom(
                              minimumSize: const Size(0, 32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                            ),
                            child: const Text('Apri'),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          FilledButton.tonalIcon(
                            onPressed: busy
                                ? null
                                : () => onAdd(LibraryStatus.toWatch),
                            icon: busy
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.add_rounded, size: 18),
                            label: const Text('Aggiungi'),
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          PopupMenuButton<LibraryStatus>(
                            tooltip: 'Aggiungi con stato',
                            enabled: !busy,
                            onSelected: onAdd,
                            icon: const Icon(Icons.expand_more_rounded),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: LibraryStatus.toWatch,
                                child: Text('Da vedere'),
                              ),
                              const PopupMenuItem(
                                value: LibraryStatus.inProgress,
                                child: Text('In corso'),
                              ),
                              PopupMenuItem(
                                value: LibraryStatus.completed,
                                child: Text(
                                  media.mediaType == MediaType.tv
                                      ? 'Già visto (serie completa)'
                                      : 'Già visto',
                                ),
                              ),
                            ],
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
