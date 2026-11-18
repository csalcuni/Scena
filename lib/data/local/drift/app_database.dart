import 'package:drift/drift.dart';

import 'connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    MediaItems,
    LibraryEntries,
    ViewingEvents,
    UserPreferencesTable,
    DismissedSuggestions,
    CachedEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openScenaConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
      },
      onUpgrade: (migrator, from, to) async {
        // v1: media, libreria, eventi, preferenze, scarti.
        // v2: cache delle risposte TMDB per l'uso offline.
        if (from < 2) {
          await migrator.createTable(cachedEntries);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
