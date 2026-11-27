import 'package:drift/drift.dart';

import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/library_list.dart';
import '../../../domain/repositories/library_list_repository.dart';
import '../drift/app_database.dart';

class DriftLibraryListRepository implements LibraryListRepository {
  const DriftLibraryListRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<LibraryList>> watchAll() {
    final query = _database.select(_database.libraryLists)
      ..orderBy([
        (table) => OrderingTerm.desc(table.isDefault),
        (table) => OrderingTerm.asc(table.name),
      ]);
    return query.watch().map(_mapRows);
  }

  @override
  Future<List<LibraryList>> getAll() async {
    final query = _database.select(_database.libraryLists)
      ..orderBy([
        (table) => OrderingTerm.desc(table.isDefault),
        (table) => OrderingTerm.asc(table.name),
      ]);
    return _mapRows(await query.get());
  }

  @override
  Future<LibraryList> ensureDefault() async {
    final id = await _ensureDefaultId(DateTime.now());
    final row = await (_database.select(_database.libraryLists)
          ..where((table) => table.id.equals(id)))
        .getSingle();
    return _map(row);
  }

  @override
  Future<LibraryList> create(String name) async {
    final normalized = _validateName(name);
    final now = DateTime.now();
    return _database.transaction(() async {
      await _ensureDefaultId(now);
      await _ensureUniqueName(normalized);
      final id = await _database.into(_database.libraryLists).insert(
            LibraryListsCompanion.insert(
              name: normalized,
              createdAt: now,
              updatedAt: now,
            ),
          );
      return LibraryList(
        id: id,
        name: normalized,
        createdAt: now,
        updatedAt: now,
      );
    });
  }

  @override
  Future<LibraryList> rename(int id, String name) async {
    final normalized = _validateName(name);
    final existing = await (_database.select(_database.libraryLists)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
    if (existing == null) {
      throw const ValidationException('La lista non esiste più.');
    }
    if (existing.isDefault) {
      throw const ValidationException(
        'La lista predefinita non può essere rinominata.',
      );
    }
    final now = DateTime.now();
    return _database.transaction(() async {
      await _ensureUniqueName(normalized, excludingId: id);
      await (_database.update(_database.libraryLists)
            ..where((table) => table.id.equals(id)))
          .write(
        LibraryListsCompanion(
          name: Value(normalized),
          updatedAt: Value(now),
        ),
      );
      return LibraryList(
        id: id,
        name: normalized,
        createdAt: existing.createdAt,
        updatedAt: now,
      );
    });
  }

  @override
  Future<void> delete(int id) async {
    final existing = await (_database.select(_database.libraryLists)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
    if (existing == null) return;
    if (existing.isDefault) {
      throw const ValidationException(
        'La lista predefinita non può essere eliminata.',
      );
    }

    final now = DateTime.now();
    await _database.transaction(() async {
      final rows = await (_database.select(_database.libraryListEntries)
            ..where((table) => table.listId.equals(id)))
          .get();
      final entryIds = rows.map((row) => row.libraryEntryId).toList();

      await (_database.delete(_database.libraryLists)
            ..where((table) => table.id.equals(id)))
          .go();

      // Un titolo che era solo in questa lista non resta orfano: torna nella
      // lista predefinita, come quando viene salvato senza una lista.
      final defaultId = await _ensureDefaultId(now);
      for (final entryId in entryIds) {
        final remaining = await (_database.select(_database.libraryListEntries)
              ..where(
                (table) => table.libraryEntryId.equals(entryId),
              ))
            .get();
        if (remaining.isNotEmpty) continue;
        await _database.into(_database.libraryListEntries).insert(
              LibraryListEntriesCompanion.insert(
                listId: defaultId,
                libraryEntryId: entryId,
                addedAt: now,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    });
  }

  @override
  Future<void> setEntryLists(int libraryEntryId, Set<int> listIds) async {
    final now = DateTime.now();
    await _database.transaction(() async {
      final defaultId = await _ensureDefaultId(now);
      final validIds = await _validListIds(listIds);
      final targetIds = validIds.isEmpty ? {defaultId} : validIds;

      await (_database.delete(_database.libraryListEntries)
            ..where((table) => table.libraryEntryId.equals(libraryEntryId)))
          .go();
      for (final listId in targetIds) {
        await _database.into(_database.libraryListEntries).insert(
              LibraryListEntriesCompanion.insert(
                listId: listId,
                libraryEntryId: libraryEntryId,
                addedAt: now,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    });
  }

  @override
  Future<void> addEntryToList(int libraryEntryId, int listId) async {
    await _database.into(_database.libraryListEntries).insert(
          LibraryListEntriesCompanion.insert(
            listId: listId,
            libraryEntryId: libraryEntryId,
            addedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<Set<int>> _validListIds(Set<int> listIds) async {
    if (listIds.isEmpty) return const {};
    final rows = await (_database.select(_database.libraryLists)
          ..where((table) => table.id.isIn(listIds)))
        .get();
    return rows.map((row) => row.id).toSet();
  }

  Future<void> _ensureUniqueName(String name, {int? excludingId}) async {
    final query = _database.select(_database.libraryLists)
      ..where((table) => table.name.lower().equals(name.toLowerCase()));
    if (excludingId != null) {
      query.where((table) => table.id.equals(excludingId).not());
    }
    final existing = await query.getSingleOrNull();
    if (existing != null) {
      throw ValidationException('Esiste già una lista chiamata «$name».');
    }
  }

  String _validateName(String name) {
    final normalized = name.trim();
    if (normalized.isEmpty) {
      throw const ValidationException('Il nome della lista non può essere vuoto.');
    }
    if (normalized.length > 60) {
      throw const ValidationException(
        'Il nome della lista non può superare 60 caratteri.',
      );
    }
    return normalized;
  }

  Future<int> _ensureDefaultId(DateTime now) async {
    final existingDefault = await (_database.select(_database.libraryLists)
          ..where((table) => table.isDefault.equals(true)))
        .getSingleOrNull();
    if (existingDefault != null) return existingDefault.id;

    final namedDefault = await (_database.select(_database.libraryLists)
          ..where(
            (table) => table.name.lower().equals(
                  LibraryList.defaultName.toLowerCase(),
                ),
          ))
        .getSingleOrNull();
    if (namedDefault != null) {
      await (_database.update(_database.libraryLists)
            ..where((table) => table.id.equals(namedDefault.id)))
          .write(const LibraryListsCompanion(isDefault: Value(true)));
      return namedDefault.id;
    }

    return _database.into(_database.libraryLists).insert(
          LibraryListsCompanion.insert(
            name: LibraryList.defaultName,
            isDefault: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  List<LibraryList> _mapRows(List<LibraryListRow> rows) {
    return rows.map(_map).toList(growable: false);
  }

  LibraryList _map(LibraryListRow row) {
    return LibraryList(
      id: row.id,
      name: row.name,
      isDefault: row.isDefault,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
