import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scena/data/local/drift/app_database.dart';
import 'package:scena/data/local/repositories/drift_library_repository.dart';
import 'package:scena/data/local/repositories/drift_preferences_repository.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/domain/entities/genre_catalog.dart';
import 'package:scena/domain/entities/media_item.dart';
import 'package:scena/domain/entities/user_preferences.dart';

void main() {
  late Directory directory;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('scena_persistence_');
  });

  tearDown(() async {
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  });

  test('i dati restano disponibili dopo la riapertura del database', () async {
    final file = File('${directory.path}/scena.sqlite');

    var database = AppDatabase.forTesting(NativeDatabase(file));
    await DriftPreferencesRepository(database).savePreferences(
      const UserPreferences(
        preferredGenres: [35, 18],
        preferredRuntimeMinutes: 90,
        themeMode: AppThemeMode.dark,
        onboardingCompleted: true,
      ),
    );
    final library = DriftLibraryRepository(database);
    final item = await library.addMedia(
      media: MediaItem(
        tmdbId: 424242,
        mediaType: MediaType.movie,
        title: 'Film persistente',
        runtimeMinutes: 95,
        genres: GenreCatalog.byIds(const [GenreCatalog.comedyId]),
      ),
      status: LibraryStatus.toWatch,
    );
    await library.saveEntry(
      item.entry.copyWith(
        status: LibraryStatus.completed,
        personalRating: 9,
        personalNote: 'Sopravvive al riavvio',
        tags: const ['persistenza'],
      ),
    );
    await database.close();

    database = AppDatabase.forTesting(NativeDatabase(file));
    final prefs = await DriftPreferencesRepository(database).getPreferences();
    final entries = await DriftLibraryRepository(database).getAll();

    expect(prefs.onboardingCompleted, isTrue);
    expect(prefs.preferredGenres, [35, 18]);
    expect(prefs.preferredRuntimeMinutes, 90);
    expect(prefs.themeMode, AppThemeMode.dark);

    expect(entries, hasLength(1));
    expect(entries.single.media.title, 'Film persistente');
    expect(entries.single.entry.status, LibraryStatus.completed);
    expect(entries.single.entry.personalRating, 9);
    expect(entries.single.entry.personalNote, 'Sopravvive al riavvio');
    expect(entries.single.entry.tags, ['persistenza']);

    await database.close();
  });
}
