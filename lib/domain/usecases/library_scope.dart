import '../entities/library_entry.dart';

/// Restituisce i titoli che appartengono ad almeno una delle liste indicate.
/// Un insieme vuoto significa "tutte le liste".
List<LibraryEntryWithMedia> entriesInLists(
  List<LibraryEntryWithMedia> library,
  Set<int> listIds,
) {
  if (listIds.isEmpty) return library;
  return library
      .where((item) => item.entry.listIds.any(listIds.contains))
      .toList(growable: false);
}
