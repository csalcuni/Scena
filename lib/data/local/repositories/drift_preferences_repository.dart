import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/entities/user_preferences.dart';
import '../../../domain/repositories/preferences_repository.dart';
import '../drift/app_database.dart';

class DriftPreferencesRepository implements PreferencesRepository {
  const DriftPreferencesRepository(this._database);

  final AppDatabase _database;

  @override
  Future<UserPreferences> getPreferences() async {
    final row = await _database
        .select(_database.userPreferencesTable)
        .getSingleOrNull();
    if (row == null) {
      final defaults = _defaults;
      await savePreferences(defaults);
      return defaults;
    }
    return _map(row);
  }

  @override
  Future<void> savePreferences(UserPreferences preferences) async {
    await _database.into(_database.userPreferencesTable).insertOnConflictUpdate(
          UserPreferencesTableCompanion.insert(
            id: const Value(1),
            streamingServicesJson: Value(
              jsonEncode(preferences.streamingServices),
            ),
            preferredGenresJson: Value(jsonEncode(preferences.preferredGenres)),
            avoidedGenresJson: Value(jsonEncode(preferences.avoidedGenres)),
            preferredRuntimeMinutes: Value(
              preferences.preferredRuntimeMinutes,
            ),
            hardExclusionsJson: Value(
              jsonEncode(preferences.hardExclusions.toJson()),
            ),
            themeMode: Value(preferences.themeMode.value),
            onboardingCompleted: Value(preferences.onboardingCompleted),
          ),
        );
  }

  UserPreferences _map(UserPreferenceRow row) {
    final hardExclusions = _decodeHardExclusions(row.hardExclusionsJson);
    return UserPreferences(
      streamingServices: UserPreferences.decodeStringList(
        row.streamingServicesJson,
      ),
      preferredGenres: UserPreferences.decodeIntList(row.preferredGenresJson),
      avoidedGenres: UserPreferences.decodeIntList(row.avoidedGenresJson),
      preferredRuntimeMinutes: row.preferredRuntimeMinutes,
      hardExclusions: hardExclusions,
      themeMode: AppThemeMode.fromValue(row.themeMode),
      onboardingCompleted: row.onboardingCompleted,
    );
  }

  HardExclusions _decodeHardExclusions(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return HardExclusions.fromJson(decoded);
      }
    } on FormatException {
      return const HardExclusions();
    }
    return const HardExclusions();
  }

  UserPreferences get _defaults => const UserPreferences();
}
