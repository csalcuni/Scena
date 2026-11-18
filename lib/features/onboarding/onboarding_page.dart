import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/breakpoints.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/genre_catalog.dart';
import '../../domain/entities/media_item.dart';
import '../../domain/entities/streaming_service.dart';
import '../../domain/entities/user_preferences.dart';
import '../../widgets/scena_logo.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _controller = PageController();
  late UserPreferences _draft;
  var _page = 0;
  var _saving = false;

  static const _stepCount = 3;

  @override
  void initState() {
    super.initState();
    _draft = ref.read(preferencesProvider).value ?? const UserPreferences();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(preferencesProvider.notifier)
          .save(_draft.copyWith(onboardingCompleted: true));
      // Il router osserva `onboardingCompleted` e rimanda alla home.
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
      setState(() => _saving = false);
    }
  }

  void _next() {
    if (_page == _stepCount - 1) {
      _finish();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 340),
      curve: Curves.easeOutCubic,
    );
  }

  void _back() {
    if (_page == 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _togglePreferred(int genreId) {
    final selected = _draft.preferredGenres.toSet();
    final avoided = _draft.avoidedGenres.toSet()..remove(genreId);
    selected.contains(genreId)
        ? selected.remove(genreId)
        : selected.add(genreId);
    setState(() {
      _draft = _draft.copyWith(
        preferredGenres: selected.toList()..sort(),
        avoidedGenres: avoided.toList()..sort(),
      );
    });
  }

  void _toggleAvoided(int genreId) {
    final avoided = _draft.avoidedGenres.toSet();
    final selected = _draft.preferredGenres.toSet()..remove(genreId);
    avoided.contains(genreId) ? avoided.remove(genreId) : avoided.add(genreId);
    setState(() {
      _draft = _draft.copyWith(
        avoidedGenres: avoided.toList()..sort(),
        preferredGenres: selected.toList()..sort(),
      );
    });
  }

  void _toggleService(String serviceId) {
    final services = _draft.streamingServices.toSet();
    services.contains(serviceId)
        ? services.remove(serviceId)
        : services.add(serviceId);
    setState(() {
      _draft = _draft.copyWith(
        streamingServices: services.toList()..sort(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            right: -120,
            child: _Glow(
              color: context.scenaColors.gold.withValues(alpha: 0.16),
              size: 440,
            ),
          ),
          Positioned(
            bottom: -190,
            left: -140,
            child: _Glow(
              color: scheme.secondary.withValues(alpha: 0.12),
              size: 420,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                  child: Row(
                    children: [
                      const ScenaLogo(size: 34),
                      const Spacer(),
                      TextButton(
                        onPressed: _saving ? null : _finish,
                        child: const Text('Salta'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 980),
                      child: PageView(
                        controller: _controller,
                        onPageChanged: (page) => setState(() => _page = page),
                        children: [
                          _WelcomeStep(
                            onStart: _next,
                          ),
                          _TasteStep(
                            draft: _draft,
                            onTogglePreferred: _togglePreferred,
                            onToggleAvoided: _toggleAvoided,
                          ),
                          _EveningStep(
                            draft: _draft,
                            onToggleService: _toggleService,
                            onThemeChanged: (mode) {
                              setState(() {
                                _draft = _draft.copyWith(themeMode: mode);
                              });
                            },
                            onRuntimeChanged: (minutes) {
                              setState(() {
                                _draft = _draft.copyWith(
                                  preferredRuntimeMinutes: minutes,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    context.isCompact ? 16 : 24,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 980),
                    child: Row(
                      children: [
                        if (_page > 0)
                          IconButton.filledTonal(
                            onPressed: _saving ? null : _back,
                            icon: const Icon(Icons.arrow_back_rounded),
                            tooltip: 'Indietro',
                          )
                        else
                          const SizedBox(width: 48),
                        const Spacer(),
                        Row(
                          children: [
                            for (var index = 0; index < _stepCount; index++)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: index == _page ? 26 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: index == _page
                                      ? context.scenaColors.gold
                                      : scheme.outlineVariant,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                        if (_page > 0)
                          FilledButton.icon(
                            onPressed: _saving ? null : _next,
                            icon: _saving
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    _page == _stepCount - 1
                                        ? Icons.check_rounded
                                        : Icons.arrow_forward_rounded,
                                  ),
                            label: Text(
                              _page == _stepCount - 1
                                  ? 'Inizia'
                                  : 'Continua',
                            ),
                          )
                        else
                          const SizedBox(width: 48),
                      ],
                    ),
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

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.isCompact ? 24 : 48,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: context.scenaColors.gold.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'BENVENUTO IN SCENA',
              style: theme.textTheme.labelSmall?.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
                color: context.scenaColors.gold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 740),
            child: Text(
              'La serata giusta,\nsenza perdere mezz’ora a scegliere.',
              style: (context.isCompact
                      ? theme.textTheme.displaySmall
                      : theme.textTheme.displayMedium)
                  ?.copyWith(height: 1.05),
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'Scena guarda la tua libreria, il tempo che hai e l’umore del '
              'momento. Ti propone al massimo tre titoli e spiega perché.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final items = const [
                (
                  Icons.auto_awesome_rounded,
                  'Massimo 3 proposte',
                  'Niente cataloghi infiniti: solo poche scelte motivate.',
                ),
                (
                  Icons.lock_outline_rounded,
                  'Tutto sul dispositivo',
                  'Libreria, voti e note restano in locale. Nessun account.',
                ),
                (
                  Icons.play_circle_outline_rounded,
                  'Riprendi da dove eri',
                  'Serie con episodi, film in pausa e titoli lasciati indietro.',
                ),
              ];
              final columns = constraints.maxWidth >= 760 ? 3 : 1;
              final width =
                  (constraints.maxWidth - (columns - 1) * 12) / columns;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final item in items)
                    SizedBox(
                      width: width,
                      child: _FeatureCard(
                        icon: item.$1,
                        title: item.$2,
                        message: item.$3,
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Iniziamo'),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.scenaColors.gold),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TasteStep extends StatelessWidget {
  const _TasteStep({
    required this.draft,
    required this.onTogglePreferred,
    required this.onToggleAvoided,
  });

  final UserPreferences draft;
  final ValueChanged<int> onTogglePreferred;
  final ValueChanged<int> onToggleAvoided;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.isCompact ? 24 : 48,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Che cosa ti va?', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'Scegli i generi che ti attirano e quelli che preferisci evitare. '
            'Puoi cambiare tutto più tardi.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 26),
          _ChipGroup(
            title: 'Mi piacciono',
            subtitle: 'Danno priorità alle proposte.',
            genres: GenreCatalog.all,
            selected: draft.preferredGenres.toSet(),
            onToggle: onTogglePreferred,
            icon: Icons.favorite_outline_rounded,
          ),
          const SizedBox(height: 24),
          _ChipGroup(
            title: 'Preferisco evitare',
            subtitle: 'Abbassano il punteggio, senza sparire del tutto.',
            genres: GenreCatalog.all,
            selected: draft.avoidedGenres.toSet(),
            onToggle: onToggleAvoided,
            icon: Icons.remove_circle_outline_rounded,
          ),
        ],
      ),
    );
  }
}

class _ChipGroup extends StatelessWidget {
  const _ChipGroup({
    required this.title,
    required this.subtitle,
    required this.genres,
    required this.selected,
    required this.onToggle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final List<Genre> genres;
  final Set<int> selected;
  final ValueChanged<int> onToggle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
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
              Icon(icon, size: 20, color: context.scenaColors.gold),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final genre in genres)
                FilterChip(
                  label: Text(genre.name),
                  selected: selected.contains(genre.id),
                  onSelected: (_) => onToggle(genre.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EveningStep extends StatelessWidget {
  const _EveningStep({
    required this.draft,
    required this.onToggleService,
    required this.onThemeChanged,
    required this.onRuntimeChanged,
  });

  final UserPreferences draft;
  final ValueChanged<String> onToggleService;
  final ValueChanged<AppThemeMode> onThemeChanged;
  final ValueChanged<int> onRuntimeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final services = draft.streamingServices.toSet();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.isCompact ? 24 : 48,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('La tua serata tipo', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'Queste preferenze impostano il punto di partenza. Ogni sera '
            'potrai cambiarle in un tocco.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tempo tipico a disposizione',
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  draft.preferredRuntimeMinutes >= 60
                      ? '${draft.preferredRuntimeMinutes ~/ 60}h'
                          '${draft.preferredRuntimeMinutes % 60 == 0 ? "" : " ${draft.preferredRuntimeMinutes % 60}min"}'
                      : '${draft.preferredRuntimeMinutes} min',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: context.scenaColors.gold,
                  ),
                ),
                Slider(
                  value: draft.preferredRuntimeMinutes.toDouble(),
                  min: 45,
                  max: 240,
                  divisions: 13,
                  label: '${draft.preferredRuntimeMinutes} min',
                  onChanged: (value) => onRuntimeChanged(value.round()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('45 min', style: theme.textTheme.labelSmall),
                    Text('4 ore', style: theme.textTheme.labelSmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I tuoi servizi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Servono solo a contestualizzare le tue scelte: Scena non '
                  'verifica la disponibilità in streaming.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final service in kStreamingServices)
                      FilterChip(
                        label: Text(service.name),
                        selected: services.contains(service.id),
                        onSelected: (_) => onToggleService(service.id),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aspetto', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final mode in AppThemeMode.values)
                      ChoiceChip(
                        label: Text(mode.label),
                        selected: draft.themeMode == mode,
                        onSelected: (_) => onThemeChanged(mode),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Potrai configurare no assoluti, filtri e backup nelle '
            'impostazioni.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
