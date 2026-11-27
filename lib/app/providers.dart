import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../data/local/drift/app_database.dart';
import '../data/local/repositories/drift_backup_repository.dart';
import '../data/local/repositories/drift_cache_store.dart';
import '../data/local/repositories/drift_library_list_repository.dart';
import '../data/local/repositories/drift_library_repository.dart';
import '../data/local/repositories/drift_preferences_repository.dart';
import '../data/tmdb/datasources/tmdb_api_client.dart';
import '../data/tmdb/repositories/mock_media_repository.dart';
import '../data/tmdb/repositories/tmdb_media_repository.dart';
import '../domain/entities/dismissed_suggestion.dart';
import '../domain/entities/enums.dart';
import '../domain/entities/evening.dart';
import '../domain/entities/library_entry.dart';
import '../domain/entities/library_list.dart';
import '../domain/entities/media_item.dart';
import '../domain/entities/user_preferences.dart';
import '../domain/repositories/backup_repository.dart';
import '../domain/repositories/library_repository.dart';
import '../domain/repositories/library_list_repository.dart';
import '../domain/repositories/media_repository.dart';
import '../domain/repositories/preferences_repository.dart';
import '../domain/usecases/library_scope.dart';
import '../domain/usecases/library_usecases.dart';
import '../domain/usecases/recommendation_engine.dart';
import '../domain/usecases/surprise_picker.dart';

/// Radice del grafo degli oggetti. Nei test viene sostituita con un database
/// in memoria tramite `overrideWithValue`.
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  return DriftLibraryRepository(ref.watch(databaseProvider));
});

final libraryListRepositoryProvider = Provider<LibraryListRepository>((ref) {
  return DriftLibraryListRepository(ref.watch(databaseProvider));
});

final libraryListsProvider = StreamProvider<List<LibraryList>>((ref) async* {
  final repository = ref.watch(libraryListRepositoryProvider);
  await repository.ensureDefault();
  yield* repository.watchAll();
});

final viewingEventRepositoryProvider = Provider<ViewingEventRepository>((ref) {
  return DriftViewingEventRepository(ref.watch(databaseProvider));
});

final dismissedSuggestionsRepositoryProvider =
    Provider<DismissedSuggestionRepository>((ref) {
  return DriftDismissedSuggestionRepository(ref.watch(databaseProvider));
});

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return DriftPreferencesRepository(ref.watch(databaseProvider));
});

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return DriftBackupRepository(ref.watch(databaseProvider));
});

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  if (AppConfig.useMockTmdb) {
    return MockMediaRepository();
  }
  final baseUrl = AppConfig.mediaApiBaseUrl;
  if (baseUrl == null) {
    return const UnconfiguredMediaRepository();
  }
  return TmdbMediaRepository(
    client: TmdbApiClient(
      TmdbClientOptions(
        baseUrl: baseUrl,
        apiKey: AppConfig.directApiKey,
        language: AppConfig.tmdbLanguage,
        usesProxy: AppConfig.usesProxy,
      ),
    ),
    cache: DriftCacheStore(ref.watch(databaseProvider)),
  );
});

final imageConfigProvider = FutureProvider<ImageConfig>((ref) {
  return ref.watch(mediaRepositoryProvider).getImageConfig();
});

final addToLibraryProvider = Provider<AddToLibrary>((ref) {
  return AddToLibrary(
    ref.watch(libraryRepositoryProvider),
    ref.watch(viewingEventRepositoryProvider),
  );
});

final changeLibraryStatusProvider = Provider<ChangeLibraryStatus>((ref) {
  return ChangeLibraryStatus(
    ref.watch(libraryRepositoryProvider),
    ref.watch(viewingEventRepositoryProvider),
  );
});

final updateLibraryEntryProvider = Provider<UpdateLibraryEntry>((ref) {
  return UpdateLibraryEntry(ref.watch(libraryRepositoryProvider));
});

