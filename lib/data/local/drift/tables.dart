import 'package:drift/drift.dart';

@DataClassName('MediaItemRow')
class MediaItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tmdbId => integer()();
  TextColumn get mediaType => text()();
  TextColumn get title => text()();
  TextColumn get originalTitle => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get overview => text().withDefault(const Constant(''))();
  TextColumn get releaseDate => text().nullable()();
  IntColumn get runtimeMinutes => integer().nullable()();
  TextColumn get genresJson => text().withDefault(const Constant('[]'))();
  RealColumn get tmdbVoteAverage => real().withDefault(const Constant(0))();
  IntColumn get numberOfSeasons => integer().nullable()();
  IntColumn get numberOfEpisodes => integer().nullable()();
  IntColumn get episodeRuntimeMinutes => integer().nullable()();
  TextColumn get tvStatus => text().nullable()();
  BoolColumn get isAdult => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {tmdbId, mediaType},
      ];
}

@DataClassName('LibraryEntryRow')
class LibraryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mediaItemId =>
      integer().references(MediaItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => text()();
  IntColumn get personalRating => integer().nullable()();
  TextColumn get personalNote => text().nullable()();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();
  IntColumn get currentSeason => integer().nullable()();
  IntColumn get currentEpisode => integer().nullable()();
  DateTimeColumn get lastActivityAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {mediaItemId},
      ];
}

@DataClassName('LibraryListRow')
class LibraryLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {name},
      ];
}

@DataClassName('LibraryListEntryRow')
class LibraryListEntries extends Table {
  IntColumn get listId =>
      integer().references(LibraryLists, #id, onDelete: KeyAction.cascade)();
  IntColumn get libraryEntryId =>
      integer().references(LibraryEntries, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {listId, libraryEntryId};
}

@DataClassName('ViewingEventRow')
class ViewingEvents extends Table {  IntColumn get id => integer().autoIncrement()();
  IntColumn get libraryEntryId => integer().references(
        LibraryEntries,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get eventType => text()();
  IntColumn get season => integer().nullable()();
  IntColumn get episode => integer().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get note => text().nullable()();
}

@DataClassName('UserPreferenceRow')
class UserPreferencesTable extends Table {
  @override
  String get tableName => 'user_preferences';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get streamingServicesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get preferredGenresJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get avoidedGenresJson =>
      text().withDefault(const Constant('[]'))();
  IntColumn get preferredRuntimeMinutes =>
      integer().withDefault(const Constant(120))();
  TextColumn get hardExclusionsJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
}

@DataClassName('DismissedSuggestionRow')
class DismissedSuggestions extends Table {  IntColumn get id => integer().autoIncrement()();
  IntColumn get tmdbId => integer()();
  TextColumn get mediaType => text()();
  TextColumn get reason => text()();
  DateTimeColumn get dismissedAt => dateTime()();
}

@DataClassName('CachedEntryRow')
class CachedEntries extends Table {
  TextColumn get cacheKey => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}
