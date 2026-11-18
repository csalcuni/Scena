import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/config/app_config.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/breakpoints.dart';
import '../../core/utils/backup_file_saver.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/genre_catalog.dart';
import '../../domain/entities/streaming_service.dart';
import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/scena_logo.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  int? _runtimeDraft;
  var _busyData = false;

  Future<void> _update(
    UserPreferences Function(UserPreferences current) transform,
  ) async {
    try {
      await ref.read(preferencesProvider.notifier).updatePreferences(transform);
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    }
  }

  Future<void> _export() async {
    if (_busyData) return;
    setState(() => _busyData = true);
    try {
      final json = await ref.read(backupRepositoryProvider).exportJson();
      final destination = await saveBackupFile(json);
      if (!mounted) return;
      final copy = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Backup pronto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(destination),
              const SizedBox(height: 10),
              const Text(
                'Il file contiene libreria, voti, note, tag, eventi e '
                'preferenze. Conservalo in un luogo sicuro.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Chiudi'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.copy_rounded),
              label: const Text('Copia JSON'),
            ),
          ],
        ),
      );
      if (copy == true) {
        await Clipboard.setData(ClipboardData(text: json));
        if (!mounted) return;
        showScenaSnackBar(context, 'Backup copiato negli appunti.');
      }
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busyData = false);
    }
  }

  Future<void> _import() async {
    if (_busyData) return;
    final summary = await showDialog<BackupImportSummary>(
      context: context,
      builder: (context) => const _ImportBackupDialog(),
    );
    if (summary == null || !mounted) return;
    ref.invalidate(preferencesProvider);
    ref.invalidate(libraryProvider);
    ref.invalidate(dismissedSuggestionsProvider);
    showScenaSnackBar(
      context,
      'Backup importato: ${summary.entryCount} voci di libreria, '
      '${summary.eventCount} eventi.',
    );
  }

  Future<void> _clearAll() async {
    if (_busyData) return;
    final confirmed = await confirmAction(
      context,
      title: 'Cancellare tutti i dati?',
      message: 'Libreria, voti, note, tag, eventi, scarti e preferenze '
          'verranno eliminati da questo dispositivo. L’operazione non può '
          'essere annullata: esporta prima un backup se vuoi conservarli.',
      confirmLabel: 'Cancella tutto',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busyData = true);
    try {
      await ref.read(backupRepositoryProvider).clearAll();
      ref.invalidate(preferencesProvider);
      ref.invalidate(libraryProvider);
      ref.invalidate(dismissedSuggestionsProvider);
      if (!mounted) return;
      showScenaSnackBar(context, 'Dati locali cancellati.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busyData = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(preferencesProvider);
    return Scaffold(
      appBar: AppBar(title: const ScenaLogo(size: 30)),
      body: SafeArea(
        top: false,
        child: preferences.when(
          data: (prefs) => SingleChildScrollView(
            padding: context.pagePadding,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Impostazioni',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Preferenze, no assoluti e dati locali.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 22),
                    _AppearanceSection(
                      preferences: prefs,
                      onThemeChanged: (mode) => _update(
                        (current) => current.copyWith(themeMode: mode),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _EveningPreferencesSection(
                      preferences: prefs,
                      runtimeDraft: _runtimeDraft,
                      onRuntimeChanged: (value) =>
                          setState(() => _runtimeDraft = value),
                      onRuntimeCommitted: (value) async {
                        await _update(
                          (current) => current.copyWith(
                            preferredRuntimeMinutes: value,
                          ),
                        );
                        if (mounted) setState(() => _runtimeDraft = null);
                      },
                      onServiceToggle: (serviceId) => _update((current) {
                        final services =
                            current.streamingServices.toSet();
                        services.contains(serviceId)
                            ? services.remove(serviceId)
                            : services.add(serviceId);
                        return current.copyWith(
                          streamingServices: services.toList()..sort(),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    _TasteSection(
                      preferences: prefs,
                      onPreferredToggle: (genreId) => _update((current) {
                        final preferred =
                            current.preferredGenres.toSet();
                        final avoided = current.avoidedGenres.toSet()
                          ..remove(genreId);
                        preferred.contains(genreId)
                            ? preferred.remove(genreId)
                            : preferred.add(genreId);
                        return current.copyWith(
                          preferredGenres: preferred.toList()..sort(),
                          avoidedGenres: avoided.toList()..sort(),
                        );
                      }),
                      onAvoidedToggle: (genreId) => _update((current) {
                        final avoided = current.avoidedGenres.toSet();
                        final preferred =
                            current.preferredGenres.toSet()
                              ..remove(genreId);
                        avoided.contains(genreId)
                            ? avoided.remove(genreId)
                            : avoided.add(genreId);
                        return current.copyWith(
                          avoidedGenres: avoided.toList()..sort(),
                          preferredGenres: preferred.toList()..sort(),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    _ExclusionsSection(
                      preferences: prefs,
                      onGenreToggle: (genreId) => _update((current) {
                        final genres =
                            current.hardExclusions.genreIds.toSet();
                        genres.contains(genreId)
                            ? genres.remove(genreId)
                            : genres.add(genreId);
                        return current.copyWith(
                          hardExclusions: current.hardExclusions.copyWith(
                            genreIds: genres.toList()..sort(),
                          ),
                        );
                      }),
                      onMediaTypeToggle: (type) => _update((current) {
                        final types =
                            current.hardExclusions.mediaTypes.toSet();
                        types.contains(type)
                            ? types.remove(type)
                            : types.add(type);
                        return current.copyWith(
                          hardExclusions: current.hardExclusions.copyWith(
                            mediaTypes: types.toList(),
                          ),
                        );
                      }),
                      onKeywordAdded: (keyword) => _update((current) {
                        final keywords = current.hardExclusions.keywords
                            .map((value) => value.toLowerCase())
                            .toSet();
                        if (keywords.add(keyword.toLowerCase())) {
                          return current.copyWith(
                            hardExclusions: current.hardExclusions.copyWith(
                              keywords: [
                                ...current.hardExclusions.keywords,
                                keyword,
                              ],
                            ),
                          );
                        }
                        return current;
                      }),
                      onKeywordRemoved: (keyword) => _update((current) {
                        return current.copyWith(
                          hardExclusions: current.hardExclusions.copyWith(
                            keywords: current.hardExclusions.keywords
                                .where((value) => value != keyword)
                                .toList(),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    _DataSection(
                      busy: _busyData,
                      onExport: _export,
                      onImport: _import,
                      onClear: _clearAll,
                    ),
                    const SizedBox(height: 16),
                    const _AboutSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                userMessageFor(error),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(20);
    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: context.scenaColors.gold),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: theme.textTheme.titleLarge)),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection({
    required this.preferences,
    required this.onThemeChanged,
  });

  final UserPreferences preferences;
  final ValueChanged<AppThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      icon: Icons.palette_outlined,
      title: 'Aspetto',
      subtitle: 'Tema chiaro, scuro o in base al sistema.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final mode in AppThemeMode.values)
            ChoiceChip(
              label: Text(mode.label),
              selected: preferences.themeMode == mode,
              onSelected: (_) => onThemeChanged(mode),
            ),
        ],
      ),
    );
  }
}

class _EveningPreferencesSection extends StatelessWidget {
  const _EveningPreferencesSection({
    required this.preferences,
    required this.runtimeDraft,
    required this.onRuntimeChanged,
    required this.onRuntimeCommitted,
    required this.onServiceToggle,
  });

  final UserPreferences preferences;
  final int? runtimeDraft;
  final ValueChanged<int> onRuntimeChanged;
  final ValueChanged<int> onRuntimeCommitted;
  final ValueChanged<String> onServiceToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final services = preferences.streamingServices.toSet();
    final runtime = runtimeDraft ?? preferences.preferredRuntimeMinutes;
    return _SettingsCard(
      icon: Icons.nightlight_outlined,
      title: 'La tua serata tipo',
      subtitle: 'Il punto di partenza quando apri Scena.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Tempo tipico', style: theme.textTheme.titleSmall),
              const Spacer(),
              Text(
                runtime >= 60
                    ? '${runtime ~/ 60}h'
                        '${runtime % 60 == 0 ? '' : ' ${runtime % 60}min'}'
                    : '$runtime min',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: context.scenaColors.gold,
                ),
              ),
            ],
          ),
          Slider(
            value: runtime.toDouble(),
            min: 45,
            max: 240,
            divisions: 13,
            label: '$runtime min',
            onChanged: (value) => onRuntimeChanged(value.round()),
            onChangeEnd: (value) => onRuntimeCommitted(value.round()),
          ),
          const SizedBox(height: 6),
          Text('I tuoi servizi', style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(
            'Solo contesto: Scena non verifica la disponibilità in streaming.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final service in kStreamingServices)
                FilterChip(
                  label: Text(service.name),
                  selected: services.contains(service.id),
                  onSelected: (_) => onServiceToggle(service.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TasteSection extends StatelessWidget {
  const _TasteSection({
    required this.preferences,
    required this.onPreferredToggle,
    required this.onAvoidedToggle,
  });

  final UserPreferences preferences;
  final ValueChanged<int> onPreferredToggle;
  final ValueChanged<int> onAvoidedToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SettingsCard(
      icon: Icons.favorite_outline_rounded,
      title: 'Gusti',
      subtitle: 'Indirizzano il punteggio delle proposte.',
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 12),
            title: Text('Generi preferiti', style: theme.textTheme.titleSmall),
            subtitle: Text(
              preferences.preferredGenres.isEmpty
                  ? 'Nessuna preferenza'
                  : '${preferences.preferredGenres.length} selezionati',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            children: [
              _GenreChips(
                selected: preferences.preferredGenres.toSet(),
                onToggle: onPreferredToggle,
              ),
            ],
          ),
          const Divider(height: 1),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 12),
            title: Text('Generi da evitare', style: theme.textTheme.titleSmall),
            subtitle: Text(
              preferences.avoidedGenres.isEmpty
                  ? 'Nessun genere evitato'
                  : '${preferences.avoidedGenres.length} selezionati',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            children: [
              _GenreChips(
                selected: preferences.avoidedGenres.toSet(),
                onToggle: onAvoidedToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenreChips extends StatelessWidget {
  const _GenreChips({required this.selected, required this.onToggle});

  final Set<int> selected;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final genre in GenreCatalog.all)
            FilterChip(
              label: Text(genre.name),
              selected: selected.contains(genre.id),
              onSelected: (_) => onToggle(genre.id),
            ),
        ],
      ),
    );
  }
}

class _ExclusionsSection extends StatelessWidget {
  const _ExclusionsSection({
    required this.preferences,
    required this.onGenreToggle,
    required this.onMediaTypeToggle,
    required this.onKeywordAdded,
    required this.onKeywordRemoved,
  });

  final UserPreferences preferences;
  final ValueChanged<int> onGenreToggle;
  final ValueChanged<MediaType> onMediaTypeToggle;
  final ValueChanged<String> onKeywordAdded;
  final ValueChanged<String> onKeywordRemoved;

  Future<void> _addKeyword(BuildContext context) async {
    final controller = TextEditingController();
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuova parola da escludere'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 40,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            hintText: 'Es. zombie, guerra, musical',
            helperText: 'Confrontata con titolo, trama, tag e note.',
          ),
          onSubmitted: (text) => Navigator.of(context).pop(text),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
    controller.dispose();
    final keyword = value?.trim();
    if (keyword == null || keyword.isEmpty) return;
    onKeywordAdded(keyword);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exclusions = preferences.hardExclusions;
    return _SettingsCard(
      icon: Icons.block_rounded,
      title: 'No assoluti',
      subtitle: 'I titoli che li violano non vengono mai proposti.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Parole chiave', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final keyword in exclusions.keywords)
                InputChip(
                  label: Text(keyword),
                  onDeleted: () => onKeywordRemoved(keyword),
                  deleteIcon: const Icon(Icons.close_rounded, size: 16),
                ),
              ActionChip(
                avatar: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Aggiungi'),
                onPressed: () => _addKeyword(context),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text('Generi esclusi', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          _GenreChips(
            selected: exclusions.genreIds.toSet(),
            onToggle: onGenreToggle,
          ),
          const SizedBox(height: 18),
          Text('Tipi di contenuto', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final type in MediaType.values)
                FilterChip(
                  label: Text('Blocca ${type.label.toLowerCase()}'),
                  selected: exclusions.mediaTypes.contains(type),
                  onSelected: (_) => onMediaTypeToggle(type),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataSection extends StatelessWidget {
  const _DataSection({
    required this.busy,
    required this.onExport,
    required this.onImport,
    required this.onClear,
  });

  final bool busy;
  final VoidCallback onExport;
  final VoidCallback onImport;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SettingsCard(
      icon: Icons.storage_outlined,
      title: 'I tuoi dati',
      subtitle: 'Tutto è locale. Esporta o importa quando vuoi.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              OutlinedButton.icon(
                onPressed: busy ? null : onExport,
                icon: const Icon(Icons.download_rounded),
                label: const Text('Esporta JSON'),
              ),
              OutlinedButton.icon(
                onPressed: busy ? null : onImport,
                icon: const Icon(Icons.upload_rounded),
                label: const Text('Importa JSON'),
              ),
              TextButton.icon(
                onPressed: busy ? null : onClear,
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                ),
                icon: const Icon(Icons.delete_forever_outlined),
                label: const Text('Cancella tutti i dati'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'L’importazione sostituisce i dati attuali. La cancellazione '
            'rimuove anche la cache delle ricerche e riporta l’app '
            'all’onboarding.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SettingsCard(
      icon: Icons.info_outline_rounded,
      title: 'Informazioni',
      subtitle: 'Scena 1.0.0 · MVP locale',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: 'Sorgente dati', value: AppConfig.dataModeLabel),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Archiviazione',
            value: 'SQLite / Drift sul dispositivo',
          ),
          const SizedBox(height: 14),
          Text(
            'Questa app usa l’API di TMDB per metadati e immagini, ma non è '
            'approvata né certificata da TMDB. Scena non verifica la '
            'disponibilità in streaming e non offre account, recensioni o '
            'funzioni social.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'This product uses the TMDB API but is not endorsed or certified '
            'by TMDB.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: theme.textTheme.bodySmall),
        ),
      ],
    );
  }
}

class _ImportBackupDialog extends ConsumerStatefulWidget {
  const _ImportBackupDialog();

  @override
  ConsumerState<_ImportBackupDialog> createState() =>
      _ImportBackupDialogState();
}

class _ImportBackupDialogState extends ConsumerState<_ImportBackupDialog> {
  final TextEditingController _controller = TextEditingController();
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.isEmpty) return;
    _controller.text = text;
    setState(() {});
  }

  Future<void> _import() async {
    if (_busy) return;
    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      setState(() => _error = 'Incolla il contenuto di un backup.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final summary =
          await ref.read(backupRepositoryProvider).importJson(raw);
      if (!mounted) return;
      Navigator.of(context).pop(summary);
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = userMessageFor(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Importa un backup'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Incolla il JSON esportato da Scena. I dati attuali verranno '
              'sostituiti.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 10,
              minLines: 6,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
              decoration: InputDecoration(
                hintText: '{"format": "scena-backup", ...}',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _busy ? null : _paste,
              icon: const Icon(Icons.content_paste_rounded),
              label: const Text('Incolla dagli appunti'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        FilledButton.icon(
          onPressed: _busy ? null : _import,
          icon: _busy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.upload_rounded),
          label: const Text('Importa'),
        ),
      ],
    );
  }
}
