import 'dart:math';

import '../entities/enums.dart';
import '../entities/evening.dart';
import '../entities/genre_catalog.dart';
import '../entities/library_entry.dart';
import '../entities/media_item.dart';
import '../entities/user_preferences.dart';
import 'recommendation_engine.dart';

/// Estrazione pesata: resta casuale, ma privilegia durata, umore e titoli
/// lasciati indietro. Le esclusioni sono gestite dal chiamante per evitare
/// ripetizioni fino a esaurimento.
class SurprisePicker {
  SurprisePicker({
    Random? random,
    this.fallbackEpisodeMinutes = 45,
  }) : _random = random ?? Random();

  final Random _random;
  final int fallbackEpisodeMinutes;

  SurprisePick pick({
    required List<LibraryEntryWithMedia> library,
    required EveningRequest request,
    required UserPreferences preferences,
    Set<String> excludedKeys = const {},
    DateTime? now,
  }) {
    final effectiveNow = now ?? DateTime.now();
    final eligible = library.where((item) {
      if (item.entry.status == LibraryStatus.completed ||
          item.entry.status == LibraryStatus.abandoned) {
        return false;
      }
      if (excludedKeys.contains(item.key)) return false;
      if (preferences.hardExclusions.blocks(
        title: item.media.title,
        overview: item.media.overview,
        mediaType: item.media.mediaType,
        genres: item.media.genreIds,
        tags: item.entry.tags,
      )) {
        return false;
      }
      return true;
    }).toList(growable: false);

    if (eligible.isEmpty) {
      return const SurprisePick(
        candidate: null,
        reason: 'Nessun titolo disponibile in libreria.',
        exhausted: true,
      );
    }

    final compatible = eligible.where((item) {
      final duration = item.media.estimatedMinutes(fallbackEpisodeMinutes);
      return request.availableMinutes == null ||
          duration == null ||
          duration <= request.availableMinutes!;
    }).toList(growable: false);

    final pool = compatible.isEmpty ? eligible : compatible;
    final ranked = pool.map((item) {
      return (
        item: item,
        score: _score(item, request, preferences, effectiveNow),
      );
    }).toList(growable: false)
      ..sort((a, b) {
        final byScore = b.score.compareTo(a.score);
        if (byScore != 0) return byScore;
        return a.item.media.tmdbId.compareTo(b.item.media.tmdbId);
      });

    final shortlistSize = max(1, (ranked.length * 0.65).ceil());
    final shortlist = ranked.take(shortlistSize).toList(growable: false);
    final minScore =
        shortlist.map((entry) => entry.score).reduce(min).toDouble();
    final weights = shortlist
        .map((entry) => max(1.0, entry.score - minScore + 8))
        .toList(growable: false);
    final total = weights.fold<double>(0, (sum, value) => sum + value);
    var ticket = _random.nextDouble() * total;
    var index = 0;
    for (; index < weights.length - 1; index++) {
      ticket -= weights[index];
      if (ticket <= 0) break;
    }

    final selected = shortlist[index].item;
    final duration = selected.media.estimatedMinutes(fallbackEpisodeMinutes);
    final parts = <String>[];
    if (duration != null && request.availableMinutes != null) {
      parts.add(
        duration <= request.availableMinutes!
            ? '${formatMinutes(duration)} su ${request.availableMinutes} minuti disponibili'
            : '${formatMinutes(duration)}: più lungo del tempo scelto',
      );
    } else if (duration != null) {
      parts.add('circa ${formatMinutes(duration)}');
    } else {
      parts.add('durata non nota');
    }

    final moodMatches = selected.media.genreIds.intersection(
      RecommendationEngine.moodGenres[request.mood] ?? const {},
    );
    if (moodMatches.isNotEmpty) {
      final genre = selected.media.genres.firstWhere(
        (value) => moodMatches.contains(value.id),
        orElse: () => const Genre(id: 0, name: 'affine'),
      );
      parts.add('genere ${genre.name.toLowerCase()}');
    }

    final days = effectiveNow.difference(selected.entry.lastActivityAt).inDays;
    if (selected.entry.status.isStarted) {
      parts.add(days > 0 ? 'fermo da $days giorni' : 'da riprendere');
    } else {
      parts.add('ancora da iniziare');
    }

    return SurprisePick(
      candidate: selected,
      reason: 'Estratto per te: ${parts.join(', ')}.',
      exhausted: false,
    );
  }

  double _score(
    LibraryEntryWithMedia item,
    EveningRequest request,
    UserPreferences preferences,
    DateTime now,
  ) {
    final duration = item.media.estimatedMinutes(fallbackEpisodeMinutes);
    var score = 20.0;
    if (request.availableMinutes != null && duration != null) {
      if (duration <= request.availableMinutes!) {
        score += 32;
      } else {
        score -= 35;
      }
    }
    final moodMatches = item.media.genreIds.intersection(
      RecommendationEngine.moodGenres[request.mood] ?? const {},
    );
    if (moodMatches.isNotEmpty) score += 28;
    final preferred =
        item.media.genreIds.intersection(preferences.preferredGenres.toSet());
    score += min(15, preferred.length * 5.0);
    final avoided =
        item.media.genreIds.intersection(preferences.avoidedGenres.toSet());
    score -= min(25, avoided.length * 15.0);

    switch (item.entry.status) {
      case LibraryStatus.toWatch:
        score += 15;
      case LibraryStatus.inProgress:
        score += 8;
      case LibraryStatus.paused:
        score += 12;
      case LibraryStatus.completed:
      case LibraryStatus.abandoned:
        break;
    }

    final days = max(0, now.difference(item.entry.lastActivityAt).inDays);
    score += min(15, days * 0.5);
    if (item.media.genreIds.contains(GenreCatalog.horrorId) &&
        request.noHorror) {
      return -100;
    }
    return score;
  }
}
