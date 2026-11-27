import '../entities/dismissed_suggestion.dart';
import '../entities/enums.dart';
import '../entities/library_entry.dart';
import '../entities/media_item.dart';
import '../entities/viewing_event.dart';

abstract interface class LibraryRepository {
  Stream<List<LibraryEntryWithMedia>> watchAll();

  Future<List<LibraryEntryWithMedia>> getAll();

  Future<LibraryEntryWithMedia?> findById(int id);

  Future<LibraryEntryWithMedia?> findByMedia({
    required MediaType type,
    required int tmdbId,
  });

  /// Inserisce o aggiorna i metadati del media e la voce di libreria.
  /// Se la voce esiste già, restituisce quella esistente senza duplicarla.
  /// [listIds] vuoto assegna la lista predefinita.
  Future<LibraryEntryWithMedia> addMedia({
    required MediaItem media,
    required LibraryStatus status,
    int? currentSeason,
    int? currentEpisode,
    Set<int> listIds = const {},
  });

  Future<LibraryEntry> saveEntry(LibraryEntry entry);

  Future<void> deleteEntry(int id);
}

abstract interface class ViewingEventRepository {
  Future<void> add(ViewingEvent event);

  Future<List<ViewingEvent>> forEntry(int libraryEntryId);

  Stream<List<ViewingEvent>> watchForEntry(int libraryEntryId);
}

abstract interface class DismissedSuggestionRepository {
  Future<List<DismissedSuggestion>> getAll();

  Future<void> dismiss(DismissedSuggestion suggestion);

  Future<void> clear();
}
