import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/config/app_config.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/breakpoints.dart';
import '../../core/utils/date_formatters.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/evening.dart';
import '../../domain/entities/library_entry.dart';
import '../../domain/entities/media_item.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/media_artwork.dart';
import '../../widgets/scena_logo.dart';
import '../../widgets/section_header.dart';
import '../../widgets/status_pill.dart';
import 'evening_sheet.dart';
import 'suggestion_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(libraryProvider);
    final result = ref.watch(recommendationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const ScenaLogo(size: 30),
        actions: [
          IconButton(
            onPressed: () => _showHowItWorks(context),
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Come funziona',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _EveningHero(),
                  const SizedBox(height: 28),
                  library.when(
                    data: (items) => _RecommendationsSection(
                      result: result,
                      libraryEmpty: items.isEmpty,
                    ),
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (error, stackTrace) => ErrorView(
                      title: 'Non riesco a leggere la libreria',
                      message: userMessageFor(error),
                      onRetry: () => ref.invalidate(libraryProvider),
                    ),
                  ),
                  const _ResumeSection(),
                  const SizedBox(height: 32),
                  _FooterNote(dataMode: AppConfig.dataModeLabel),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EveningHero extends ConsumerWidget {
  const _EveningHero();

  static const _timeOptions = <int?>[45, 60, 90, 120, 150, null];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final request = ref.watch(eveningRequestProvider);
    final lists = ref.watch(libraryListsProvider).value ?? const [];
    final selectedLists =
        lists.where((list) => request.listIds.contains(list.id)).toList();
    final listLabel = request.listIds.isEmpty
        ? 'Liste: tutte'
        : selectedLists.isEmpty
            ? 'Liste: nessuna disponibile'
            : 'Liste: ${selectedLists.map((list) => list.name).join(', ')}';
    final filterCount = [
      request.noHorror,
      request.noRomance,
      request.familyOnly,
    ].where((value) => value).length;

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        padding: EdgeInsets.all(context.isCompact ? 20 : 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surfaceContainerLow,
              theme.colorScheme.surfaceContainer,
            ],
          ),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -90,
              top: -110,
              child: IgnorePointer(
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        context.scenaColors.glow.withValues(alpha: 0.22),
                        context.scenaColors.glow.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: context.scenaColors.gold.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'SERATA DI STASERA',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: context.scenaColors.gold,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        capitalize(formatLongDate(DateTime.now())),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Cosa guardiamo stasera?',
                  style: (context.isCompact
                          ? theme.textTheme.headlineMedium
                          : theme.textTheme.displaySmall)
                      ?.copyWith(height: 1.08),
                ),
                const SizedBox(height: 8),
                Text(
                  _summary(request),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  listLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.scenaColors.gold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 22),
                Text('Tempo a disposizione', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final option in _timeOptions)
                      ChoiceChip(
                        label: Text(_timeChipLabel(option)),
                        selected: request.availableMinutes == option,
                        onSelected: (_) {
                          ref
                              .read(eveningRequestProvider.notifier)
                              .setRequest(
                                request.copyWith(
                                  availableMinutes: option,
                                  clearAvailableMinutes: option == null,
                                ),
                              );
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _SelectField<Mood>(
                        label: 'Umore',
                        icon: Icons.mood_rounded,
                        value: request.mood,
                        values: Mood.values,
                        labelOf: (value) => value.label,
                        onChanged: (value) {
                          ref
                              .read(eveningRequestProvider.notifier)
                              .setRequest(request.copyWith(mood: value));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _SelectField<ViewingContext>(
                        label: 'Compagnia',
                        icon: Icons.groups_rounded,
                        value: request.context,
                        values: ViewingContext.values,
                        labelOf: (value) => value.label,
                        onChanged: (value) {
                          ref
                              .read(eveningRequestProvider.notifier)
                              .setRequest(request.copyWith(context: value));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _openSurprise(context, ref),
                      icon: const Icon(Icons.casino_rounded),
                      label: const Text('Sorprendimi'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => showEveningSheet(context),
                      icon: const Icon(Icons.tune_rounded),
                      label: Text(
                        filterCount == 0
                            ? 'Imposta la serata'
                            : 'Imposta la serata · $filterCount',
                      ),
                    ),
                    if (filterCount > 0)
                      TextButton.icon(
                        onPressed: () {
                          ref.read(eveningRequestProvider.notifier).setRequest(
                                request.copyWith(
                                  noHorror: false,
                                  noRomance: false,
                                  familyOnly: false,
                                ),
                              );
                        },
                        icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
                        label: const Text('Togli filtri'),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _summary(EveningRequest request) {
    final time = request.unlimited
        ? 'Tempo illimitato'
        : 'Hai ${formatMinutes(request.availableMinutes!)}';
    return '$time, umore ${request.mood.label.toLowerCase()}, '
        '${request.context.label.toLowerCase()}.';
  }

  static String _timeChipLabel(int? minutes) {
    if (minutes == null) return 'Illimitato';
    if (minutes % 60 == 0) return '${minutes ~/ 60}h';
    if (minutes > 60) return '${minutes ~/ 60}h ${minutes % 60}';
    return '$minutes min';
  }
}

class _SelectField<T> extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.icon,
    required this.value,
    required this.values,
    required this.labelOf,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final T value;
  final List<T> values;
  final String Function(T value) labelOf;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<T>(
      onSelected: onChanged,
      tooltip: label,
      itemBuilder: (context) => [
        for (final item in values)
          PopupMenuItem<T>(
            value: item,
            child: Row(
              children: [
                if (item == value)
                  Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: context.scenaColors.gold,
                  )
                else
                  const SizedBox(width: 18),
                const SizedBox(width: 8),
                Text(labelOf(item)),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest.withValues(
            alpha: 0.7,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: context.scenaColors.gold),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    labelOf(value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.expand_more_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}

class _RecommendationsSection extends ConsumerWidget {
  const _RecommendationsSection({
    required this.result,
    required this.libraryEmpty,
  });

  final RecommendationResult result;
  final bool libraryEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dismissals =
        ref.watch(dismissedSuggestionsProvider).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Le proposte per stasera',
          subtitle: 'Massimo tre titoli, ognuno con il suo perché.',
          action: dismissals.isEmpty
              ? null
              : TextButton(
                  onPressed: () async {
                    await ref
                        .read(dismissedSuggestionsProvider.notifier)
                        .clear();
                    if (!context.mounted) return;
                    showScenaSnackBar(context, 'Proposte scartate ripristinate.');
                  },
                  child: const Text('Ripristina'),
                ),
        ),
        const SizedBox(height: 14),
        if (result.relaxationNote != null) ...[
          _NoteBanner(
            message: result.relaxationNote!,
            warning: result.relaxed,
          ),
          const SizedBox(height: 14),
        ],
        if (result.suggestions.isEmpty)
          EmptyState(
            icon: libraryEmpty
                ? Icons.video_library_outlined
                : Icons.filter_alt_off_rounded,
            title: libraryEmpty
                ? 'La tua libreria è vuota'
                : 'Nessuna proposta con questi criteri',
            message: result.relaxationNote ??
                'Aggiungi qualche titolo alla libreria per ricevere proposte '
                    'su misura.',
            actions: [
              FilledButton.icon(
                onPressed: () => context.go('/search'),
                icon: const Icon(Icons.search_rounded),
                label: const Text('Cerca un titolo'),
              ),
              if (!libraryEmpty)
                OutlinedButton.icon(
                  onPressed: () => showEveningSheet(context),
                  icon: const Icon(Icons.tune_rounded),
                  label: const Text('Modifica la serata'),
                ),
            ],
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                for (final suggestion in result.suggestions)
                  SuggestionCard(
                    key: ValueKey(suggestion.key),
                    suggestion: suggestion,
                  ),
              ];
              if (constraints.maxWidth >= 920) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var index = 0; index < cards.length; index++) ...[
                        if (index > 0) const SizedBox(width: 12),
                        Expanded(child: cards[index]),
                      ],
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  for (var index = 0; index < cards.length; index++) ...[
                    if (index > 0) const SizedBox(height: 12),
                    cards[index],
                  ],
                ],
              );
            },
          ),
      ],
    );
  }
}

class _NoteBanner extends StatelessWidget {
  const _NoteBanner({required this.message, this.warning = false});

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
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            warning ? Icons.schedule_rounded : Icons.info_outline_rounded,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResumeSection extends ConsumerWidget {
  const _ResumeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(resumeEntriesProvider);
    if (entries.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const SectionHeader(
          title: 'Riprendi',
          subtitle: 'Torna al punto in cui eri rimasto.',
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _ResumeCard(item: entries[index]),
          ),
        ),
      ],
    );
  }
}

class _ResumeCard extends StatelessWidget {
  const _ResumeCard({required this.item});

  final LibraryEntryWithMedia item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = item.entry;
    final subtitle = entry.nextEpisodeLabel ??
        (entry.status == LibraryStatus.paused
            ? 'In pausa'
            : entry.status == LibraryStatus.inProgress
                ? 'In corso'
                : entry.status.label);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width < 420 ? 280 : 320,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(
            '/media/${item.media.mediaType.value}/${item.media.tmdbId}',
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                MediaPoster(
                  media: item.media,
                  width: 72,
                  height: 110,
                  borderRadius: 12,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.media.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            entry.status == LibraryStatus.paused
                                ? Icons.pause_circle_outline_rounded
                                : Icons.play_circle_outline_rounded,
                            size: 15,
                            color: context.scenaColors.gold,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: context.scenaColors.gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        daysSinceLabel(entry.lastActivityAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
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
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote({required this.dataMode});

  final String dataMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.privacy_tip_outlined,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Scena sceglie solo tra i titoli della tua libreria e non '
              'verifica dove sono disponibili in streaming. Dati locali · '
              '$dataMode.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showHowItWorks(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Come funziona Scena'),
      content: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HowItWorksPoint(
              icon: Icons.video_library_outlined,
              title: 'Sceglie dalla tua libreria',
              message:
                  'Le proposte nascono dai titoli che hai salvato, non da un '
                  'catalogo infinito.',
            ),
            _HowItWorksPoint(
              icon: Icons.schedule_rounded,
              title: 'Rispetta tempo e umore',
              message:
                  'Durata, mood, compagnia e vincoli cambiano l’ordine delle '
                  'proposte.',
            ),
            _HowItWorksPoint(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Spiega ogni scelta',
              message:
                  'Ogni titolo arriva con una motivazione leggibile, non con '
                  'un punteggio nascosto.',
            ),
            _HowItWorksPoint(
              icon: Icons.close_rounded,
              title: 'Impara dagli scarti',
              message:
                  'Un titolo scartato viene deprioritizzato. Puoi ripristinare '
                  'gli scarti dalla sezione proposte.',
            ),
            _HowItWorksPoint(
              icon: Icons.lock_outline_rounded,
              title: 'Resta sul dispositivo',
              message:
                  'Nessun account, nessun social, nessuna recensione. '
                  'L’esportazione JSON è sempre tua.',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Chiudi'),
        ),
      ],
    ),
  );
}

class _HowItWorksPoint extends StatelessWidget {
  const _HowItWorksPoint({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: context.scenaColors.gold),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _openSurprise(BuildContext context, WidgetRef ref) async {
  final pick = ref.read(surpriseProvider.notifier).pickAgain();
  if (!pick.hasPick) {
    showScenaSnackBar(context, pick.reason);
    return;
  }
  await showDialog<void>(
    context: context,
    builder: (context) => const _SurpriseDialog(),
  );
}

class _SurpriseDialog extends ConsumerWidget {
  const _SurpriseDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(surpriseProvider);
    final pick = state.pick;
    final theme = Theme.of(context);
    if (pick == null || !pick.hasPick) {
      return AlertDialog(
        title: const Text('Niente da estrarre'),
        content: Text(
          pick?.reason ??
              'La libreria non ha titoli disponibili con i criteri attuali.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Chiudi'),
          ),
        ],
      );
    }

    final media = pick.candidate!.media;
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.casino_rounded, color: context.scenaColors.gold),
          const SizedBox(width: 8),
          const Expanded(child: Text('Estratto per te')),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaPoster(
                  media: media,
                  width: 84,
                  height: 124,
                  borderRadius: 12,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(media.title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        [
                          if (media.releaseYear != null) '${media.releaseYear}',
                          media.durationLabel(),
                        ].join(' · '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LibraryStatusPill(
                        status: pick.candidate!.entry.status,
                        dense: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              pick.reason,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            final next = ref.read(surpriseProvider.notifier).pickAgain();
            if (!next.hasPick) {
              showScenaSnackBar(context, next.reason);
            }
          },
          icon: const Icon(Icons.casino_outlined),
          label: const Text('Un altro'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.push('/media/${media.mediaType.value}/${media.tmdbId}');
          },
          child: const Text('Apri'),
        ),
      ],
    );
  }
}
