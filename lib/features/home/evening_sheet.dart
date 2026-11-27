import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/evening.dart';

Future<void> showEveningSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => const EveningSheet(),
  );
}

class EveningSheet extends ConsumerStatefulWidget {
  const EveningSheet({super.key});

  @override
  ConsumerState<EveningSheet> createState() => _EveningSheetState();
}

class _EveningSheetState extends ConsumerState<EveningSheet> {
  late EveningRequest _draft;

  static const _timeOptions = <int?>[45, 60, 75, 90, 120, 150, 180, null];

  @override
  void initState() {
    super.initState();
    _draft = ref.read(eveningRequestProvider);
  }

  void _setTime(int? minutes) {
    setState(() {
      _draft = _draft.copyWith(
        availableMinutes: minutes,
        clearAvailableMinutes: minutes == null,
      );
    });
  }

  void _apply() {
    ref.read(eveningRequestProvider.notifier).setRequest(_draft);
    Navigator.of(context).pop();
  }

  void _reset() {
    setState(() {
      _draft = EveningRequest(
        availableMinutes:
            ref.read(preferencesProvider).value?.preferredRuntimeMinutes ??
                120,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final lists = ref.watch(libraryListsProvider).value ?? const [];
    final filterCount = [
      _draft.noHorror,
      _draft.noRomance,
      _draft.familyOnly,
    ].where((value) => value).length;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          maxWidth: 680,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Imposta la serata', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Scena userà questi vincoli per scegliere al massimo tre titoli.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 22),
              Text('Tempo a disposizione', style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final option in _timeOptions)
                    ChoiceChip(
                      label: Text(_timeLabel(option)),
                      selected: _draft.availableMinutes == option,
                      onSelected: (_) => _setTime(option),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Umore', style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final mood in Mood.values)
                    ChoiceChip(
                      label: Text(mood.label),
                      selected: _draft.mood == mood,
                      onSelected: (_) => setState(() {
                        _draft = _draft.copyWith(mood: mood);
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Compagnia', style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final contextValue in ViewingContext.values)
                    ChoiceChip(
                      label: Text(contextValue.label),
                      selected: _draft.context == contextValue,
                      onSelected: (_) => setState(() {
                        _draft = _draft.copyWith(context: contextValue);
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Liste da cui scegliere',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Se non selezioni nulla, l’algoritmo considera tutte le liste.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Tutte le liste'),
                    selected: _draft.listIds.isEmpty,
                    onSelected: (_) => setState(() {
                      _draft = _draft.copyWith(listIds: const {});
                    }),
                  ),
                  for (final list in lists)
                    FilterChip(
                      label: Text(
                        list.isDefault
                            ? '${list.name} (predefinita)'
                            : list.name,
                      ),
                      selected: _draft.listIds.contains(list.id),
                      onSelected: (selected) => setState(() {
                        final next = {..._draft.listIds};
                        if (selected) {
                          next.add(list.id);
                        } else {
                          next.remove(list.id);
                        }
                        _draft = _draft.copyWith(listIds: next);
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _draft.noHorror,
                      onChanged: (value) => setState(() {
                        _draft = _draft.copyWith(noHorror: value);
                      }),
                      title: const Text('Niente horror'),
                      subtitle: const Text('Esclude i titoli horror.'),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      value: _draft.noRomance,
                      onChanged: (value) => setState(() {
                        _draft = _draft.copyWith(noRomance: value);
                      }),
                      title: const Text('Niente romance'),
                      subtitle: const Text('Esclude le storie romantiche.'),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      value: _draft.familyOnly,
                      onChanged: (value) => setState(() {
                        _draft = _draft.copyWith(familyOnly: value);
                      }),
                      title: const Text('Serata in famiglia'),
                      subtitle: const Text(
                        'Esclude horror, thriller, crime e temi adulti. '
                        'Non è una classificazione ufficiale.',
                      ),
                    ),
                  ],
                ),
              ),
              if (filterCount > 0) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.filter_alt_outlined,
                      size: 16,
                      color: context.scenaColors.gold,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$filterCount vincoli attivi',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 26),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('Azzera'),
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: _apply,
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Applica'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _timeLabel(int? minutes) {
    if (minutes == null) return 'Illimitato';
    if (minutes % 60 == 0) return '${minutes ~/ 60}h';
    if (minutes > 60) {
      return '${minutes ~/ 60}h ${minutes % 60}min';
    }
    return '$minutes min';
  }
}