final markEpisodeWatchedProvider = Provider<MarkEpisodeWatched>((ref) {
  return MarkEpisodeWatched(
    ref.watch(libraryRepositoryProvider),
    ref.watch(viewingEventRepositoryProvider),
  );
});

final markWatchedProvider = Provider<MarkWatched>((ref) {
  return MarkWatched(
    ref.watch(libraryRepositoryProvider),
    ref.watch(viewingEventRepositoryProvider),
  );
});

final recommendationEngineProvider = Provider<RecommendationEngine>((ref) {
  return RecommendationEngine(
    fallbackEpisodeMinutes: AppConfig.fallbackEpisodeMinutes,
  );
});

final surprisePickerProvider = Provider<SurprisePicker>((ref) {
  return SurprisePicker(
    fallbackEpisodeMinutes: AppConfig.fallbackEpisodeMinutes,
  );
});

class PreferencesController extends AsyncNotifier<UserPreferences> {
  @override
  Future<UserPreferences> build() {
    return ref.watch(preferencesRepositoryProvider).getPreferences();
  }

  Future<void> save(UserPreferences preferences) async {
    final previous = state;
    state = AsyncData(preferences);
    try {
      await ref
          .read(preferencesRepositoryProvider)
          .savePreferences(preferences);
    } on Object catch (error, stackTrace) {
      state = previous;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> updatePreferences(
    UserPreferences Function(UserPreferences current) transform,
  ) {
    final current = state.value;
    if (current == null) {
      return Future<void>.error(
        StateError('Le preferenze non sono ancora caricate.'),
      );
    }
    return save(transform(current));
  }
}

final preferencesProvider =
    AsyncNotifierProvider<PreferencesController, UserPreferences>(
  PreferencesController.new,
);

final libraryProvider = StreamProvider<List<LibraryEntryWithMedia>>((ref) {
  return ref.watch(libraryRepositoryProvider).watchAll();
});

final resumeEntriesProvider = Provider<List<LibraryEntryWithMedia>>((ref) {
  final library = ref.watch(libraryProvider).value ?? const [];
  final entries = library
      .where((item) => item.entry.status.isStarted)
      .toList(growable: false)
    ..sort((a, b) => b.entry.lastActivityAt.compareTo(a.entry.lastActivityAt));
  return entries;
});

final libraryCountsProvider = Provider<Map<LibraryStatus, int>>((ref) {
  final counts = {for (final status in LibraryStatus.values) status: 0};
  for (final item in ref.watch(libraryProvider).value ?? const []) {
    counts.update(item.entry.status, (value) => value + 1);
  }
  return counts;
});

class DismissedSuggestionsController
    extends AsyncNotifier<List<DismissedSuggestion>> {
  @override
  Future<List<DismissedSuggestion>> build() {
    return ref.watch(dismissedSuggestionsRepositoryProvider).getAll();
  }

  Future<void> dismiss(Suggestion suggestion) async {
    final dismissed = DismissedSuggestion(
      tmdbId: suggestion.media.tmdbId,
      mediaType: suggestion.media.mediaType,
      reason: suggestion.reason,
      dismissedAt: DateTime.now(),
    );
    await ref
        .read(dismissedSuggestionsRepositoryProvider)
        .dismiss(dismissed);
    state = AsyncData([...state.value ?? const [], dismissed]);
  }

  Future<void> clear() async {
    await ref.read(dismissedSuggestionsRepositoryProvider).clear();
    state = const AsyncData([]);
  }
}

final dismissedSuggestionsProvider = AsyncNotifierProvider<
    DismissedSuggestionsController, List<DismissedSuggestion>>(
  DismissedSuggestionsController.new,
);

class EveningRequestController extends Notifier<EveningRequest> {
  @override
  EveningRequest build() {
    final preferred = ref
        .read(preferencesProvider)
        .value
        ?.preferredRuntimeMinutes;
    return EveningRequest(availableMinutes: preferred ?? 120);
  }

  void setRequest(EveningRequest request) => state = request;

  void removeList(int listId) {
    if (!state.listIds.contains(listId)) return;
    state = state.copyWith(listIds: {...state.listIds}..remove(listId));
  }

  void reset() {
    final preferred = ref
        .read(preferencesProvider)
        .value
        ?.preferredRuntimeMinutes;
    state = EveningRequest(availableMinutes: preferred ?? 120);
  }
}

final eveningRequestProvider =
    NotifierProvider<EveningRequestController, EveningRequest>(
  EveningRequestController.new,
);

final recommendationProvider = Provider<RecommendationResult>((ref) {
  final request = ref.watch(eveningRequestProvider);
  final library = ref.watch(libraryProvider).value ?? const [];
  final scoped = entriesInLists(library, request.listIds);

  if (library.isNotEmpty && scoped.isEmpty) {
    return const RecommendationResult(
      suggestions: [],
      relaxationNote:
          'Nessun titolo appartiene alle liste scelte. Seleziona altre liste '
          'o riporta la serata su tutte le liste.',
    );
  }

  return ref.watch(recommendationEngineProvider).recommend(
        request: request,
        library: scoped,
        preferences: ref.watch(preferencesProvider).value ??
            const UserPreferences(),
        dismissals:
            ref.watch(dismissedSuggestionsProvider).value ?? const [],
      );
});

class SurpriseState {
  const SurpriseState({this.pick, this.excludedKeys = const {}});

  final SurprisePick? pick;
  final Set<String> excludedKeys;

  SurpriseState copyWith({
    SurprisePick? pick,
    Set<String>? excludedKeys,
  }) {
    return SurpriseState(
      pick: pick ?? this.pick,
      excludedKeys: excludedKeys ?? this.excludedKeys,
    );
  }
}

class SurpriseController extends Notifier<SurpriseState> {
  @override
  SurpriseState build() => const SurpriseState();

  SurprisePick pickAgain() {
    final library = ref.read(libraryProvider).value ?? const [];
    final preferences =
        ref.read(preferencesProvider).value ?? const UserPreferences();
    final request = ref.read(eveningRequestProvider);
    final picker = ref.read(surprisePickerProvider);
    final scoped = entriesInLists(library, request.listIds);

    if (library.isNotEmpty && scoped.isEmpty) {
      return const SurprisePick(
        candidate: null,
        reason:
            'Nessun titolo appartiene alle liste scelte per la serata.',
        exhausted: true,
      );
    }

    var excluded = state.excludedKeys;
    var pick = picker.pick(
      library: scoped,
      request: request,
      preferences: preferences,
      excludedKeys: excluded,
    );

    // Se le esclusioni hanno consumato tutte le alternative ricomincio il
    // giro, così "Sorprendimi" non resta bloccato per sempre.
    if (pick.exhausted && excluded.isNotEmpty) {
      excluded = const {};
      pick = picker.pick(
        library: scoped,
        request: request,
        preferences: preferences,
      );
    }

    state = SurpriseState(
      pick: pick,
      excludedKeys: pick.hasPick
          ? {...excluded, pick.candidate!.key}
          : excluded,
    );
    return pick;
  }

  void clear() => state = const SurpriseState();
}

final surpriseProvider = NotifierProvider<SurpriseController, SurpriseState>(
  SurpriseController.new,
);

class MediaLookup {
  const MediaLookup({required this.type, required this.tmdbId});

  final MediaType type;
  final int tmdbId;

  @override
  bool operator ==(Object other) =>
      other is MediaLookup && other.type == type && other.tmdbId == tmdbId;

  @override
  int get hashCode => Object.hash(type, tmdbId);
}

final mediaDetailsProvider =
    FutureProvider.family<MediaDetails, MediaLookup>((ref, lookup) {
  return ref.watch(mediaRepositoryProvider).getDetails(
        type: lookup.type,
        tmdbId: lookup.tmdbId,
      );
});
