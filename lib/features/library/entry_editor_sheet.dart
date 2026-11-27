import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/snackbars.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/library_entry.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/media_artwork.dart';
import 'list_dialogs.dart';

Future<void> showLibraryEditor(
  BuildContext context,
  LibraryEntryWithMedia item,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _LibraryEntryEditor(item: item),
  );
}

class _LibraryEntryEditor extends ConsumerStatefulWidget {
  const _LibraryEntryEditor({required this.item});

  final LibraryEntryWithMedia item;

  @override
  ConsumerState<_LibraryEntryEditor> createState() =>
      _LibraryEntryEditorState();
}

class _LibraryEntryEditorState extends ConsumerState<_LibraryEntryEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _note;
  late final TextEditingController _tags;
  late final TextEditingController _season;
  late final TextEditingController _episode;
  late LibraryStatus _status;
  late int _rating;
  late Set<int> _listIds;
  var _busy = false;

  bool get _isTv => widget.item.media.mediaType == MediaType.tv;

  @override
  void initState() {
    super.initState();
    final entry = widget.item.entry;
    _status = entry.status;
    _rating = entry.personalRating ?? 0;
    _listIds = {...entry.listIds};
    _note = TextEditingController(text: entry.personalNote ?? '');
    _tags = TextEditingController(text: entry.tags.join(', '));
    _season = TextEditingController(
      text: entry.currentSeason?.toString() ?? '',
    );
    _episode = TextEditingController(
      text: entry.currentEpisode?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _note.dispose();
    _tags.dispose();
    _season.dispose();
    _episode.dispose();
    super.dispose();
  }

  List<String> get _parsedTags {
    final seen = <String>{};
    final result = <String>[];
    for (final raw in _tags.text.split(',')) {
      final tag = raw.trim();
      if (tag.isEmpty) continue;
      final normalized = tag.toLowerCase();
      if (seen.add(normalized)) result.add(tag);
    }
    return result;
  }

  Future<void> _save() async {
    if (_busy) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _busy = true);
    final entry = widget.item.entry;
    try {
      var current = entry;
      if (_status != entry.status) {
        current = await ref
            .read(changeLibraryStatusProvider)
            .call(widget.item, _status);
      }

      final note = _note.text.trim();
      final season = int.tryParse(_season.text.trim());
      final episode = int.tryParse(_episode.text.trim());
      await ref.read(updateLibraryEntryProvider).call(
            current,
            rating: _rating == 0 ? null : _rating,
            clearRating: _rating == 0,
            note: note.isEmpty ? null : note,
            clearNote: note.isEmpty,
            tags: _parsedTags,
            currentSeason: _isTv ? (season ?? current.currentSeason) : null,
            currentEpisode: _isTv ? (episode ?? current.currentEpisode) : null,
          );
      await ref
          .read(libraryListRepositoryProvider)
          .setEntryLists(entry.id, _listIds);
      if (!mounted) return;
      Navigator.of(context).pop();
      showScenaSnackBar(context, 'Voce aggiornata.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
      setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await confirmAction(
      context,
      title: 'Rimuovere dalla libreria?',
      message: '«${widget.item.media.title}» e i suoi eventi verranno '
          'eliminati definitivamente.',
      confirmLabel: 'Rimuovi',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(libraryRepositoryProvider)
          .deleteEntry(widget.item.entry.id);
      if (!mounted) return;
      Navigator.of(context).pop();
      showScenaSnackBar(context, 'Titolo rimosso dalla libreria.');
    } on Object catch (error) {
      if (!mounted) return;
      showScenaSnackBar(context, userMessageFor(error));
      setState(() => _busy = false);
    }
  }

  Future<void> _createList() async {
    final list = await createLibraryList(context, ref);
    if (list == null || !mounted) return;
    setState(() => _listIds.add(list.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = widget.item;
    final lists = ref.watch(libraryListsProvider).value ?? const [];
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
          maxWidth: 720,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaPoster(
                      media: item.media,
                      width: 52,
                      height: 78,
                      borderRadius: 10,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.media.title,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.media.mediaType.label} · '
                            '${item.media.releaseYear ?? 'Anno sconosciuto'}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text('Stato', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final status in LibraryStatus.values)
                      ChoiceChip(
                        label: Text(status.label),
                        selected: _status == status,
                        onSelected: (_) => setState(() => _status = status),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Voto personale',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_rating > 0)
                      Text(
                        '$_rating/10',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: context.scenaColors.gold,
                        ),
                      )
                    else
                      Text(
                        'Nessun voto',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                Slider(
                  value: _rating.toDouble(),
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _rating == 0 ? 'Nessun voto' : '$_rating/10',
                  onChanged: (value) => setState(() => _rating = value.round()),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _note,
                  maxLines: 3,
                  minLines: 2,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    labelText: 'Nota personale',
                    hintText: 'Perché l’hai salvato? Con chi lo guarderesti?',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _tags,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: 'Tag',
                    hintText: 'natale, famiglia, comfort movie',
                    helperText: 'Separati da una virgola.',
                  ),
                ),
                if (_parsedTags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final tag in _parsedTags)
                        Chip(
                          label: Text('#$tag'),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Text('Liste', style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Un titolo può stare in più liste. Se non ne selezioni '
                  'nessuna, resta in «Da vedere».',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final list in lists)
                      FilterChip(
                        label: Text(
                          list.isDefault
                              ? '${list.name} (predefinita)'
                              : list.name,
                        ),
                        selected: _listIds.contains(list.id),
                        onSelected: (selected) => setState(() {
                          if (selected) {
                            _listIds.add(list.id);
                          } else {
                            _listIds.remove(list.id);
                          }
                        }),
                      ),
                    ActionChip(
                      avatar: const Icon(Icons.add_rounded, size: 16),
                      label: const Text('Nuova lista'),
                      onPressed: _busy ? null : _createList,
                    ),
                  ],
                ),
                if (_isTv) ...[
                  const SizedBox(height: 18),
                  Text(
                    'Prossimo episodio da guardare',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Indica l’episodio successivo, non l’ultimo visto.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _season,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Stagione',
                          ),
                          validator: _positiveValidator,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _episode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Episodio',
                          ),
                          validator: _positiveValidator,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: _busy ? null : _delete,
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                      icon: const Icon(Icons.delete_outline_rounded),
                      label: const Text('Rimuovi'),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: _busy ? null : _save,
                      icon: _busy
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_rounded),
                      label: const Text('Salva'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _positiveValidator(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 1) return 'Numero non valido';
    return null;
  }
}
