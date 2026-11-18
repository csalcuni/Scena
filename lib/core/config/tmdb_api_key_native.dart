/// Only compiled into native targets. A secret passed here is still present in
/// the mobile binary; production deployments should prefer the proxy too.
const String compileTimeTmdbApiKey = String.fromEnvironment('TMDB_API_KEY');
