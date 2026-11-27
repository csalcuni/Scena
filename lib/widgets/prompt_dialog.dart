import 'package:material_ui/material_ui.dart';

/// Dialog con un singolo campo di testo. Il controller appartiene allo Stato
/// del dialog e viene rilasciato solo quando la route è davvero chiusa: chiude
/// subito il controller dopo `showDialog` provocherebbe un errore con il
/// TextField ancora montato durante l'animazione di pop.
Future<String?> promptText(
  BuildContext context, {
  required String title,
  String initialText = '',
  String labelText = '',
  String hintText = '',
  String? helperText,
  int maxLength = 60,
  String actionLabel = 'Salva',
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _PromptDialog(
      title: title,
      initialText: initialText,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      maxLength: maxLength,
      actionLabel: actionLabel,
    ),
  );
}

class _PromptDialog extends StatefulWidget {
  const _PromptDialog({
    required this.title,
    required this.initialText,
    required this.labelText,
    required this.hintText,
    required this.helperText,
    required this.maxLength,
    required this.actionLabel,
  });

  final String title;
  final String initialText;
  final String labelText;
  final String hintText;
  final String? helperText;
  final int maxLength;
  final String actionLabel;

  @override
  State<_PromptDialog> createState() => _PromptDialogState();
}

class _PromptDialogState extends State<_PromptDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialText,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: widget.maxLength,
        textInputAction: TextInputAction.done,
        onSubmitted: (text) => Navigator.of(context).pop(text),
        decoration: InputDecoration(
          labelText: widget.labelText.isEmpty ? null : widget.labelText,
          hintText: widget.hintText.isEmpty ? null : widget.hintText,
          helperText: widget.helperText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(widget.actionLabel),
        ),
      ],
    );
  }
}
