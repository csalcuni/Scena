/// Errori applicativi con un messaggio già pronto per l'interfaccia.
sealed class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

final class ApiConfigurationException extends AppException {
  const ApiConfigurationException({
    String message =
        'TMDB non è configurato. Sul web avvia il proxy e passa la sua URL '
        'con --dart-define=TMDB_PROXY_BASE_URL.',
    super.cause,
  }) : super(message);
}

final class NetworkException extends AppException {
  const NetworkException({
    String message =
        'Non riusciamo a raggiungere TMDB. Controlla la connessione e riprova.',
    super.cause,
  }) : super(message);
}

final class RateLimitException extends AppException {
  const RateLimitException({
    String message = 'Troppe richieste a TMDB. Riprova tra qualche istante.',
    super.cause,
  }) : super(message);
}

final class InvalidResponseException extends AppException {
  const InvalidResponseException({
    String message = 'TMDB ha restituito dati non validi.',
    super.cause,
  }) : super(message);
}

final class OfflineCacheMissException extends AppException {
  const OfflineCacheMissException({
    String message =
        'Sei offline e questa ricerca non è ancora nella cache locale.',
    super.cause,
  }) : super(message);
}

final class StorageException extends AppException {
  const StorageException({
    String message = 'Non è stato possibile salvare i dati sul dispositivo.',
    super.cause,
  }) : super(message);
}

final class ValidationException extends AppException {
  const ValidationException(super.message);
}

String userMessageFor(Object error) {
  if (error is AppException) return error.message;
  return 'Si è verificato un errore imprevisto. Riprova.';
}
