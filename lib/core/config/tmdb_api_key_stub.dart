/// Fallback used on platforms without `dart:io` (including the web).
///
/// The TMDB key must never be embedded in a web build. Web requests always go
/// through the local/production proxy instead.
const String compileTimeTmdbApiKey = '';
