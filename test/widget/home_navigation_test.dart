import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:scena/domain/entities/enums.dart';
import 'package:scena/features/home/suggestion_card.dart';

import '../support/test_harness.dart';

void main() {
  final films = [
    testMovie(id: 101, title: 'Commedia leggera', runtime: 92),
    testMovie(id: 102, title: 'Dramma breve', runtime: 88),
    testMovie(id: 103, title: 'Avventura serale', runtime: 110),
  ];
  final series = testSeries(id: 201, title: 'Serie da riprendere');

  Future<TestHarness> harnessWithLibrary() {
    return TestHarness.create(
      library: [...films, series],
      statuses: {series: LibraryStatus.inProgress},
    );
  }

  testWidgets('la home mostra al massimo tre proposte e la sezione Riprendi', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);

    expect(find.text('Cosa guardiamo stasera?'), findsOneWidget);
    expect(find.text('Le proposte per stasera'), findsOneWidget);
    expect(find.byType(SuggestionCard), findsNWidgets(3));
    expect(find.text('Riprendi'), findsOneWidget);
    expect(find.text('Serie da riprendere'), findsWidgets);
    expect(find.text('SERATA DI STASERA'), findsOneWidget);
  });

  testWidgets('il chip del tempo aggiorna il riepilogo della serata', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    expect(
      find.text('Hai 2h, umore leggero, da solo.'),
      findsOneWidget,
    );

    await tester.tap(find.text('45 min'));
    await tester.pumpAndSettle();

    expect(find.text('Hai 45 min, umore leggero, da solo.'), findsOneWidget);
  });

  testWidgets('Sorprendimi apre una proposta e porta al dettaglio', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await tester.tap(find.text('Sorprendimi'));
    await tester.pumpAndSettle();

    expect(find.text('Estratto per te'), findsOneWidget);
    await tester.tap(find.text('Apri').last);
    await tester.pumpAndSettle();

    expect(find.text('Aggiungi alla libreria'), findsNothing);
    expect(find.text('Non è ancora nella tua libreria'), findsNothing);
    expect(find.text('Modifica'), findsWidgets);
  });

  testWidgets('scartare una proposta la rimuove e mostra Ripristina', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    expect(find.byType(SuggestionCard), findsNWidgets(3));

    final dismiss = find.byTooltip('Scarta questa proposta').first;
    await tester.ensureVisible(dismiss);
    await tester.pumpAndSettle();
    await tester.tap(dismiss);
    await tester.pumpAndSettle();

    expect(find.text('Ripristina'), findsOneWidget);
    expect(find.byType(SuggestionCard), findsNWidgets(3));
  });

  testWidgets('la shell compatta usa la bottom navigation per tutte le aree', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);

    await tester.tap(find.text('Libreria'));
    await tester.pumpAndSettle();
    expect(find.text('La tua libreria'), findsOneWidget);

    await tester.tap(find.text('Cerca'));
    await tester.pumpAndSettle();
    expect(find.text('Cerca un titolo'), findsOneWidget);

    await tester.tap(find.text('Impostazioni'));
    await tester.pumpAndSettle();
    expect(find.text('Aspetto'), findsOneWidget);

    await tester.tap(find.text('Stasera'));
    await tester.pumpAndSettle();
    expect(find.text('Cosa guardiamo stasera?'), findsOneWidget);
  });

  testWidgets('la shell espansa usa la navigation rail', (tester) async {
    useViewport(tester, const Size(1280, 900));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('Ctrl / ⌘ + K per cercare'), findsOneWidget);

    await tester.tap(find.text('Libreria'));
    await tester.pumpAndSettle();
    expect(find.text('La tua libreria'), findsOneWidget);
  });
}
