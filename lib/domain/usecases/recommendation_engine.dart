import 'dart:math' as math;

import '../entities/dismissed_suggestion.dart';
import '../entities/enums.dart';
import '../entities/evening.dart';
import '../entities/genre_catalog.dart';
import '../entities/library_entry.dart';
import '../entities/media_item.dart';
import '../entities/user_preferences.dart';

/// Motore deterministico e puro.
///
/// Non conosce Flutter, HTTP o Drift. A parità di input restituisce sempre lo
/// stesso ordine. La casualità è confinata in [SurprisePicker].
class RecommendationEngine {
  const RecommendationEngine({this.fallbackEpisodeMinutes = 45});

  final int fallbackEpisodeMinutes;

  static const Map<Mood, Set<int>> moodGenres = {
    Mood.light: {
      GenreCatalog.comedyId,
      GenreCatalog.familyId,
      GenreCatalog.animationId,
      GenreCatalog.adventureId,
      GenreCatalog.fantasyId,
    },
    Mood.fun: {
      GenreCatalog.comedyId,
      GenreCatalog.actionId,
      GenreCatalog.adventureId,
      GenreCatalog.familyId,
      10759,
    },
    Mood.romantic: {
      GenreCatalog.romanceId,
      GenreCatalog.comedyId,
      GenreCatalog.dramaId,
    },
    Mood.emotional: {
      GenreCatalog.dramaId,
      GenreCatalog.animationId,
      GenreCatalog.musicId,
      GenreCatalog.romanceId,
    },
    Mood.dramatic: {
      GenreCatalog.dramaId,
      GenreCatalog.historyId,
      GenreCatalog.crimeId,
    },
    Mood.horror: {
      GenreCatalog.horrorId,
      GenreCatalog.mysteryId,
      GenreCatalog.thrillerId,
    },
    Mood.thriller: {
      GenreCatalog.thrillerId,
      GenreCatalog.mysteryId,
      GenreCatalog.crimeId,
      GenreCatalog.horrorId,
    },
    Mood.documentary: {
      GenreCatalog.documentaryId,
      GenreCatalog.historyId,
    },
    Mood.noThinking: {
      GenreCatalog.actionId,
      GenreCatalog.comedyId,
      GenreCatalog.adventureId,
      GenreCatalog.animationId,
      GenreCatalog.scienceFictionId,
      GenreCatalog.familyId,
      10759,
      10765,
    },
  };

