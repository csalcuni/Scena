enum MediaType {
  movie('movie', 'Film'),
  tv('tv', 'Serie');

  const MediaType(this.value, this.label);

  final String value;
  final String label;

  static MediaType fromValue(String value) {
    return MediaType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw ArgumentError('Tipo media non valido: $value'),
    );
  }
}

enum LibraryStatus {
  toWatch('to_watch', 'Da vedere'),
  inProgress('in_progress', 'In corso'),
  paused('paused', 'In pausa'),
  completed('completed', 'Visto'),
  abandoned('abandoned', 'Abbandonato');

  const LibraryStatus(this.value, this.label);

  final String value;
  final String label;

  bool get isStarted => this == inProgress || this == paused;
  bool get isOpen =>
      this == toWatch || this == inProgress || this == paused;
  bool get isFinished => this == completed || this == abandoned;

  static LibraryStatus fromValue(String value) {
    return LibraryStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => throw ArgumentError('Stato non valido: $value'),
    );
  }
}

enum ViewingEventType {
  started('started'),
  episodeWatched('episode_watched'),
  paused('paused'),
  resumed('resumed'),
  completed('completed'),
  abandoned('abandoned');

  const ViewingEventType(this.value);

  final String value;

  static ViewingEventType fromValue(String value) {
    return ViewingEventType.values.firstWhere(
      (event) => event.value == value,
      orElse: () => throw ArgumentError('Evento non valido: $value'),
    );
  }
}

enum Mood {
  light('leggero', 'Leggero'),
  fun('divertente', 'Divertente'),
  romantic('romantico', 'Romantico'),
  emotional('emozionante', 'Emozionante'),
  dramatic('drammatico', 'Drammatico'),
  horror('horror', 'Horror'),
  thriller('thriller', 'Thriller'),
  documentary('documentario', 'Documentario'),
  noThinking('non_voglio_pensare', 'Non voglio pensare');

  const Mood(this.value, this.label);

  final String value;
  final String label;

  static Mood fromValue(String value) {
    return Mood.values.firstWhere(
      (mood) => mood.value == value,
      orElse: () => Mood.light,
    );
  }
}

enum ViewingContext {
  solo('solo', 'Da solo'),
  couple('couple', 'In coppia'),
  family('family', 'Famiglia'),
  friends('friends', 'Amici');

  const ViewingContext(this.value, this.label);

  final String value;
  final String label;

  static ViewingContext fromValue(String value) {
    return ViewingContext.values.firstWhere(
      (context) => context.value == value,
      orElse: () => ViewingContext.solo,
    );
  }
}

enum AppThemeMode {
  system('system', 'Sistema'),
  light('light', 'Chiaro'),
  dark('dark', 'Scuro');

  const AppThemeMode(this.value, this.label);

  final String value;
  final String label;

  static AppThemeMode fromValue(String value) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => AppThemeMode.system,
    );
  }
}

enum SuggestionStatus {
  inLibrary('Nella libreria'),
  alreadyStarted('Già iniziato'),
  newTitle('Nuovo'),
  tooLong('Troppo lungo per stasera'),
  unknownDuration('Durata sconosciuta');

  const SuggestionStatus(this.label);

  final String label;
}
