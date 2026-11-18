import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:scena/data/local/repositories/drift_preferences_repository.dart';
import 'package:scena/domain/entities/genre_catalog.dart';

import '../support/test_harness.dart';

void main() {
  testWidgets('completa l’onboarding in tre passaggi e apre la home', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create(writePreferences: false);
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);

    expect(find.text('BENVENUTO IN SCENA'), findsOneWidget);
    expect(find.text('La serata giusta,\nsenza perdere mezz’ora a scegliere.'),
        findsOneWidget);

    await tester.ensureVisible(find.text('Iniziamo'));
    await tester.tap(find.text('Iniziamo'));
    await tester.pumpAndSettle();
    expect(find.text('Che cosa ti va?'), findsOneWidget);

    await tester.tap(find.text('Continua'));
    await tester.pumpAndSettle();
    expect(find.text('La tua serata tipo'), findsOneWidget);

    await tester.tap(find.text('Inizia'));
    await tester.pumpAndSettle();

    expect(find.text('Cosa guardiamo stasera?'), findsOneWidget);
    expect(find.text('La tua libreria è vuota'), findsOneWidget);

    final saved =
        await DriftPreferencesRepository(harness.database).getPreferences();
    expect(saved.onboardingCompleted, isTrue);
  });

  testWidgets('Salta conclude subito l’onboarding', (tester) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create(writePreferences: false);
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await tester.tap(find.text('Salta'));
    await tester.pumpAndSettle();

    expect(find.text('Cosa guardiamo stasera?'), findsOneWidget);
    final saved =
        await DriftPreferencesRepository(harness.database).getPreferences();
    expect(saved.onboardingCompleted, isTrue);
  });

  testWidgets('le preferenze scelte durante l’onboarding vengono salvate', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create(writePreferences: false);
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await tester.ensureVisible(find.text('Iniziamo'));
    await tester.tap(find.text('Iniziamo'));
    await tester.pumpAndSettle();

    final commedia = find.text('Commedia').first;
    await tester.ensureVisible(commedia);
    await tester.tap(commedia);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continua'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Inizia'));
    await tester.pumpAndSettle();

    final saved =
        await DriftPreferencesRepository(harness.database).getPreferences();
    expect(saved.onboardingCompleted, isTrue);
    expect(saved.preferredGenres, contains(GenreCatalog.comedyId));
  });
}
