import 'media_item.dart';

/// Catalogo di fallback per onboarding e impostazioni, indipendente dalla rete.
/// I nomi seguono la localizzazione italiana di TMDB.
abstract final class GenreCatalog {
  static const List<Genre> movies = [
    Genre(id: 28, name: 'Azione'),
    Genre(id: 12, name: 'Avventura'),
    Genre(id: 16, name: 'Animazione'),
    Genre(id: 35, name: 'Commedia'),
    Genre(id: 80, name: 'Crime'),
    Genre(id: 99, name: 'Documentario'),
    Genre(id: 18, name: 'Dramma'),
    Genre(id: 10751, name: 'Famiglia'),
    Genre(id: 14, name: 'Fantasy'),
    Genre(id: 36, name: 'Storico'),
    Genre(id: 27, name: 'Horror'),
    Genre(id: 10402, name: 'Musica'),
    Genre(id: 9648, name: 'Mistero'),
    Genre(id: 10749, name: 'Romance'),
    Genre(id: 878, name: 'Fantascienza'),
    Genre(id: 53, name: 'Thriller'),
    Genre(id: 10752, name: 'Guerra'),
    Genre(id: 37, name: 'Western'),
  ];

  static const List<Genre> tv = [
    Genre(id: 10759, name: 'Azione e avventura'),
    Genre(id: 16, name: 'Animazione'),
    Genre(id: 35, name: 'Commedia'),
    Genre(id: 80, name: 'Crime'),
    Genre(id: 99, name: 'Documentario'),
    Genre(id: 18, name: 'Dramma'),
    Genre(id: 10751, name: 'Famiglia'),
    Genre(id: 10762, name: 'Kids'),
    Genre(id: 9648, name: 'Mistero'),
    Genre(id: 10765, name: 'Sci-Fi e Fantasy'),
    Genre(id: 10768, name: 'Guerra e politica'),
    Genre(id: 37, name: 'Western'),
  ];

  static final List<Genre> all = _unique([
    ...movies,
    ...tv,
  ]);

  static const int horrorId = 27;
  static const int romanceId = 10749;
  static const int thrillerId = 53;
  static const int crimeId = 80;
  static const int warId = 10752;
  static const int familyId = 10751;
  static const int animationId = 16;
  static const int comedyId = 35;
  static const int dramaId = 18;
  static const int documentaryId = 99;
  static const int actionId = 28;
  static const int adventureId = 12;
  static const int scienceFictionId = 878;
  static const int mysteryId = 9648;
  static const int historyId = 36;
  static const int musicId = 10402;
  static const int fantasyId = 14;
  static const int kidsId = 10762;

  /// Generi non adatti a un filtro famiglia conservativo. TMDB non espone
  /// certificazioni nella ricerca: l'app non promette una classificazione
  /// ufficiale, ma esclude le categorie più rischiose.
  static const Set<int> familySensitiveGenreIds = {
    horrorId,
    thrillerId,
    crimeId,
    warId,
    10768,
  };

  static String nameFor(int id) {
    return all
        .firstWhere(
          (genre) => genre.id == id,
          orElse: () => Genre(id: id, name: 'Genere $id'),
        )
        .name;
  }

  static List<Genre> byIds(Iterable<int> ids) {
    return ids
        .map(
          (id) => all.firstWhere(
            (genre) => genre.id == id,
            orElse: () => Genre(id: id, name: 'Genere $id'),
          ),
        )
        .toList(growable: false);
  }

  static List<Genre> _unique(List<Genre> source) {
    final seen = <int>{};
    final result = <Genre>[];
    for (final genre in source) {
      if (seen.add(genre.id)) result.add(genre);
    }
    return List.unmodifiable(result);
  }
}
