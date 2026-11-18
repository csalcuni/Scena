import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/media_item.dart';

class SearchState {
  const SearchState({
    this.query = '',
    this.type = MediaType.movie,
    this.items = const [],
    this.loading = false,
    this.loadingMore = false,
    this.error,
    this.fromCache = false,
    this.page = 0,
    this.totalPages = 0,
    this.totalResults = 0,
  });

  final String query;
  final MediaType type;
  final List<MediaItem> items;
  final bool loading;
  final bool loadingMore;
  final String? error;
  final bool fromCache;
  final int page;
  final int totalPages;
  final int totalResults;

  bool get hasMore => page > 0 && page < totalPages;
  bool get hasSearched => query.trim().isNotEmpty;
  bool get isEmptyResult =>
      hasSearched && !loading && error == null && items.isEmpty;

  SearchState copyWith({
    String? query,
    MediaType? type,
    List<MediaItem>? items,
    bool? loading,
    bool? loadingMore,
    String? error,
    bool clearError = false,
    bool? fromCache,
    int? page,
    int? totalPages,
    int? totalResults,
  }) {
    return SearchState(
      query: query ?? this.query,
      type: type ?? this.type,
      items: items ?? this.items,
      loading: loading ?? this.loading,
      loadingMore: loadingMore ?? this.loadingMore,
      error: clearError ? null : (error ?? this.error),
      fromCache: fromCache ?? this.fromCache,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

class SearchController extends Notifier<SearchState> {
  var _requestId = 0;

  @override
  SearchState build() => const SearchState();

  Future<void> search({
    required String query,
    required MediaType type,
  }) async {
    final normalized = query.trim();
    final requestId = ++_requestId;
    if (normalized.isEmpty) {
      state = SearchState(type: type);
      return;
    }

    state = SearchState(
      query: normalized,
      type: type,
      loading: true,
    );

    try {
      final page = await ref.read(mediaRepositoryProvider).search(
            query: normalized,
            type: type,
          );
      if (requestId != _requestId) return;
      state = state.copyWith(
        items: page.items,
        loading: false,
        clearError: true,
        fromCache: page.isFromCache,
        page: page.page,
        totalPages: page.totalPages,
        totalResults: page.totalResults,
      );
    } on Object catch (error) {
      if (requestId != _requestId) return;
      state = state.copyWith(
        loading: false,
        error: userMessageFor(error),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.loading || state.loadingMore || !state.hasMore) return;
    final requestId = _requestId;
    final nextPage = state.page + 1;
    state = state.copyWith(loadingMore: true, clearError: true);
    try {
      final page = await ref.read(mediaRepositoryProvider).search(
            query: state.query,
            type: state.type,
            page: nextPage,
          );
      if (requestId != _requestId) return;
      state = state.copyWith(
        items: [...state.items, ...page.items],
        loadingMore: false,
        page: page.page,
        totalPages: page.totalPages,
        totalResults: page.totalResults,
        fromCache: page.isFromCache,
      );
    } on Object catch (error) {
      if (requestId != _requestId) return;
      state = state.copyWith(
        loadingMore: false,
        error: userMessageFor(error),
      );
    }
  }

  void clear() {
    _requestId++;
    state = const SearchState();
  }
}

final searchProvider =
    NotifierProvider<SearchController, SearchState>(SearchController.new);
