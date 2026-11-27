import '../entities/library_list.dart';

abstract interface class LibraryListRepository {
  /// Elenca le liste, con quella predefinita in testa.
  Stream<List<LibraryList>> watchAll();

  Future<List<LibraryList>> getAll();

  /// Crea la lista predefinita se non esiste e la restituisce.
  Future<LibraryList> ensureDefault();

  Future<LibraryList> create(String name);

  Future<LibraryList> rename(int id, String name);

  /// Elimina una lista personale. La lista predefinita non è eliminabile.
  Future<void> delete(int id);

  /// Sostituisce le liste di una voce. Se l'insieme è vuoto viene usata la
  /// lista predefinita.
  Future<void> setEntryLists(int libraryEntryId, Set<int> listIds);

  Future<void> addEntryToList(int libraryEntryId, int listId);
}
