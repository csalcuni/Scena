import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:scena/app/router.dart';
import 'package:scena/data/local/repositories/drift_library_list_repository.dart';
import 'package:scena/data/local/repositories/drift_library_repository.dart';
import 'package:scena/data/local/repositories/drift_preferences_repository.dart';
import 'package:scena/domain/entities/enums.dart';

import '../support/test_harness.dart';

void main() {
  final toWatch = testMovie(id: 301, title: 'Film da vedere');
  final completed = testMovie(id: 302, title: 'Film già visto');
  final inProgress = testSeries(id: 303, title: 'Serie in corso');

  Future<TestHarness> harnessWithLibrary() {
    return TestHarness.create(
      library: [toWatch, completed, inProgress],
      statuses: {
        completed: LibraryStatus.completed,
        inProgress: LibraryStatus.inProgress,
      },
    );
  }

  Future<void> openLibrary(WidgetTester tester) async {
    await tester.tap(find.text('Libreria'));
    await tester.pumpAndSettle();
  }

  testWidgets('la libreria mostra conteggi e filtra per stato', (tester) async {
    useViewport(tester, const Size(390, 844));
    final harness = await harnessWithLibrary();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await openLibrary(tester);

    expect(find.text('La tua libreria'), findsOneWidget);
    expect(find.text('3 titoli salvati · tutto sul dispositivo'), findsOneWidget);
    expect(find.text('Film da vedere'), findsOneWidget);
    expect(find.text('Film già visto'), findsOneWidget);
    expect(find.text('Serie in corso'), findsOneWidget);

    await tester.tap(find.text('Visti').first);
    await tester.pumpAndSettle();

    expect(find.text('Film già visto'), findsOneWidget);
    expect(find.text('Film da vedere'), findsNothing);
    expect(find.text('Serie in corso'), findsNothing);
  });

  testWidgets('la ricerca nella libreria filtra per tag e nota', (tester) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create(
      library: [toWatch, completed],
      statuses: {completed: LibraryStatus.completed},
    );
    addTearDown(harness.dispose);
    final repository = DriftLibraryRepository(harness.database);
    final all = await repository.getAll();
    final completedItem = all.firstWhere((item) => item.key == completed.key);
    await repository.saveEntry(
      completedItem.entry.copyWith(
        personalNote: 'Per una serata tranquilla',
        tags: const ['comfort', 'breve'],
      ),
    );

    await pumpScena(tester, harness);
    await openLibrary(tester);

    await tester.enterText(
      find.widgetWithText(TextField, 'Filtra per titolo, tag o nota…'),
      'comfort',
    );
    await tester.pumpAndSettle();

    expect(find.text('Film già visto'), findsOneWidget);
    expect(find.text('Film da vedere'), findsNothing);
  });

  testWidgets('il foglio di modifica salva voto, nota e tag', (tester) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create(library: [toWatch]);
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await openLibrary(tester);

    final actions = find.byTooltip('Azioni').first;
    await tester.ensureVisible(actions);
    await tester.tap(actions);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Modifica').last);
    await tester.pumpAndSettle();

    expect(find.text('Voto personale'), findsOneWidget);
    expect(find.text('Nota personale'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Da rivedere con calma');
    await tester.enterText(fields.at(1), 'comfort, classico');
    await tester.pumpAndSettle();

    final save = find.widgetWithText(FilledButton, 'Salva');
    await tester.ensureVisible(save);
    await tester.pumpAndSettle();
    await tester.tap(save);
    await tester.pumpAndSettle();

    final stored = await DriftLibraryRepository(harness.database).getAll();
    expect(stored.single.entry.personalNote, 'Da rivedere con calma');
    expect(stored.single.entry.tags, ['comfort', 'classico']);
  });

  testWidgets('la ricerca TMDB aggiunge un titolo alla libreria', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await tester.tap(find.text('Cerca'));
    await tester.pumpAndSettle();

    expect(find.text('Cerca un titolo'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Dune');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text('Dune - Parte due'), findsOneWidget);
    expect(find.text('1 risultati'), findsOneWidget);

    final add = find.widgetWithText(FilledButton, 'Aggiungi');
    await tester.ensureVisible(add);
    await tester.pumpAndSettle();
    await tester.tap(add);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('«Dune - Parte due» aggiunto'),
      findsOneWidget,
    );

    await tester.tap(find.text('Libreria'));
    await tester.pumpAndSettle();
    expect(find.text('1 titolo salvato · tutto sul dispositivo'), findsOneWidget);
    expect(find.text('Dune - Parte due'), findsOneWidget);
  });

  testWidgets('la libreria filtra per lista personale', (tester) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create(
      library: [toWatch, completed],
      statuses: {completed: LibraryStatus.completed},
    );
    addTearDown(harness.dispose);
    final lists = DriftLibraryListRepository(harness.database);
    final eighties = await lists.create('Anni 80');
    final repository = DriftLibraryRepository(harness.database);
    final entry = (await repository.getAll())
        .firstWhere((item) => item.key == toWatch.key);
    await lists.setEntryLists(entry.entry.id, {eighties.id});

    await pumpScena(tester, harness);
    await openLibrary(tester);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Anni 80'));
    await tester.pumpAndSettle();

    expect(find.text('Film da vedere'), findsOneWidget);
    expect(find.text('Film già visto'), findsNothing);
  });

  testWidgets('la ricerca aggiunge il titolo alla lista scelta', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create();
    addTearDown(harness.dispose);
    final lists = DriftLibraryListRepository(harness.database);
    final eighties = await lists.create('Anni 80');

    await pumpScena(tester, harness);
    await tester.tap(find.text('Cerca'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Dune');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Anni 80').last);
    await tester.pumpAndSettle();

    final add = find.widgetWithText(FilledButton, 'Aggiungi');
    await tester.ensureVisible(add);
    await tester.pumpAndSettle();
    await tester.tap(add);
    await tester.pumpAndSettle();

    final stored = await DriftLibraryRepository(harness.database).getAll();
    expect(stored.single.entry.listIds, {eighties.id});
  });

  testWidgets('le impostazioni cambiano tema e persistono la scelta', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    await tester.tap(find.text('Impostazioni'));
    await tester.pumpAndSettle();

    expect(find.text('Aspetto'), findsOneWidget);
    expect(find.text('I tuoi dati'), findsOneWidget);
    expect(find.text('Esporta JSON'), findsOneWidget);
    expect(find.text('Importa JSON'), findsOneWidget);
    expect(find.text('Cancella tutti i dati'), findsOneWidget);

    final darkChip = find.widgetWithText(ChoiceChip, 'Scuro');
    await tester.ensureVisible(darkChip);
    await tester.pumpAndSettle();
    await tester.tap(darkChip);
    await tester.pumpAndSettle();

    final saved =
        await DriftPreferencesRepository(harness.database).getPreferences();
    expect(saved.themeMode, AppThemeMode.dark);
  });

  testWidgets('il deep link alla ricerca precompila e cerca', (tester) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    harness.container.read(routerProvider).go('/search?q=Dune&type=movie');
    await tester.pumpAndSettle();

    expect(find.text('Cerca un titolo'), findsOneWidget);
    expect(find.text('Dune - Parte due'), findsOneWidget);
  });

  testWidgets('il deep link al dettaglio apre il titolo richiesto', (
    tester,
  ) async {
    useViewport(tester, const Size(390, 844));
    final harness = await TestHarness.create();
    addTearDown(harness.dispose);

    await pumpScena(tester, harness);
    harness.container.read(routerProvider).go('/media/tv/10');
    await tester.pumpAndSettle();

    expect(find.text('The Bear'), findsOneWidget);
    expect(find.text('Aggiungi alla libreria'), findsOneWidget);
  });
}
