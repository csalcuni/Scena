import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../domain/entities/library_list.dart';
import 'list_dialogs.dart';

/// Selettore della lista di destinazione. `value == null` indica la lista
/// predefinita.
class ListTargetSelector extends ConsumerWidget {
  const ListTargetSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Aggiungi a',
  });

  final int? value;
  final ValueChanged<int?> onChanged;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists =
        ref.watch(libraryListsProvider).value ?? const <LibraryList>[];
    if (lists.isEmpty) return const SizedBox.shrink();

    final defaultList = lists.firstWhere(
      (list) => list.isDefault,
      orElse: () => lists.first,
    );
    final selected = value != null && lists.any((list) => list.id == value)
        ? value!
        : defaultList.id;

    return Row(
      children: [
        Expanded(
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: const Icon(Icons.playlist_add_rounded),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                value: selected,
                items: [
                  for (final list in lists)
                    DropdownMenuItem<int>(
                      value: list.id,
                      child: Text(
                        list.isDefault
                            ? '${list.name} (predefinita)'
                            : list.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (listId) => onChanged(listId),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: () async {
            final list = await createLibraryList(context, ref);
            if (list != null) onChanged(list.id);
          },
          icon: const Icon(Icons.add_rounded),
          tooltip: 'Nuova lista',
        ),
      ],
    );
  }
}
