import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

QueryExecutor openScenaConnection() {
  return DatabaseConnection.delayed(
    Future(() async {
      final result = await WasmDatabase.open(
        databaseName: 'scena_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );
      if (result.missingFeatures.isNotEmpty) {
        debugPrint(
          'Scena web: storage ${result.chosenImplementation.name}; '
          'funzionalità mancanti: ${result.missingFeatures.join(', ')}',
        );
      }
      return result.resolvedExecutor;
    }),
  );
}
