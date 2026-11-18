import 'dart:math';

import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/genre_catalog.dart';
import '../../../domain/entities/media_item.dart';
import '../../../domain/repositories/media_repository.dart';

/// Catalogo deterministico per sviluppo offline, test e demo.
class MockMediaRepository implements MediaRepository {
  MockMediaRepository({this.latency = const Duration(milliseconds: 180)});

  final Duration latency;

  static final List<MediaItem> _catalog = [
    _movie(
      id: 693134,
      title: 'Dune - Parte due',
      original: 'Dune: Part Two',
      year: 2024,
      runtime: 166,
      genres: [878, 12],
      vote: 8.2,
      overview:
          'Paul Atreides unisce le forze con i Fremen per vendicare la sua '
          'famiglia e impedire un futuro terribile.',
      poster: '/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    ),
    _movie(
      id: 120467,
      title: 'Grand Budapest Hotel',
      original: 'The Grand Budapest Hotel',
      year: 2014,
      runtime: 99,
      genres: [35, 12, 80],
      vote: 8.0,
      overview:
          'Un leggendario concierge e il suo giovane protetto si trovano al '
          'centro di un furto di un dipinto rinascimentale.',
      poster: '/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg',
    ),
    _movie(
      id: 637,
      title: 'La vita è bella',
      original: 'La vita è bella',
      year: 1997,
      runtime: 116,
      genres: [35, 18],
      vote: 8.5,
      overview:
          'Per proteggere il figlio dagli orrori del campo di concentramento, '
          'un padre trasforma la prigionia in un gioco.',
      poster: '/74hLDKjD5aGYOotO6esUVaeISa2.jpg',
    ),
    _movie(
      id: 545611,
      title: 'Everything Everywhere All at Once',
      original: 'Everything Everywhere All at Once',
      year: 2022,
      runtime: 139,
      genres: [28, 12, 878],
      vote: 7.8,
      overview:
          'Una donna scopre di dover connettersi con versioni alternative di '
          'sé stessa per salvare il multiverso.',
      poster: '/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg',
    ),
    _movie(
      id: 238,
      title: 'Il padrino',
      original: 'The Godfather',
      year: 1972,
      runtime: 175,
      genres: [18, 80],
      vote: 8.7,
      overview:
          'Il patriarca di una dinastia criminale trasmette il potere al '
          'figlio riluttante.',
      poster: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
    ),
    _movie(
      id: 329865,
      title: 'Arrival',
      original: 'Arrival',
      year: 2016,
      runtime: 116,
      genres: [878, 18, 9648],
      vote: 7.6,
      overview:
          'Una linguista tenta di comunicare con misteriosi visitatori '
          'extraterrestri prima che la tensione degeneri.',
      poster: '/x2FJsf1ElAgr63Y3PNPtJrcmpoe.jpg',
    ),
    _movie(
      id: 398818,
      title: 'Chiamami col tuo nome',
      original: 'Call Me by Your Name',
      year: 2017,
      runtime: 132,
      genres: [10749, 18],
      vote: 8.0,
      overview:
          "Un'estate italiana del 1983 diventa lo sfondo di un primo amore "
          'intenso e indimenticabile.',
      poster: '/mZ4gBdfkhP9tvLH1DO4mDI56Feh.jpg',
    ),
    _movie(
      id: 496243,
      title: 'Parasite',
      original: '기생충',
      year: 2019,
      runtime: 132,
      genres: [35, 18, 53],
      vote: 8.5,
      overview:
          'Una famiglia povera si inserisce con astuzia nella vita di una '
          'famiglia benestante, con conseguenze imprevedibili.',
      poster: '/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
    ),
    _movie(
      id: 346698,
      title: 'Barbie',
      original: 'Barbie',
      year: 2023,
      runtime: 114,
      genres: [35, 12, 14],
      vote: 7.0,
      overview:
          'Barbie lascia Barbieland per esplorare il mondo reale e scoprire '
          'chi vuole davvero essere.',
      poster: '/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg',
    ),
    _movie(
      id: 129,
      title: 'La città incantata',
      original: '千と千尋の神隠し',
      year: 2001,
      runtime: 125,
      genres: [16, 10751, 14],
      vote: 8.5,
      overview:
          'Una bambina entra in un mondo di spiriti e deve trovare il coraggio '
          'di salvare i suoi genitori.',
      poster: '/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg',
    ),
    _movie(
      id: 762504,
      title: 'Nope',
      original: 'Nope',
      year: 2022,
      runtime: 130,
      genres: [27, 9648, 878],
      vote: 6.9,
      overview:
          'Due fratelli scoprono una presenza misteriosa nei cieli sopra il '
          'loro ranch e decidono di filmarla.',
    ),
    _tv(
      id: 136315,
      title: 'The Bear',
      original: 'The Bear',
      year: 2022,
      genres: [35, 18],
      vote: 8.3,
      seasons: 3,
      episodes: 28,
      episodeRuntime: 30,
      overview:
          'Un giovane chef torna a Chicago per gestire il ristorante di '
          'famiglia e affronta il caos della cucina.',
      poster: '/sHFlbKS3WLqMnp9t2ghADIJFnuQ.jpg',
    ),
    _tv(
      id: 76331,
      title: 'Succession',
      original: 'Succession',
      year: 2018,
      genres: [18, 35],
      vote: 8.2,
      seasons: 4,
      episodes: 39,
      episodeRuntime: 60,
      overview:
          'La famiglia Roy combatte per il controllo di un impero mediatico '
          'mentre il fondatore valuta la successione.',
      poster: '/7HW47XbkNQ5fiwQFYGWdw9gs144.jpg',
    ),
    _tv(
      id: 66732,
      title: 'Stranger Things',
      original: 'Stranger Things',
      year: 2016,
      genres: [18, 9648, 878, 10765],
      vote: 8.6,
      seasons: 4,
      episodes: 34,
      episodeRuntime: 50,
      overview:
          'Un gruppo di ragazzi affronta forze soprannaturali nella cittadina '
          'di Hawkins negli anni Ottanta.',
      poster: '/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
    ),
    _tv(
      id: 100088,
      title: 'The Last of Us',
      original: 'The Last of Us',
      year: 2023,
      genres: [18, 10759, 10765],
      vote: 8.6,
      seasons: 1,
      episodes: 9,
      episodeRuntime: 55,
      overview:
          'In un mondo devastato da un fungo, Joel accompagna Ellie in un '
          'viaggio pieno di pericoli.',
      poster: '/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg',
    ),
    _tv(
      id: 97546,
      title: 'Ted Lasso',
      original: 'Ted Lasso',
      year: 2020,
      genres: [35, 18],
      vote: 8.1,
      seasons: 3,
      episodes: 34,
      episodeRuntime: 34,
      overview:
          'Un allenatore americano, ottimista e inesperto, arriva in '
          'Inghilterra per guidare una squadra di calcio.',
      poster: '/5fhZdwP1DVJ0FyVH6vrFdHwpXIn.jpg',
    ),
    _tv(
      id: 2316,
      title: 'The Office',
      original: 'The Office',
      year: 2005,
      genres: [35],
      vote: 8.6,
      seasons: 9,
      episodes: 201,
      episodeRuntime: 22,
      overview:
          'La vita quotidiana, surreale e tenera, dei dipendenti di una '
          'azienda di carta a Scranton.',
      poster: '/qWnJzyZhyy74gjpSjIXWmuk0ifX.jpg',
    ),
    _tv(
      id: 67070,
      title: 'Fleabag',
      original: 'Fleabag',
      year: 2016,
      genres: [35, 18],
      vote: 8.7,
      seasons: 2,
      episodes: 12,
      episodeRuntime: 27,
      overview:
          'Una donna brillante e caotica cerca di stare a galla tra lutti, '
          'relazioni e un legame complicato con la famiglia.',
    ),
    _tv(
      id: 87108,
      title: 'Chernobyl',
      original: 'Chernobyl',
      year: 2019,
      genres: [18, 36],
      vote: 8.7,
      seasons: 1,
      episodes: 5,
      episodeRuntime: 65,
      overview:
          'La ricostruzione della catastrofe nucleare del 1986 e delle persone '
          'che tentarono di contenerne le conseguenze.',
      poster: '/hlLXt2tOPT6RRnjiUmoxyG1LTFi.jpg',
    ),
    _tv(
      id: 107113,
      title: 'Only Murders in the Building',
      original: 'Only Murders in the Building',
      year: 2021,
      genres: [35, 9648, 80],
      vote: 8.1,
      seasons: 4,
      episodes: 40,
      episodeRuntime: 32,
      overview:
          'Tre vicini appassionati di true crime indagano su un omicidio nel '
          'loro palazzo e registrano un podcast.',
    ),
  ];

  static const Map<int, List<String>> _castByTmdbId = {
    693134: ['Timothée Chalamet', 'Zendaya', 'Rebecca Ferguson'],
    120467: ['Ralph Fiennes', 'Tony Revolori', 'Saoirse Ronan'],
    637: ['Roberto Benigni', 'Nicoletta Braschi', 'Giorgio Cantarini'],
    545611: ['Michelle Yeoh', 'Ke Huy Quan', 'Stephanie Hsu'],
    238: ['Marlon Brando', 'Al Pacino', 'James Caan'],
    329865: ['Amy Adams', 'Jeremy Renner', 'Forest Whitaker'],
    398818: ['Timothée Chalamet', 'Armie Hammer', 'Michael Stuhlbarg'],
    496243: ['Song Kang-ho', 'Lee Sun-kyun', 'Cho Yeo-jeong'],
    346698: ['Margot Robbie', 'Ryan Gosling', 'America Ferrera'],
    129: ['Rumi Hiiragi', 'Miyu Irino', 'Mari Natsuki'],
    762504: ['Daniel Kaluuya', 'Keke Palmer', 'Steven Yeun'],
    136315: ['Jeremy Allen White', 'Ayo Edebiri', 'Ebon Moss-Bachrach'],
    76331: ['Brian Cox', 'Jeremy Strong', 'Sarah Snook'],
    66732: ['Millie Bobby Brown', 'Finn Wolfhard', 'Winona Ryder'],
    100088: ['Pedro Pascal', 'Bella Ramsey', 'Anna Torv'],
    97546: ['Jason Sudeikis', 'Hannah Waddingham', 'Brett Goldstein'],
    2316: ['Steve Carell', 'Rainn Wilson', 'Jenna Fischer'],
    67070: ['Phoebe Waller-Bridge', 'Sian Clifford', 'Olivia Colman'],
    87108: ['Jared Harris', 'Stellan Skarsgård', 'Emily Watson'],
    107113: ['Steve Martin', 'Martin Short', 'Selena Gomez'],
  };

  static const Map<int, String> _directorByTmdbId = {
    693134: 'Denis Villeneuve',
    120467: 'Wes Anderson',
    637: 'Roberto Benigni',
    545611: 'Daniel Kwan, Daniel Scheinert',
    238: 'Francis Ford Coppola',
    329865: 'Denis Villeneuve',
    398818: 'Luca Guadagnino',
    496243: 'Bong Joon-ho',
    346698: 'Greta Gerwig',
    129: 'Hayao Miyazaki',
    762504: 'Jordan Peele',
    136315: 'Christopher Storer',
    76331: 'Jesse Armstrong',
    66732: 'I fratelli Duffer',
    100088: 'Craig Mazin, Neil Druckmann',
    97546: 'Bill Lawrence',
    2316: 'Greg Daniels',
    67070: 'Phoebe Waller-Bridge',
    87108: 'Craig Mazin',
    107113: 'Steve Martin, John Hoffman',
  };

  @override
  Future<MediaPage> search({
    required String query,
    required MediaType type,
    int page = 1,
  }) async {
    await _wait();
    final normalized = _normalize(query);
    final matches = _catalog
        .where((item) => item.mediaType == type)
        .where(
          (item) =>
              _normalize(item.title).contains(normalized) ||
              _normalize(item.originalTitle ?? '').contains(normalized),
        )
        .toList(growable: false);
    const pageSize = 8;
    final start = (page - 1) * pageSize;
    final items = start >= matches.length
        ? <MediaItem>[]
        : matches.sublist(start, min(start + pageSize, matches.length));
    final totalPages = (matches.length / pageSize).ceil();
    return MediaPage(
      items: items,
      page: page,
      totalPages: totalPages,
      totalResults: matches.length,
    );
  }

  @override
  Future<MediaDetails> getDetails({
    required MediaType type,
    required int tmdbId,
  }) async {
    await _wait();
    final item = _catalog
        .where((value) => value.tmdbId == tmdbId && value.mediaType == type)
        .firstOrNull;
    if (item == null) {
      throw const ValidationException('Titolo demo non trovato.');
    }
    final cast = (_castByTmdbId[tmdbId] ?? const [])
        .map((name) => CastMember(name: name))
        .toList(growable: false);
    final director = _directorByTmdbId[tmdbId];
    return MediaDetails(
      media: item,
      cast: cast,
      directors: director == null ? const [] : [director],
    );
  }

  @override
  Future<List<Genre>> getGenres(MediaType type) async {
    await _wait();
    return type == MediaType.movie ? GenreCatalog.movies : GenreCatalog.tv;
  }

  @override
  Future<ImageConfig> getImageConfig() async {
    await _wait();
    return ImageConfig.fallback;
  }

  Future<void> _wait() async {
    if (latency > Duration.zero) {
      await Future<void>.delayed(latency);
    }
  }

  static MediaItem _movie({
    required int id,
    required String title,
    required String original,
    required int year,
    required int runtime,
    required List<int> genres,
    required double vote,
    required String overview,
    String? poster,
  }) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.movie,
      title: title,
      originalTitle: original,
      overview: overview,
      posterPath: poster,
      releaseDate: DateTime(year),
      runtimeMinutes: runtime,
      genres: GenreCatalog.byIds(genres),
      tmdbVoteAverage: vote,
    );
  }

  static MediaItem _tv({
    required int id,
    required String title,
    required String original,
    required int year,
    required List<int> genres,
    required double vote,
    required int seasons,
    required int episodes,
    required int episodeRuntime,
    required String overview,
    String? poster,
  }) {
    return MediaItem(
      tmdbId: id,
      mediaType: MediaType.tv,
      title: title,
      originalTitle: original,
      overview: overview,
      posterPath: poster,
      releaseDate: DateTime(year),
      genres: GenreCatalog.byIds(genres),
      tmdbVoteAverage: vote,
      numberOfSeasons: seasons,
      numberOfEpisodes: episodes,
      episodeRuntimeMinutes: episodeRuntime,
      tvStatus: 'Ended',
    );
  }

  static String _normalize(String value) {
    const replacements = {
      'à': 'a',
      'á': 'a',
      'è': 'e',
      'é': 'e',
      'ì': 'i',
      'í': 'i',
      'ò': 'o',
      'ó': 'o',
      'ù': 'u',
      'ú': 'u',
      '’': "'",
    };
    var result = value.toLowerCase().trim();
    for (final entry in replacements.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
