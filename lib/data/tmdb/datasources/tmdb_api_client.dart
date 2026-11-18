import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/errors/app_exception.dart';

class TmdbClientOptions {
  const TmdbClientOptions({
    required this.baseUrl,
    this.apiKey,
    this.language = 'it-IT',
    this.timeout = const Duration(seconds: 9),
    this.usesProxy = false,
  });

  final String baseUrl;
  final String? apiKey;
  final String language;
  final Duration timeout;
  final bool usesProxy;

  bool get isDirect => !usesProxy;
}

class TmdbApiClient {
  TmdbApiClient(this.options, {Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: _normalizeBase(options.baseUrl),
                connectTimeout: options.timeout,
                receiveTimeout: options.timeout,
                sendTimeout: options.timeout,
                headers: const {
                  'Accept': 'application/json',
                },
              ),
            );

  final TmdbClientOptions options;
  final Dio _dio;

  String get language => options.language;

  Future<Map<String, dynamic>> searchMovies(
    String query, {
    int page = 1,
  }) {
    return _get(
      'search/movie',
      queryParameters: {
        'query': query,
        'page': page,
        'include_adult': false,
      },
    );
  }

  Future<Map<String, dynamic>> searchTv(
    String query, {
    int page = 1,
  }) {
    return _get(
      'search/tv',
      queryParameters: {
        'query': query,
        'page': page,
        'include_adult': false,
      },
    );
  }

  Future<Map<String, dynamic>> movieDetails(int id) {
    return _get(
      'movie/$id',
      queryParameters: {'append_to_response': 'credits'},
    );
  }

  Future<Map<String, dynamic>> tvDetails(int id) {
    return _get(
      'tv/$id',
      queryParameters: {'append_to_response': 'credits'},
    );
  }

  Future<Map<String, dynamic>> genres(String mediaType) {
    return _get('genre/$mediaType/list');
  }

  Future<Map<String, dynamic>> configuration() => _get('configuration');

  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final params = <String, dynamic>{
      'language': options.language,
      if (options.isDirect && (options.apiKey?.isNotEmpty ?? false))
        'api_key': options.apiKey,
      ...?queryParameters,
    };

    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        final response = await _dio.get<dynamic>(
          path,
          queryParameters: params,
        );
        final data = response.data;
        if (data is Map<String, dynamic>) return data;
        if (data is Map) return Map<String, dynamic>.from(data);
        if (data is String) {
          final decoded = _tryDecode(data);
          if (decoded != null) return decoded;
        }
        throw const InvalidResponseException();
      } on DioException catch (error) {
        final status = error.response?.statusCode;
        if (status == 401 || status == 403) {
          throw ApiConfigurationException(
            message:
                'TMDB ha rifiutato la chiave. Controlla TMDB_API_KEY o il proxy.',
            cause: error,
          );
        }

        final isRetryable = status == 429 ||
            (status != null && status >= 500) ||
            error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout;
        if (isRetryable && attempt < 2) {
          await Future<void>.delayed(_retryDelay(attempt, error));
          continue;
        }
        if (status == 429) {
          throw RateLimitException(cause: error);
        }
        throw NetworkException(cause: error);
      } on InvalidResponseException {
        rethrow;
      } on FormatException catch (error) {
        throw InvalidResponseException(cause: error);
      }
    }
    throw const NetworkException();
  }

  Duration _retryDelay(int attempt, DioException error) {
    if (error.response?.statusCode == 429) {
      final retryAfter = error.response?.headers.value('retry-after');
      final seconds = int.tryParse(retryAfter ?? '');
      if (seconds != null && seconds > 0) {
        return Duration(seconds: seconds.clamp(1, 4));
      }
    }
    return Duration(milliseconds: 350 * (1 << attempt));
  }

  Map<String, dynamic>? _tryDecode(String value) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
      return null;
    } on FormatException {
      return null;
    }
  }

  static String _normalizeBase(String value) {
    return value.endsWith('/') ? value : '$value/';
  }
}
