import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/library_list.dart';
import '../../widgets/confirm_dialog.dart';
import 'list_dialogs.dart';

Future<void> showLibraryListsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => const LibraryListsSheet(),
  );
}

class LibraryListsSheet extends ConsumerStatefulWidget {
  const LibraryListsSheet({super.key});

  @override
  ConsumerState<LibraryListsSheet> createState() => _LibraryListsSheetState();
}

class _LibraryListsSheetState extends ConsumerState<LibraryListsSheet> {
  final _nameController = TextEditingController();
  var _busy = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final name = _nameController.text.trim();
    if (name.isEmpty || _busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(libraryListRepositoryProvider).create(name);
      _nameController.clear();
      if (!mounted) return;
      showScenaSnackBar(context, 'Lista «$name» creata.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _rename(LibraryList list) async {
    final name = await promptListName(
      context,
      title: 'Rinomina la lista',
      initialName: list.name,
    );
    if (name == null || name == list.name || !mounted) return;
    try {
      await ref.read(libraryListRepositoryProvider).rename(list.id, name);
      if (!mounted) return;
      showScenaSnackBar(context, 'Lista rinominata in «$name».');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    }
  }

  Future<void> _delete(LibraryList list) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminare la lista?',
      message:
          'La lista «${list.name}» verrà eliminata. I titoli restano nella '
          'libreria: se erano solo qui, tornano in «${LibraryList.defaultName}».',
      confirmLabel: 'Elimina',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    try {
      await ref.read(libraryListRepositoryProvider).delete(list.id);
      ref.read(eveningRequestProvider.notifier).removeList(list.id);
      if (!mounted) return;
      showScenaSnackBar(context, 'Lista «${list.name}» eliminata.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lists =
        ref.watch(libraryListsProvider).value ?? const <LibraryList>[];
    final library = ref.watch(libraryProvider).value ?? const [];
    final counts = <int, int>{};
    for (final item in library) {
      for (final listId in item.entry.listIds) {
        counts.update(listId, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    return ConstrainedBox(
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
            Text('Le tue liste', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Un titolo può comparire in più liste. Se non ne scegli una, '
              'viene salvato in «${LibraryList.defaultName}».',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    maxLength: 60,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _create(),
                    decoration: const InputDecoration(
                      labelText: 'Nuova lista',
                      hintText: 'Es. Film anni 80, Film di Walter Hill',
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: FilledButton.icon(
                    onPressed: _busy ? null : _create,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Crea'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (lists.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    for (var index = 0; index < lists.length; index++) ...[
                      if (index > 0) const Divider(height: 1),
                      _ListTile(
                        list: lists[index],
                        count: counts[lists[index].id] ?? 0,
                        onRename: () => _rename(lists[index]),
                        onDelete: () => _delete(lists[index]),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Chiudi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.list,
    required this.count,
    required this.onRename,
    required this.onDelete,
  });

  final LibraryList list;
  final int count;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        list.isDefault
            ? Icons.bookmark_rounded
            : Icons.playlist_play_rounded,
        color: list.isDefault ? context.scenaColors.gold : null,
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              list.name,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),
          if (list.isDefault) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: context.scenaColors.gold.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Predefinita',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: context.scenaColors.gold,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(
        '$count ${count == 1 ? 'titolo' : 'titoli'}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: list.isDefault
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onRename,
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  tooltip: 'Rinomina',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                  tooltip: 'Elimina',
                ),
              ],
            ),
    );
  }
}
