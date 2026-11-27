import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/library_list.dart';
import '../../widgets/prompt_dialog.dart';

Future<String?> promptListName(
  BuildContext context, {
  required String title,
  String initialName = '',
  String actionLabel = 'Salva',
}) async {
  final value = await promptText(
    context,
    title: title,
    initialText: initialName,
    labelText: 'Nome della lista',
    hintText: 'Es. Film anni 80, Film di Walter Hill',
    actionLabel: actionLabel,
  );
  final normalized = value?.trim();
  if (normalized == null || normalized.isEmpty) return null;
  return normalized;
}

/// Chiede un nome e crea una nuova lista. Restituisce la lista creata, oppure
/// `null` se l'utente annulla o il nome non è valido.
Future<LibraryList?> createLibraryList(
  BuildContext context,
  WidgetRef ref,
) async {
  final name = await promptListName(context, title: 'Nuova lista');
  if (name == null || !context.mounted) return null;
  try {
    final list = await ref.read(libraryListRepositoryProvider).create(name);
    if (!context.mounted) return list;
    showScenaSnackBar(context, 'Lista «${list.name}» creata.');
    return list;
  } on Object catch (error) {
    if (!context.mounted) return null;
    showScenaSnackBar(context, userMessageFor(error));
    return null;
  }
}
