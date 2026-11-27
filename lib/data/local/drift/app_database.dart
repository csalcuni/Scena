import 'package:drift/drift.dart';

import '../../../domain/entities/library_list.dart';
import 'connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    MediaItems,
    LibraryEntries,
    LibraryLists,
    LibraryListEntries,
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
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
        await _ensureDefaultList(DateTime.now());
      },
      onUpgrade: (migrator, from, to) async {
        // v1: media, libreria, eventi, preferenze, scarti.
        // v2: cache delle risposte TMDB per l'uso offline.
        // v3: liste personali e appartenenza molti-a-molti.
        // v4: ripristino delle tabelle delle liste nei database che erano già
        //     marcati come v3 ma non le avevano ancora create.
        final now = DateTime.now();
        if (from < 2) {
          await _createIfMissing(migrator, cachedEntries);
        }
        if (from < 3) {
          await _createIfMissing(migrator, libraryLists);
          await _createIfMissing(migrator, libraryListEntries);
        }
        if (from < 4) {
          await _createIfMissing(migrator, libraryLists);
          await _createIfMissing(migrator, libraryListEntries);
          await _backfillLists(now);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// `Migrator.createTable` usa `CREATE TABLE` senza `IF NOT EXISTS`: in una
  /// migrazione idempotente ignoriamo solo l'errore di tabella già presente.
  Future<void> _createIfMissing(Migrator migrator, TableInfo table) async {
    try {
      await migrator.createTable(table);
    } on Object catch (error) {
      if (!error.toString().toLowerCase().contains('already exists')) {
        rethrow;
      }
    }
  }

  /// Assegna alla lista predefinita i titoli che non appartengono ad alcuna
  /// lista. È idempotente e viene usata dalle migrazioni v3 e v4.
  Future<void> _backfillLists(DateTime now) async {
    final defaultId = await _ensureDefaultList(now);
    final entries = await select(libraryEntries).get();
    for (final entry in entries) {
      final existing = await (select(libraryListEntries)
            ..where((table) => table.libraryEntryId.equals(entry.id)))
          .get();
      if (existing.isNotEmpty) continue;
      await into(libraryListEntries).insert(
        LibraryListEntriesCompanion.insert(
          listId: defaultId,
          libraryEntryId: entry.id,
          addedAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }

  Future<int> _ensureDefaultList(DateTime now) async {
    final existingDefault = await (select(libraryLists)
          ..where((table) => table.isDefault.equals(true)))
        .getSingleOrNull();
    if (existingDefault != null) return existingDefault.id;

    final namedDefault = await (select(libraryLists)
          ..where(
            (table) => table.name.lower().equals(
                  LibraryList.defaultName.toLowerCase(),
                ),
          ))
        .getSingleOrNull();
    if (namedDefault != null) {
      await (update(libraryLists)
            ..where((table) => table.id.equals(namedDefault.id)))
          .write(const LibraryListsCompanion(isDefault: Value(true)));
      return namedDefault.id;
    }

    return into(libraryLists).insert(
      LibraryListsCompanion.insert(
        name: LibraryList.defaultName,
        isDefault: const Value(true),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }
}
