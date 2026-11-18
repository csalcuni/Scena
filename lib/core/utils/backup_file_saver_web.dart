import 'dart:js_interop';

import 'package:web/web.dart' as web;

Future<String> saveBackupFile(String json) async {
  final blob = web.Blob(
    <JSAny>[json.toJS].toJS,
    web.BlobPropertyBag(type: 'application/json'),
  );
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = 'scena-backup-${_timestamp(DateTime.now())}.json';
  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
  return 'Download avviato dal browser.';
}

String _timestamp(DateTime date) {
  String two(int value) => value.toString().padLeft(2, '0');
  return '${date.year}${two(date.month)}${two(date.day)}-'
      '${two(date.hour)}${two(date.minute)}${two(date.second)}';
}