  RecommendationResult recommend({
    required EveningRequest request,
    required List<LibraryEntryWithMedia> library,
    required UserPreferences preferences,
    required List<DismissedSuggestion> dismissals,
    Set<String> excludedKeys = const {},
    DateTime? now,
    int limit = 3,
  }) {
    final effectiveNow = now ?? DateTime.now();
    final safeLimit = limit.clamp(1, 3);
    final dismissalCounts = <String, int>{};
    for (final dismissal in dismissals) {
      dismissalCounts.update(
        dismissal.key,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    if (library.isEmpty) {
      return const RecommendationResult(
        suggestions: [],
        relaxationNote:
            'La tua libreria è vuota. Cerca un film o una serie e aggiungilo '
            'per ricevere proposte su misura.',
      );
    }

    final sourceEntries = library.where((item) {
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
      return _passesEveningConstraints(item.media, request);
    }).toList(growable: false);

    if (sourceEntries.isEmpty) {
      final hasFinished = library.every(
        (item) =>
            item.entry.status == LibraryStatus.completed ||
            item.entry.status == LibraryStatus.abandoned,
      );
      return RecommendationResult(
        suggestions: const [],
        relaxationNote: hasFinished
            ? 'Hai già visto o abbandonato tutti i titoli in libreria. '
                'Aggiungine uno nuovo per la prossima serata.'
            : excludedKeys.isNotEmpty
                ? 'Hai esplorato tutte le proposte disponibili con questi '
                    'criteri. Modifica la serata o aggiungi un titolo.'
                : 'Nessun titolo in libreria rispetta i no assoluti e i '
                    'vincoli scelti. Prova ad allentare un vincolo.',
      );
    }

    final scored = sourceEntries
        .map(
          (item) => _ScoredCandidate(
            item: item,
            score: _score(
              item,
              request,
              preferences,
              dismissalCounts[item.key] ?? 0,
              effectiveNow,
            ),
            estimatedMinutes: item.media.estimatedMinutes(
              fallbackEpisodeMinutes,
            ),
          ),
        )
        .toList(growable: false);

    var candidates = scored
        .where((candidate) => !_isTooLong(candidate, request))
        .toList(growable: false);
    var relaxed = false;
    String? note;

    if (candidates.length < safeLimit) {
      final tooLong = scored
          .where((candidate) => _isTooLong(candidate, request))
          .toList(growable: false);
      if (tooLong.isNotEmpty) {
        candidates = [...candidates, ...tooLong];
        relaxed = true;
        note =
            'Poche opzioni rientrano nel tempo scelto: includo anche titoli '
            'più lunghi, segnalati come «troppo lungo per stasera».';
      }
    }

    candidates.sort(_compareCandidates);

    if (candidates.isEmpty) {
      return const RecommendationResult(
        suggestions: [],
        relaxationNote:
            'Nessun titolo supera i filtri della serata. Prova a cambiare '
            'tempo, umore o vincoli.',
      );
    }

    final selected = candidates.take(safeLimit).toList(growable: false);
    if (note == null && selected.length < safeLimit) {
      note =
          'Ho trovato ${selected.length} ${selected.length == 1 ? "opzione" : "opzioni"} '
          'con i criteri attuali. Allenta un vincolo per ampliare la scelta.';
    }

    return RecommendationResult(
      suggestions: selected
          .map(
            (candidate) => _toSuggestion(
              candidate,
              request,
              effectiveNow,
              relaxed: relaxed,
            ),
          )
          .toList(growable: false),
      relaxationNote: note,
      relaxed: relaxed,
      totalEligible: scored.length,
    );
  }

  double _score(
    LibraryEntryWithMedia item,
    EveningRequest request,
    UserPreferences preferences,
    int dismissalCount,
    DateTime now,
  ) {
    final media = item.media;
    final entry = item.entry;
    final duration = media.estimatedMinutes(fallbackEpisodeMinutes);
    final available = request.availableMinutes;
    var score = 0.0;

    if (available == null) {
      score += duration == null ? 4 : 16;
    } else if (duration == null) {
      score -= 5;
    } else if (duration > available) {
      score -= 45 + math.min(30, (duration - available) * 0.35);
    } else {
      score += 52;
      final slack = available - duration;
      if (slack <= 20) score += 8;
      if (available >= 90 && duration >= available * 0.65) score += 6;
      if (duration < available * 0.35 && available >= 120) score -= 7;
    }

    final moodMatches =
        media.genreIds.intersection(moodGenres[request.mood] ?? const {});
    if (moodMatches.isNotEmpty) {
      score += 32;
      score += math.min(6, (moodMatches.length - 1) * 3);
    }

    final preferredMatches =
        media.genreIds.intersection(preferences.preferredGenres.toSet());
    score += math.min(18, preferredMatches.length * 6.0);

    final avoidedMatches =
        media.genreIds.intersection(preferences.avoidedGenres.toSet());
    score -= math.min(36, avoidedMatches.length * 18.0);

    score += media.tmdbVoteAverage.clamp(0, 10) * 2.2;

    switch (entry.status) {
      case LibraryStatus.toWatch:
        score += 18;
      case LibraryStatus.inProgress:
        score += 16;
      case LibraryStatus.paused:
        score += 10;
      case LibraryStatus.completed:
      case LibraryStatus.abandoned:
        break;
    }

    final days = math.max(0, now.difference(entry.lastActivityAt).inDays);
    if (entry.status.isStarted) {
      score += math.min(12, days * 0.35);
    } else {
      score += math.min(8, days * 0.25);
    }

    if (dismissalCount > 0) {
      score -= 22.0 * dismissalCount;
      if (dismissalCount > 1) score -= 18;
    }

    score += _contextBonus(media, request.context);

    final ageInDays = now.difference(entry.createdAt).inDays;
    if (entry.status == LibraryStatus.toWatch &&
        ageInDays >= 0 &&
        ageInDays <= 7) {
      score += 5;
    }

    if (request.mood == Mood.noThinking) {
      if (duration != null && available != null && duration <= available) {
        score += 6;
      }
      if (media.genreIds.contains(GenreCatalog.documentaryId)) score -= 8;
    }

    if (request.mood == Mood.documentary &&
        media.genreIds.contains(GenreCatalog.documentaryId)) {
      score += 8;
    }

    return score;
  }

  double _contextBonus(MediaItem media, ViewingContext context) {
    final genres = media.genreIds;
    switch (context) {
      case ViewingContext.family:
        var value = 0.0;
        if (genres.intersection({
          GenreCatalog.animationId,
          GenreCatalog.familyId,
          GenreCatalog.comedyId,
          GenreCatalog.kidsId,
        }).isNotEmpty) {
          value += 10;
        }
        if (genres.intersection(GenreCatalog.familySensitiveGenreIds).isNotEmpty) {
          value -= 30;
        }
        return value;
      case ViewingContext.couple:
        var value = 0.0;
        if (genres.contains(GenreCatalog.romanceId)) value += 10;
        if (genres.contains(GenreCatalog.dramaId)) value += 4;
        if (genres.contains(GenreCatalog.comedyId)) value += 3;
        return value;
      case ViewingContext.friends:
        var value = 0.0;
        if (genres.contains(GenreCatalog.comedyId)) value += 8;
        if (genres.intersection({
          GenreCatalog.actionId,
          GenreCatalog.adventureId,
          10759,
        }).isNotEmpty) {
          value += 6;
        }
        return value;
      case ViewingContext.solo:
        var value = 0.0;
        if (genres.contains(GenreCatalog.mysteryId)) value += 5;
        if (genres.contains(GenreCatalog.documentaryId)) value += 5;
        if (genres.contains(GenreCatalog.dramaId)) value += 3;
        return value;
    }
  }

  bool _passesEveningConstraints(MediaItem media, EveningRequest request) {
    final genres = media.genreIds;
    if ((request.noHorror || request.familyOnly) &&
        genres.contains(GenreCatalog.horrorId)) {
      return false;
    }
    if (request.noRomance && genres.contains(GenreCatalog.romanceId)) {
      return false;
    }
    if (request.familyOnly) {
      if (media.isAdult) return false;
      if (genres
          .intersection(GenreCatalog.familySensitiveGenreIds)
          .isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  bool _isTooLong(_ScoredCandidate candidate, EveningRequest request) {
    final available = request.availableMinutes;
    final duration = candidate.estimatedMinutes;
    return available != null && duration != null && duration > available;
  }

  Suggestion _toSuggestion(
    _ScoredCandidate candidate,
    EveningRequest request,
    DateTime now, {
    required bool relaxed,
  }) {
    final item = candidate.item;
    final entry = item.entry;
    final media = item.media;
    final tooLong = _isTooLong(candidate, request);
    final durationUnknown = candidate.estimatedMinutes == null;
    final ageInDays = math.max(0, now.difference(entry.createdAt).inDays);
    final moodMatches =
        media.genreIds.intersection(moodGenres[request.mood] ?? const {});

    SuggestionStatus status;
    if (tooLong) {
      status = SuggestionStatus.tooLong;
    } else if (durationUnknown) {
      status = SuggestionStatus.unknownDuration;
    } else if (entry.status.isStarted) {
      status = SuggestionStatus.alreadyStarted;
    } else if (entry.status == LibraryStatus.toWatch && ageInDays <= 7) {
      status = SuggestionStatus.newTitle;
    } else {
      status = SuggestionStatus.inLibrary;
    }

    final parts = <String>[];
    final duration = candidate.estimatedMinutes;
    if (duration == null) {
      parts.add('durata non nota, quindi non la escludo');
    } else if (tooLong) {
      parts.add(
        '${formatMinutes(duration)} contro i ${request.availableMinutes} minuti '
        'disponibili',
      );
    } else if (request.unlimited) {
      parts.add('circa ${formatMinutes(duration)} senza limiti di tempo');
    } else if (media.mediaType == MediaType.tv) {
      parts.add(
        'circa ${formatMinutes(duration)} per il prossimo episodio, dentro i '
        '${request.availableMinutes} minuti',
      );
    } else {
      parts.add(
        '${formatMinutes(duration)} su ${request.availableMinutes} minuti '
        'disponibili',
      );
    }

    if (moodMatches.isNotEmpty) {
      final genre = media.genres.firstWhere(
        (value) => moodMatches.contains(value.id),
        orElse: () => Genre(id: 0, name: request.mood.label),
      );
      parts.add(
        '«${genre.name.toLowerCase()}» in linea con l’umore '
        '${request.mood.label.toLowerCase()}',
      );
    }

    if (media.mediaType == MediaType.tv && entry.status.isStarted) {
      final next = entry.nextEpisodeLabel;
      parts.add(next == null ? 'riprendi da dove eri rimasto' : 'riprendi da $next');
    } else if (entry.status == LibraryStatus.paused) {
      parts.add('è in pausa, pronta da riprendere');
    } else if (entry.status.isStarted) {
      parts.add('l’hai già iniziato');
    } else if (ageInDays <= 7) {
      parts.add('l’hai aggiunto di recente alla libreria');
    } else {
      parts.add('è nella tua libreria da $ageInDays giorni');
    }

    if (tooLong && relaxed) {
      parts.add('la propongo solo perché le alternative sono poche');
    }

    final reason = _joinReason(parts);
    return Suggestion(
      media: media,
      entry: entry,
      score: candidate.score,
      reason: reason,
      status: status,
      isTooLong: tooLong,
      isDurationUnknown: durationUnknown,
      estimatedMinutes: duration,
    );
  }

  String _joinReason(List<String> parts) {
    if (parts.isEmpty) return 'Una delle opzioni migliori per la tua serata.';
    final buffer = StringBuffer(_capitalize(parts.first));
    for (var index = 1; index < parts.length; index++) {
      if (index == parts.length - 1) {
        buffer.write(' e ');
      } else {
        buffer.write(', ');
      }
      buffer.write(parts[index]);
    }
    buffer.write('.');
    return buffer.toString();
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }

  int _compareCandidates(_ScoredCandidate a, _ScoredCandidate b) {
    final byScore = b.score.compareTo(a.score);
    if (byScore != 0) return byScore;
    final byTitle = a.item.media.title.toLowerCase().compareTo(
          b.item.media.title.toLowerCase(),
        );
    if (byTitle != 0) return byTitle;
    return a.item.media.tmdbId.compareTo(b.item.media.tmdbId);
  }
}

class _ScoredCandidate {
  const _ScoredCandidate({
    required this.item,
    required this.score,
    required this.estimatedMinutes,
  });

  final LibraryEntryWithMedia item;
  final double score;
  final int? estimatedMinutes;
}
