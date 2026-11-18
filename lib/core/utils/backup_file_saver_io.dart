import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> saveBackupFile(String json) async {
  final directory = await getApplicationDocumentsDirectory();
  final stamp = _timestamp(DateTime.now());
  final file = File(p.join(directory.path, 'scena-backup-$stamp.json'));
  await file.writeAsString(json, flush: true);
  return file.path;
}

String _timestamp(DateTime date) {
  String two(int value) => value.toString().padLeft(2, '0');
  return '${date.year}${two(date.month)}${two(date.day)}-'
      '${two(date.hour)}${two(date.minute)}${two(date.second)}';
}
