import 'package:flutter/foundation.dart';

import 'tmdb_api_key_stub.dart'
    if (dart.library.io) 'tmdb_api_key_native.dart' as secrets;

/// Configurazione compilata tramite `--dart-define`.
///
/// Nessun segreto è committato nel repository. Sul web l'API key non viene
/// letta affatto: le richieste devono passare da un proxy che la inietta.
abstract final class AppConfig {
  static const String appName = 'Scena';
  static const String tmdbLanguage = String.fromEnvironment(
    'TMDB_LANGUAGE',
    defaultValue: 'it-IT',
  );
  static const bool useMockTmdb = bool.fromEnvironment('USE_MOCK_TMDB');
  static const String proxyBaseUrl = String.fromEnvironment(
    'TMDB_PROXY_BASE_URL',
  );
  static const String directApiBaseUrl = String.fromEnvironment(
    'TMDB_API_BASE_URL',
    defaultValue: 'https://api.themoviedb.org/3',
  );
  static const int fallbackEpisodeMinutes = int.fromEnvironment(
    'EPISODE_FALLBACK_MINUTES',
    defaultValue: 45,
  );

  static bool get usesProxy => proxyBaseUrl.trim().isNotEmpty;

  /// La chiave diretta è disponibile solo su mobile/desktop.
  static String get _directApiKey =>
      kIsWeb ? '' : secrets.compileTimeTmdbApiKey;

  static String? get mediaApiBaseUrl {
    if (usesProxy) return _withoutTrailingSlash(proxyBaseUrl.trim());
    if (kIsWeb) return null;
    if (_directApiKey.isNotEmpty) {
      return _withoutTrailingSlash(directApiBaseUrl);
    }
    return null;
  }

  static String? get directApiKey => kIsWeb ? null : _directApiKey;

  static bool get canUseTmdb => useMockTmdb || mediaApiBaseUrl != null;

  static String get dataModeLabel {
    if (useMockTmdb) return 'Dati demo offline';
    if (usesProxy) return 'TMDB tramite proxy';
    if (!kIsWeb && _directApiKey.isNotEmpty) return 'TMDB diretto';
    return 'TMDB non configurato';
  }

  static String _withoutTrailingSlash(String value) =>
      value.endsWith('/') ? value.substring(0, value.length - 1) : value;
}
