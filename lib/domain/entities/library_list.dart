/// Una lista personale della libreria.
///
/// Un titolo può appartenere a più liste contemporaneamente. La lista
/// [defaultName] esiste sempre e raccoglie i titoli a cui non viene assegnata
/// una lista esplicita.
class LibraryList {
  const LibraryList({
    required this.id,
    required this.name,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  static const String defaultName = 'Da vedere';

  final int id;
  final String name;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  LibraryList copyWith({
    int? id,
    String? name,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LibraryList(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
