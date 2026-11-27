import 'package:flutter_test/flutter_test.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/library_entry.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/usecases/library_scope.dart';

void main() {
  final now = DateTime(2026, 5, 20);

  LibraryEntryWithMedia item(int id, Set<int> listIds) {
    return LibraryEntryWithMedia(
      media: MediaItem(
        tmdbId: id,
        mediaType: MediaType.movie,
        title: 'Film $id',
      ),
      entry: LibraryEntry(
        id: id,
        mediaItemId: id,
        status: LibraryStatus.toWatch,
        listIds: listIds,
        lastActivityAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  test('un insieme vuoto significa tutte le liste', () {
    final library = [item(1, {1}), item(2, {2})];
    expect(entriesInLists(library, const {}), library);
  });

  test('filtra i titoli presenti in almeno una lista scelta', () {
    final library = [
      item(1, {1}),
      item(2, {1, 2}),
      item(3, {2}),
      item(4, {3}),
    ];

    final result = entriesInLists(library, {1, 3});
    expect(result.map((value) => value.media.tmdbId), [1, 2, 4]);
  });
}
