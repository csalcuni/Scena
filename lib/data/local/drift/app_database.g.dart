// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MediaItemsTable extends MediaItems
    with TableInfo<$MediaItemsTable, MediaItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tmdbIdMeta = const VerificationMeta('tmdbId');
  @override
  late final GeneratedColumn<int> tmdbId = GeneratedColumn<int>(
    'tmdb_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _runtimeMinutesMeta = const VerificationMeta(
    'runtimeMinutes',
  );
  @override
  late final GeneratedColumn<int> runtimeMinutes = GeneratedColumn<int>(
    'runtime_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genresJsonMeta = const VerificationMeta(
    'genresJson',
  );
  @override
  late final GeneratedColumn<String> genresJson = GeneratedColumn<String>(
    'genres_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _tmdbVoteAverageMeta = const VerificationMeta(
    'tmdbVoteAverage',
  );
  @override
  late final GeneratedColumn<double> tmdbVoteAverage = GeneratedColumn<double>(
    'tmdb_vote_average',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _numberOfSeasonsMeta = const VerificationMeta(
    'numberOfSeasons',
  );
  @override
  late final GeneratedColumn<int> numberOfSeasons = GeneratedColumn<int>(
    'number_of_seasons',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numberOfEpisodesMeta = const VerificationMeta(
    'numberOfEpisodes',
  );
  @override
  late final GeneratedColumn<int> numberOfEpisodes = GeneratedColumn<int>(
    'number_of_episodes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _episodeRuntimeMinutesMeta =
      const VerificationMeta('episodeRuntimeMinutes');
  @override
  late final GeneratedColumn<int> episodeRuntimeMinutes = GeneratedColumn<int>(
    'episode_runtime_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tvStatusMeta = const VerificationMeta(
    'tvStatus',
  );
  @override
  late final GeneratedColumn<String> tvStatus = GeneratedColumn<String>(
    'tv_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAdultMeta = const VerificationMeta(
    'isAdult',
  );
  @override
  late final GeneratedColumn<bool> isAdult = GeneratedColumn<bool>(
    'is_adult',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_adult" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tmdbId,
    mediaType,
    title,
    originalTitle,
    posterPath,
    backdropPath,
    overview,
    releaseDate,
    runtimeMinutes,
    genresJson,
    tmdbVoteAverage,
    numberOfSeasons,
    numberOfEpisodes,
    episodeRuntimeMinutes,
    tvStatus,
    isAdult,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tmdb_id')) {
      context.handle(
        _tmdbIdMeta,
        tmdbId.isAcceptableOrUnknown(data['tmdb_id']!, _tmdbIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tmdbIdMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('runtime_minutes')) {
      context.handle(
        _runtimeMinutesMeta,
        runtimeMinutes.isAcceptableOrUnknown(
          data['runtime_minutes']!,
          _runtimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('genres_json')) {
      context.handle(
        _genresJsonMeta,
        genresJson.isAcceptableOrUnknown(data['genres_json']!, _genresJsonMeta),
      );
    }
    if (data.containsKey('tmdb_vote_average')) {
      context.handle(
        _tmdbVoteAverageMeta,
        tmdbVoteAverage.isAcceptableOrUnknown(
          data['tmdb_vote_average']!,
          _tmdbVoteAverageMeta,
        ),
      );
    }
    if (data.containsKey('number_of_seasons')) {
      context.handle(
        _numberOfSeasonsMeta,
        numberOfSeasons.isAcceptableOrUnknown(
          data['number_of_seasons']!,
          _numberOfSeasonsMeta,
        ),
      );
    }
    if (data.containsKey('number_of_episodes')) {
      context.handle(
        _numberOfEpisodesMeta,
        numberOfEpisodes.isAcceptableOrUnknown(
          data['number_of_episodes']!,
          _numberOfEpisodesMeta,
        ),
      );
    }
    if (data.containsKey('episode_runtime_minutes')) {
      context.handle(
        _episodeRuntimeMinutesMeta,
        episodeRuntimeMinutes.isAcceptableOrUnknown(
          data['episode_runtime_minutes']!,
          _episodeRuntimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('tv_status')) {
      context.handle(
        _tvStatusMeta,
        tvStatus.isAcceptableOrUnknown(data['tv_status']!, _tvStatusMeta),
      );
    }
    if (data.containsKey('is_adult')) {
      context.handle(
        _isAdultMeta,
        isAdult.isAcceptableOrUnknown(data['is_adult']!, _isAdultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tmdbId, mediaType},
  ];
  @override
  MediaItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tmdbId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tmdb_id'],
      )!,
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      originalTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_title'],
      ),
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      ),
      backdropPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backdrop_path'],
      ),
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      )!,
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      ),
      runtimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}runtime_minutes'],
      ),
      genresJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genres_json'],
      )!,
      tmdbVoteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tmdb_vote_average'],
      )!,
      numberOfSeasons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_seasons'],
      ),
      numberOfEpisodes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_episodes'],
      ),
      episodeRuntimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}episode_runtime_minutes'],
      ),
      tvStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tv_status'],
      ),
      isAdult: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_adult'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MediaItemsTable createAlias(String alias) {
    return $MediaItemsTable(attachedDatabase, alias);
  }
}

class MediaItemRow extends DataClass implements Insertable<MediaItemRow> {
  final int id;
  final int tmdbId;
  final String mediaType;
  final String title;
  final String? originalTitle;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final String? releaseDate;
  final int? runtimeMinutes;
  final String genresJson;
  final double tmdbVoteAverage;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final int? episodeRuntimeMinutes;
  final String? tvStatus;
  final bool isAdult;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MediaItemRow({
    required this.id,
    required this.tmdbId,
    required this.mediaType,
    required this.title,
    this.originalTitle,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    this.releaseDate,
    this.runtimeMinutes,
    required this.genresJson,
    required this.tmdbVoteAverage,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.episodeRuntimeMinutes,
    this.tvStatus,
    required this.isAdult,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tmdb_id'] = Variable<int>(tmdbId);
    map['media_type'] = Variable<String>(mediaType);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    map['overview'] = Variable<String>(overview);
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || runtimeMinutes != null) {
      map['runtime_minutes'] = Variable<int>(runtimeMinutes);
    }
    map['genres_json'] = Variable<String>(genresJson);
    map['tmdb_vote_average'] = Variable<double>(tmdbVoteAverage);
    if (!nullToAbsent || numberOfSeasons != null) {
      map['number_of_seasons'] = Variable<int>(numberOfSeasons);
    }
    if (!nullToAbsent || numberOfEpisodes != null) {
      map['number_of_episodes'] = Variable<int>(numberOfEpisodes);
    }
    if (!nullToAbsent || episodeRuntimeMinutes != null) {
      map['episode_runtime_minutes'] = Variable<int>(episodeRuntimeMinutes);
    }
    if (!nullToAbsent || tvStatus != null) {
      map['tv_status'] = Variable<String>(tvStatus);
    }
    map['is_adult'] = Variable<bool>(isAdult);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MediaItemsCompanion toCompanion(bool nullToAbsent) {
    return MediaItemsCompanion(
      id: Value(id),
      tmdbId: Value(tmdbId),
      mediaType: Value(mediaType),
      title: Value(title),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      overview: Value(overview),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      runtimeMinutes: runtimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(runtimeMinutes),
      genresJson: Value(genresJson),
      tmdbVoteAverage: Value(tmdbVoteAverage),
      numberOfSeasons: numberOfSeasons == null && nullToAbsent
          ? const Value.absent()
          : Value(numberOfSeasons),
      numberOfEpisodes: numberOfEpisodes == null && nullToAbsent
          ? const Value.absent()
          : Value(numberOfEpisodes),
      episodeRuntimeMinutes: episodeRuntimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeRuntimeMinutes),
      tvStatus: tvStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(tvStatus),
      isAdult: Value(isAdult),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaItemRow(
      id: serializer.fromJson<int>(json['id']),
      tmdbId: serializer.fromJson<int>(json['tmdbId']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      title: serializer.fromJson<String>(json['title']),
      originalTitle: serializer.fromJson<String?>(json['originalTitle']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      overview: serializer.fromJson<String>(json['overview']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      runtimeMinutes: serializer.fromJson<int?>(json['runtimeMinutes']),
      genresJson: serializer.fromJson<String>(json['genresJson']),
      tmdbVoteAverage: serializer.fromJson<double>(json['tmdbVoteAverage']),
      numberOfSeasons: serializer.fromJson<int?>(json['numberOfSeasons']),
      numberOfEpisodes: serializer.fromJson<int?>(json['numberOfEpisodes']),
      episodeRuntimeMinutes: serializer.fromJson<int?>(
        json['episodeRuntimeMinutes'],
      ),
      tvStatus: serializer.fromJson<String?>(json['tvStatus']),
      isAdult: serializer.fromJson<bool>(json['isAdult']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tmdbId': serializer.toJson<int>(tmdbId),
      'mediaType': serializer.toJson<String>(mediaType),
      'title': serializer.toJson<String>(title),
      'originalTitle': serializer.toJson<String?>(originalTitle),
      'posterPath': serializer.toJson<String?>(posterPath),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'overview': serializer.toJson<String>(overview),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'runtimeMinutes': serializer.toJson<int?>(runtimeMinutes),
      'genresJson': serializer.toJson<String>(genresJson),
      'tmdbVoteAverage': serializer.toJson<double>(tmdbVoteAverage),
      'numberOfSeasons': serializer.toJson<int?>(numberOfSeasons),
      'numberOfEpisodes': serializer.toJson<int?>(numberOfEpisodes),
      'episodeRuntimeMinutes': serializer.toJson<int?>(episodeRuntimeMinutes),
      'tvStatus': serializer.toJson<String?>(tvStatus),
      'isAdult': serializer.toJson<bool>(isAdult),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MediaItemRow copyWith({
    int? id,
    int? tmdbId,
    String? mediaType,
    String? title,
    Value<String?> originalTitle = const Value.absent(),
    Value<String?> posterPath = const Value.absent(),
    Value<String?> backdropPath = const Value.absent(),
    String? overview,
    Value<String?> releaseDate = const Value.absent(),
    Value<int?> runtimeMinutes = const Value.absent(),
    String? genresJson,
    double? tmdbVoteAverage,
    Value<int?> numberOfSeasons = const Value.absent(),
    Value<int?> numberOfEpisodes = const Value.absent(),
    Value<int?> episodeRuntimeMinutes = const Value.absent(),
    Value<String?> tvStatus = const Value.absent(),
    bool? isAdult,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MediaItemRow(
    id: id ?? this.id,
    tmdbId: tmdbId ?? this.tmdbId,
    mediaType: mediaType ?? this.mediaType,
    title: title ?? this.title,
    originalTitle: originalTitle.present
        ? originalTitle.value
        : this.originalTitle,
    posterPath: posterPath.present ? posterPath.value : this.posterPath,
    backdropPath: backdropPath.present ? backdropPath.value : this.backdropPath,
    overview: overview ?? this.overview,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    runtimeMinutes: runtimeMinutes.present
        ? runtimeMinutes.value
        : this.runtimeMinutes,
    genresJson: genresJson ?? this.genresJson,
    tmdbVoteAverage: tmdbVoteAverage ?? this.tmdbVoteAverage,
    numberOfSeasons: numberOfSeasons.present
        ? numberOfSeasons.value
        : this.numberOfSeasons,
    numberOfEpisodes: numberOfEpisodes.present
        ? numberOfEpisodes.value
        : this.numberOfEpisodes,
    episodeRuntimeMinutes: episodeRuntimeMinutes.present
        ? episodeRuntimeMinutes.value
        : this.episodeRuntimeMinutes,
    tvStatus: tvStatus.present ? tvStatus.value : this.tvStatus,
    isAdult: isAdult ?? this.isAdult,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MediaItemRow copyWithCompanion(MediaItemsCompanion data) {
    return MediaItemRow(
      id: data.id.present ? data.id.value : this.id,
      tmdbId: data.tmdbId.present ? data.tmdbId.value : this.tmdbId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      title: data.title.present ? data.title.value : this.title,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      overview: data.overview.present ? data.overview.value : this.overview,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      runtimeMinutes: data.runtimeMinutes.present
          ? data.runtimeMinutes.value
          : this.runtimeMinutes,
      genresJson: data.genresJson.present
          ? data.genresJson.value
          : this.genresJson,
      tmdbVoteAverage: data.tmdbVoteAverage.present
          ? data.tmdbVoteAverage.value
          : this.tmdbVoteAverage,
      numberOfSeasons: data.numberOfSeasons.present
          ? data.numberOfSeasons.value
          : this.numberOfSeasons,
      numberOfEpisodes: data.numberOfEpisodes.present
          ? data.numberOfEpisodes.value
          : this.numberOfEpisodes,
      episodeRuntimeMinutes: data.episodeRuntimeMinutes.present
          ? data.episodeRuntimeMinutes.value
          : this.episodeRuntimeMinutes,
      tvStatus: data.tvStatus.present ? data.tvStatus.value : this.tvStatus,
      isAdult: data.isAdult.present ? data.isAdult.value : this.isAdult,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemRow(')
          ..write('id: $id, ')
          ..write('tmdbId: $tmdbId, ')
          ..write('mediaType: $mediaType, ')
          ..write('title: $title, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('runtimeMinutes: $runtimeMinutes, ')
          ..write('genresJson: $genresJson, ')
          ..write('tmdbVoteAverage: $tmdbVoteAverage, ')
          ..write('numberOfSeasons: $numberOfSeasons, ')
          ..write('numberOfEpisodes: $numberOfEpisodes, ')
          ..write('episodeRuntimeMinutes: $episodeRuntimeMinutes, ')
          ..write('tvStatus: $tvStatus, ')
          ..write('isAdult: $isAdult, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tmdbId,
    mediaType,
    title,
    originalTitle,
    posterPath,
    backdropPath,
    overview,
    releaseDate,
    runtimeMinutes,
    genresJson,
    tmdbVoteAverage,
    numberOfSeasons,
    numberOfEpisodes,
    episodeRuntimeMinutes,
    tvStatus,
    isAdult,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaItemRow &&
          other.id == this.id &&
          other.tmdbId == this.tmdbId &&
          other.mediaType == this.mediaType &&
          other.title == this.title &&
          other.originalTitle == this.originalTitle &&
          other.posterPath == this.posterPath &&
          other.backdropPath == this.backdropPath &&
          other.overview == this.overview &&
          other.releaseDate == this.releaseDate &&
          other.runtimeMinutes == this.runtimeMinutes &&
          other.genresJson == this.genresJson &&
          other.tmdbVoteAverage == this.tmdbVoteAverage &&
          other.numberOfSeasons == this.numberOfSeasons &&
          other.numberOfEpisodes == this.numberOfEpisodes &&
          other.episodeRuntimeMinutes == this.episodeRuntimeMinutes &&
          other.tvStatus == this.tvStatus &&
          other.isAdult == this.isAdult &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MediaItemsCompanion extends UpdateCompanion<MediaItemRow> {
  final Value<int> id;
  final Value<int> tmdbId;
  final Value<String> mediaType;
  final Value<String> title;
  final Value<String?> originalTitle;
  final Value<String?> posterPath;
  final Value<String?> backdropPath;
  final Value<String> overview;
  final Value<String?> releaseDate;
  final Value<int?> runtimeMinutes;
  final Value<String> genresJson;
  final Value<double> tmdbVoteAverage;
  final Value<int?> numberOfSeasons;
  final Value<int?> numberOfEpisodes;
  final Value<int?> episodeRuntimeMinutes;
  final Value<String?> tvStatus;
  final Value<bool> isAdult;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MediaItemsCompanion({
    this.id = const Value.absent(),
    this.tmdbId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.title = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.overview = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.runtimeMinutes = const Value.absent(),
    this.genresJson = const Value.absent(),
    this.tmdbVoteAverage = const Value.absent(),
    this.numberOfSeasons = const Value.absent(),
    this.numberOfEpisodes = const Value.absent(),
    this.episodeRuntimeMinutes = const Value.absent(),
    this.tvStatus = const Value.absent(),
    this.isAdult = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MediaItemsCompanion.insert({
    this.id = const Value.absent(),
    required int tmdbId,
    required String mediaType,
    required String title,
    this.originalTitle = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.overview = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.runtimeMinutes = const Value.absent(),
    this.genresJson = const Value.absent(),
    this.tmdbVoteAverage = const Value.absent(),
    this.numberOfSeasons = const Value.absent(),
    this.numberOfEpisodes = const Value.absent(),
    this.episodeRuntimeMinutes = const Value.absent(),
    this.tvStatus = const Value.absent(),
    this.isAdult = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : tmdbId = Value(tmdbId),
       mediaType = Value(mediaType),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MediaItemRow> custom({
    Expression<int>? id,
    Expression<int>? tmdbId,
    Expression<String>? mediaType,
    Expression<String>? title,
    Expression<String>? originalTitle,
    Expression<String>? posterPath,
    Expression<String>? backdropPath,
    Expression<String>? overview,
    Expression<String>? releaseDate,
    Expression<int>? runtimeMinutes,
    Expression<String>? genresJson,
    Expression<double>? tmdbVoteAverage,
    Expression<int>? numberOfSeasons,
    Expression<int>? numberOfEpisodes,
    Expression<int>? episodeRuntimeMinutes,
    Expression<String>? tvStatus,
    Expression<bool>? isAdult,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tmdbId != null) 'tmdb_id': tmdbId,
      if (mediaType != null) 'media_type': mediaType,
      if (title != null) 'title': title,
      if (originalTitle != null) 'original_title': originalTitle,
      if (posterPath != null) 'poster_path': posterPath,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (overview != null) 'overview': overview,
      if (releaseDate != null) 'release_date': releaseDate,
      if (runtimeMinutes != null) 'runtime_minutes': runtimeMinutes,
      if (genresJson != null) 'genres_json': genresJson,
      if (tmdbVoteAverage != null) 'tmdb_vote_average': tmdbVoteAverage,
      if (numberOfSeasons != null) 'number_of_seasons': numberOfSeasons,
      if (numberOfEpisodes != null) 'number_of_episodes': numberOfEpisodes,
      if (episodeRuntimeMinutes != null)
        'episode_runtime_minutes': episodeRuntimeMinutes,
      if (tvStatus != null) 'tv_status': tvStatus,
      if (isAdult != null) 'is_adult': isAdult,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MediaItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? tmdbId,
    Value<String>? mediaType,
    Value<String>? title,
    Value<String?>? originalTitle,
    Value<String?>? posterPath,
    Value<String?>? backdropPath,
    Value<String>? overview,
    Value<String?>? releaseDate,
    Value<int?>? runtimeMinutes,
    Value<String>? genresJson,
    Value<double>? tmdbVoteAverage,
    Value<int?>? numberOfSeasons,
    Value<int?>? numberOfEpisodes,
    Value<int?>? episodeRuntimeMinutes,
    Value<String?>? tvStatus,
    Value<bool>? isAdult,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MediaItemsCompanion(
      id: id ?? this.id,
      tmdbId: tmdbId ?? this.tmdbId,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      runtimeMinutes: runtimeMinutes ?? this.runtimeMinutes,
      genresJson: genresJson ?? this.genresJson,
      tmdbVoteAverage: tmdbVoteAverage ?? this.tmdbVoteAverage,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      episodeRuntimeMinutes:
          episodeRuntimeMinutes ?? this.episodeRuntimeMinutes,
      tvStatus: tvStatus ?? this.tvStatus,
      isAdult: isAdult ?? this.isAdult,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tmdbId.present) {
      map['tmdb_id'] = Variable<int>(tmdbId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (runtimeMinutes.present) {
      map['runtime_minutes'] = Variable<int>(runtimeMinutes.value);
    }
    if (genresJson.present) {
      map['genres_json'] = Variable<String>(genresJson.value);
    }
    if (tmdbVoteAverage.present) {
      map['tmdb_vote_average'] = Variable<double>(tmdbVoteAverage.value);
    }
    if (numberOfSeasons.present) {
      map['number_of_seasons'] = Variable<int>(numberOfSeasons.value);
    }
    if (numberOfEpisodes.present) {
      map['number_of_episodes'] = Variable<int>(numberOfEpisodes.value);
    }
    if (episodeRuntimeMinutes.present) {
      map['episode_runtime_minutes'] = Variable<int>(
        episodeRuntimeMinutes.value,
      );
    }
    if (tvStatus.present) {
      map['tv_status'] = Variable<String>(tvStatus.value);
    }
    if (isAdult.present) {
      map['is_adult'] = Variable<bool>(isAdult.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemsCompanion(')
          ..write('id: $id, ')
          ..write('tmdbId: $tmdbId, ')
          ..write('mediaType: $mediaType, ')
          ..write('title: $title, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('runtimeMinutes: $runtimeMinutes, ')
          ..write('genresJson: $genresJson, ')
          ..write('tmdbVoteAverage: $tmdbVoteAverage, ')
          ..write('numberOfSeasons: $numberOfSeasons, ')
          ..write('numberOfEpisodes: $numberOfEpisodes, ')
          ..write('episodeRuntimeMinutes: $episodeRuntimeMinutes, ')
          ..write('tvStatus: $tvStatus, ')
          ..write('isAdult: $isAdult, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LibraryEntriesTable extends LibraryEntries
    with TableInfo<$LibraryEntriesTable, LibraryEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mediaItemIdMeta = const VerificationMeta(
    'mediaItemId',
  );
  @override
  late final GeneratedColumn<int> mediaItemId = GeneratedColumn<int>(
    'media_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personalRatingMeta = const VerificationMeta(
    'personalRating',
  );
  @override
  late final GeneratedColumn<int> personalRating = GeneratedColumn<int>(
    'personal_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _personalNoteMeta = const VerificationMeta(
    'personalNote',
  );
  @override
  late final GeneratedColumn<String> personalNote = GeneratedColumn<String>(
    'personal_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _currentSeasonMeta = const VerificationMeta(
    'currentSeason',
  );
  @override
  late final GeneratedColumn<int> currentSeason = GeneratedColumn<int>(
    'current_season',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentEpisodeMeta = const VerificationMeta(
    'currentEpisode',
  );
  @override
  late final GeneratedColumn<int> currentEpisode = GeneratedColumn<int>(
    'current_episode',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastActivityAtMeta = const VerificationMeta(
    'lastActivityAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastActivityAt =
      GeneratedColumn<DateTime>(
        'last_activity_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mediaItemId,
    status,
    personalRating,
    personalNote,
    tagsJson,
    currentSeason,
    currentEpisode,
    lastActivityAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LibraryEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('media_item_id')) {
      context.handle(
        _mediaItemIdMeta,
        mediaItemId.isAcceptableOrUnknown(
          data['media_item_id']!,
          _mediaItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaItemIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('personal_rating')) {
      context.handle(
        _personalRatingMeta,
        personalRating.isAcceptableOrUnknown(
          data['personal_rating']!,
          _personalRatingMeta,
        ),
      );
    }
    if (data.containsKey('personal_note')) {
      context.handle(
        _personalNoteMeta,
        personalNote.isAcceptableOrUnknown(
          data['personal_note']!,
          _personalNoteMeta,
        ),
      );
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    }
    if (data.containsKey('current_season')) {
      context.handle(
        _currentSeasonMeta,
        currentSeason.isAcceptableOrUnknown(
          data['current_season']!,
          _currentSeasonMeta,
        ),
      );
    }
    if (data.containsKey('current_episode')) {
      context.handle(
        _currentEpisodeMeta,
        currentEpisode.isAcceptableOrUnknown(
          data['current_episode']!,
          _currentEpisodeMeta,
        ),
      );
    }
    if (data.containsKey('last_activity_at')) {
      context.handle(
        _lastActivityAtMeta,
        lastActivityAt.isAcceptableOrUnknown(
          data['last_activity_at']!,
          _lastActivityAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastActivityAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {mediaItemId},
  ];
  @override
  LibraryEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mediaItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}media_item_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      personalRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}personal_rating'],
      ),
      personalNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personal_note'],
      ),
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      )!,
      currentSeason: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_season'],
      ),
      currentEpisode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_episode'],
      ),
      lastActivityAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_activity_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LibraryEntriesTable createAlias(String alias) {
    return $LibraryEntriesTable(attachedDatabase, alias);
  }
}

class LibraryEntryRow extends DataClass implements Insertable<LibraryEntryRow> {
  final int id;
  final int mediaItemId;
  final String status;
  final int? personalRating;
  final String? personalNote;
  final String tagsJson;
  final int? currentSeason;
  final int? currentEpisode;
  final DateTime lastActivityAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LibraryEntryRow({
    required this.id,
    required this.mediaItemId,
    required this.status,
    this.personalRating,
    this.personalNote,
    required this.tagsJson,
    this.currentSeason,
    this.currentEpisode,
    required this.lastActivityAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['media_item_id'] = Variable<int>(mediaItemId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || personalRating != null) {
      map['personal_rating'] = Variable<int>(personalRating);
    }
    if (!nullToAbsent || personalNote != null) {
      map['personal_note'] = Variable<String>(personalNote);
    }
    map['tags_json'] = Variable<String>(tagsJson);
    if (!nullToAbsent || currentSeason != null) {
      map['current_season'] = Variable<int>(currentSeason);
    }
    if (!nullToAbsent || currentEpisode != null) {
      map['current_episode'] = Variable<int>(currentEpisode);
    }
    map['last_activity_at'] = Variable<DateTime>(lastActivityAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LibraryEntriesCompanion toCompanion(bool nullToAbsent) {
    return LibraryEntriesCompanion(
      id: Value(id),
      mediaItemId: Value(mediaItemId),
      status: Value(status),
      personalRating: personalRating == null && nullToAbsent
          ? const Value.absent()
          : Value(personalRating),
      personalNote: personalNote == null && nullToAbsent
          ? const Value.absent()
          : Value(personalNote),
      tagsJson: Value(tagsJson),
      currentSeason: currentSeason == null && nullToAbsent
          ? const Value.absent()
          : Value(currentSeason),
      currentEpisode: currentEpisode == null && nullToAbsent
          ? const Value.absent()
          : Value(currentEpisode),
      lastActivityAt: Value(lastActivityAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LibraryEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryEntryRow(
      id: serializer.fromJson<int>(json['id']),
      mediaItemId: serializer.fromJson<int>(json['mediaItemId']),
      status: serializer.fromJson<String>(json['status']),
      personalRating: serializer.fromJson<int?>(json['personalRating']),
      personalNote: serializer.fromJson<String?>(json['personalNote']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      currentSeason: serializer.fromJson<int?>(json['currentSeason']),
      currentEpisode: serializer.fromJson<int?>(json['currentEpisode']),
      lastActivityAt: serializer.fromJson<DateTime>(json['lastActivityAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mediaItemId': serializer.toJson<int>(mediaItemId),
      'status': serializer.toJson<String>(status),
      'personalRating': serializer.toJson<int?>(personalRating),
      'personalNote': serializer.toJson<String?>(personalNote),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'currentSeason': serializer.toJson<int?>(currentSeason),
      'currentEpisode': serializer.toJson<int?>(currentEpisode),
      'lastActivityAt': serializer.toJson<DateTime>(lastActivityAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LibraryEntryRow copyWith({
    int? id,
    int? mediaItemId,
    String? status,
    Value<int?> personalRating = const Value.absent(),
    Value<String?> personalNote = const Value.absent(),
    String? tagsJson,
    Value<int?> currentSeason = const Value.absent(),
    Value<int?> currentEpisode = const Value.absent(),
    DateTime? lastActivityAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LibraryEntryRow(
    id: id ?? this.id,
    mediaItemId: mediaItemId ?? this.mediaItemId,
    status: status ?? this.status,
    personalRating: personalRating.present
        ? personalRating.value
        : this.personalRating,
    personalNote: personalNote.present ? personalNote.value : this.personalNote,
    tagsJson: tagsJson ?? this.tagsJson,
    currentSeason: currentSeason.present
        ? currentSeason.value
        : this.currentSeason,
    currentEpisode: currentEpisode.present
        ? currentEpisode.value
        : this.currentEpisode,
    lastActivityAt: lastActivityAt ?? this.lastActivityAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LibraryEntryRow copyWithCompanion(LibraryEntriesCompanion data) {
    return LibraryEntryRow(
      id: data.id.present ? data.id.value : this.id,
      mediaItemId: data.mediaItemId.present
          ? data.mediaItemId.value
          : this.mediaItemId,
      status: data.status.present ? data.status.value : this.status,
      personalRating: data.personalRating.present
          ? data.personalRating.value
          : this.personalRating,
      personalNote: data.personalNote.present
          ? data.personalNote.value
          : this.personalNote,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      currentSeason: data.currentSeason.present
          ? data.currentSeason.value
          : this.currentSeason,
      currentEpisode: data.currentEpisode.present
          ? data.currentEpisode.value
          : this.currentEpisode,
      lastActivityAt: data.lastActivityAt.present
          ? data.lastActivityAt.value
          : this.lastActivityAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryEntryRow(')
          ..write('id: $id, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('status: $status, ')
          ..write('personalRating: $personalRating, ')
          ..write('personalNote: $personalNote, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('currentSeason: $currentSeason, ')
          ..write('currentEpisode: $currentEpisode, ')
          ..write('lastActivityAt: $lastActivityAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mediaItemId,
    status,
    personalRating,
    personalNote,
    tagsJson,
    currentSeason,
    currentEpisode,
    lastActivityAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryEntryRow &&
          other.id == this.id &&
          other.mediaItemId == this.mediaItemId &&
          other.status == this.status &&
          other.personalRating == this.personalRating &&
          other.personalNote == this.personalNote &&
          other.tagsJson == this.tagsJson &&
          other.currentSeason == this.currentSeason &&
          other.currentEpisode == this.currentEpisode &&
          other.lastActivityAt == this.lastActivityAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LibraryEntriesCompanion extends UpdateCompanion<LibraryEntryRow> {
  final Value<int> id;
  final Value<int> mediaItemId;
  final Value<String> status;
  final Value<int?> personalRating;
  final Value<String?> personalNote;
  final Value<String> tagsJson;
  final Value<int?> currentSeason;
  final Value<int?> currentEpisode;
  final Value<DateTime> lastActivityAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LibraryEntriesCompanion({
    this.id = const Value.absent(),
    this.mediaItemId = const Value.absent(),
    this.status = const Value.absent(),
    this.personalRating = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.currentSeason = const Value.absent(),
    this.currentEpisode = const Value.absent(),
    this.lastActivityAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LibraryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int mediaItemId,
    required String status,
    this.personalRating = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.currentSeason = const Value.absent(),
    this.currentEpisode = const Value.absent(),
    required DateTime lastActivityAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : mediaItemId = Value(mediaItemId),
       status = Value(status),
       lastActivityAt = Value(lastActivityAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LibraryEntryRow> custom({
    Expression<int>? id,
    Expression<int>? mediaItemId,
    Expression<String>? status,
    Expression<int>? personalRating,
    Expression<String>? personalNote,
    Expression<String>? tagsJson,
    Expression<int>? currentSeason,
    Expression<int>? currentEpisode,
    Expression<DateTime>? lastActivityAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mediaItemId != null) 'media_item_id': mediaItemId,
      if (status != null) 'status': status,
      if (personalRating != null) 'personal_rating': personalRating,
      if (personalNote != null) 'personal_note': personalNote,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (currentSeason != null) 'current_season': currentSeason,
      if (currentEpisode != null) 'current_episode': currentEpisode,
      if (lastActivityAt != null) 'last_activity_at': lastActivityAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LibraryEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? mediaItemId,
    Value<String>? status,
    Value<int?>? personalRating,
    Value<String?>? personalNote,
    Value<String>? tagsJson,
    Value<int?>? currentSeason,
    Value<int?>? currentEpisode,
    Value<DateTime>? lastActivityAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LibraryEntriesCompanion(
      id: id ?? this.id,
      mediaItemId: mediaItemId ?? this.mediaItemId,
      status: status ?? this.status,
      personalRating: personalRating ?? this.personalRating,
      personalNote: personalNote ?? this.personalNote,
      tagsJson: tagsJson ?? this.tagsJson,
      currentSeason: currentSeason ?? this.currentSeason,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mediaItemId.present) {
      map['media_item_id'] = Variable<int>(mediaItemId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (personalRating.present) {
      map['personal_rating'] = Variable<int>(personalRating.value);
    }
    if (personalNote.present) {
      map['personal_note'] = Variable<String>(personalNote.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (currentSeason.present) {
      map['current_season'] = Variable<int>(currentSeason.value);
    }
    if (currentEpisode.present) {
      map['current_episode'] = Variable<int>(currentEpisode.value);
    }
    if (lastActivityAt.present) {
      map['last_activity_at'] = Variable<DateTime>(lastActivityAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('status: $status, ')
          ..write('personalRating: $personalRating, ')
          ..write('personalNote: $personalNote, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('currentSeason: $currentSeason, ')
          ..write('currentEpisode: $currentEpisode, ')
          ..write('lastActivityAt: $lastActivityAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ViewingEventsTable extends ViewingEvents
    with TableInfo<$ViewingEventsTable, ViewingEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViewingEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _libraryEntryIdMeta = const VerificationMeta(
    'libraryEntryId',
  );
  @override
  late final GeneratedColumn<int> libraryEntryId = GeneratedColumn<int>(
    'library_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES library_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<int> season = GeneratedColumn<int>(
    'season',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _episodeMeta = const VerificationMeta(
    'episode',
  );
  @override
  late final GeneratedColumn<int> episode = GeneratedColumn<int>(
    'episode',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryEntryId,
    eventType,
    season,
    episode,
    occurredAt,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'viewing_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ViewingEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('library_entry_id')) {
      context.handle(
        _libraryEntryIdMeta,
        libraryEntryId.isAcceptableOrUnknown(
          data['library_entry_id']!,
          _libraryEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_libraryEntryIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('episode')) {
      context.handle(
        _episodeMeta,
        episode.isAcceptableOrUnknown(data['episode']!, _episodeMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ViewingEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ViewingEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      libraryEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}library_entry_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season'],
      ),
      episode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}episode'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ViewingEventsTable createAlias(String alias) {
    return $ViewingEventsTable(attachedDatabase, alias);
  }
}

class ViewingEventRow extends DataClass implements Insertable<ViewingEventRow> {
  final int id;
  final int libraryEntryId;
  final String eventType;
  final int? season;
  final int? episode;
  final DateTime occurredAt;
  final String? note;
  const ViewingEventRow({
    required this.id,
    required this.libraryEntryId,
    required this.eventType,
    this.season,
    this.episode,
    required this.occurredAt,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['library_entry_id'] = Variable<int>(libraryEntryId);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || season != null) {
      map['season'] = Variable<int>(season);
    }
    if (!nullToAbsent || episode != null) {
      map['episode'] = Variable<int>(episode);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ViewingEventsCompanion toCompanion(bool nullToAbsent) {
    return ViewingEventsCompanion(
      id: Value(id),
      libraryEntryId: Value(libraryEntryId),
      eventType: Value(eventType),
      season: season == null && nullToAbsent
          ? const Value.absent()
          : Value(season),
      episode: episode == null && nullToAbsent
          ? const Value.absent()
          : Value(episode),
      occurredAt: Value(occurredAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ViewingEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ViewingEventRow(
      id: serializer.fromJson<int>(json['id']),
      libraryEntryId: serializer.fromJson<int>(json['libraryEntryId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      season: serializer.fromJson<int?>(json['season']),
      episode: serializer.fromJson<int?>(json['episode']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'libraryEntryId': serializer.toJson<int>(libraryEntryId),
      'eventType': serializer.toJson<String>(eventType),
      'season': serializer.toJson<int?>(season),
      'episode': serializer.toJson<int?>(episode),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  ViewingEventRow copyWith({
    int? id,
    int? libraryEntryId,
    String? eventType,
    Value<int?> season = const Value.absent(),
    Value<int?> episode = const Value.absent(),
    DateTime? occurredAt,
    Value<String?> note = const Value.absent(),
  }) => ViewingEventRow(
    id: id ?? this.id,
    libraryEntryId: libraryEntryId ?? this.libraryEntryId,
    eventType: eventType ?? this.eventType,
    season: season.present ? season.value : this.season,
    episode: episode.present ? episode.value : this.episode,
    occurredAt: occurredAt ?? this.occurredAt,
    note: note.present ? note.value : this.note,
  );
  ViewingEventRow copyWithCompanion(ViewingEventsCompanion data) {
    return ViewingEventRow(
      id: data.id.present ? data.id.value : this.id,
      libraryEntryId: data.libraryEntryId.present
          ? data.libraryEntryId.value
          : this.libraryEntryId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      season: data.season.present ? data.season.value : this.season,
      episode: data.episode.present ? data.episode.value : this.episode,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ViewingEventRow(')
          ..write('id: $id, ')
          ..write('libraryEntryId: $libraryEntryId, ')
          ..write('eventType: $eventType, ')
          ..write('season: $season, ')
          ..write('episode: $episode, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryEntryId,
    eventType,
    season,
    episode,
    occurredAt,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViewingEventRow &&
          other.id == this.id &&
          other.libraryEntryId == this.libraryEntryId &&
          other.eventType == this.eventType &&
          other.season == this.season &&
          other.episode == this.episode &&
          other.occurredAt == this.occurredAt &&
          other.note == this.note);
}

class ViewingEventsCompanion extends UpdateCompanion<ViewingEventRow> {
  final Value<int> id;
  final Value<int> libraryEntryId;
  final Value<String> eventType;
  final Value<int?> season;
  final Value<int?> episode;
  final Value<DateTime> occurredAt;
  final Value<String?> note;
  const ViewingEventsCompanion({
    this.id = const Value.absent(),
    this.libraryEntryId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.season = const Value.absent(),
    this.episode = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.note = const Value.absent(),
  });
  ViewingEventsCompanion.insert({
    this.id = const Value.absent(),
    required int libraryEntryId,
    required String eventType,
    this.season = const Value.absent(),
    this.episode = const Value.absent(),
    required DateTime occurredAt,
    this.note = const Value.absent(),
  }) : libraryEntryId = Value(libraryEntryId),
       eventType = Value(eventType),
       occurredAt = Value(occurredAt);
  static Insertable<ViewingEventRow> custom({
    Expression<int>? id,
    Expression<int>? libraryEntryId,
    Expression<String>? eventType,
    Expression<int>? season,
    Expression<int>? episode,
    Expression<DateTime>? occurredAt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryEntryId != null) 'library_entry_id': libraryEntryId,
      if (eventType != null) 'event_type': eventType,
      if (season != null) 'season': season,
      if (episode != null) 'episode': episode,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (note != null) 'note': note,
    });
  }

  ViewingEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? libraryEntryId,
    Value<String>? eventType,
    Value<int?>? season,
    Value<int?>? episode,
    Value<DateTime>? occurredAt,
    Value<String?>? note,
  }) {
    return ViewingEventsCompanion(
      id: id ?? this.id,
      libraryEntryId: libraryEntryId ?? this.libraryEntryId,
      eventType: eventType ?? this.eventType,
      season: season ?? this.season,
      episode: episode ?? this.episode,
      occurredAt: occurredAt ?? this.occurredAt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (libraryEntryId.present) {
      map['library_entry_id'] = Variable<int>(libraryEntryId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (episode.present) {
      map['episode'] = Variable<int>(episode.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewingEventsCompanion(')
          ..write('id: $id, ')
          ..write('libraryEntryId: $libraryEntryId, ')
          ..write('eventType: $eventType, ')
          ..write('season: $season, ')
          ..write('episode: $episode, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTableTable extends UserPreferencesTable
    with TableInfo<$UserPreferencesTableTable, UserPreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _streamingServicesJsonMeta =
      const VerificationMeta('streamingServicesJson');
  @override
  late final GeneratedColumn<String> streamingServicesJson =
      GeneratedColumn<String>(
        'streaming_services_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _preferredGenresJsonMeta =
      const VerificationMeta('preferredGenresJson');
  @override
  late final GeneratedColumn<String> preferredGenresJson =
      GeneratedColumn<String>(
        'preferred_genres_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _avoidedGenresJsonMeta = const VerificationMeta(
    'avoidedGenresJson',
  );
  @override
  late final GeneratedColumn<String> avoidedGenresJson =
      GeneratedColumn<String>(
        'avoided_genres_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _preferredRuntimeMinutesMeta =
      const VerificationMeta('preferredRuntimeMinutes');
  @override
  late final GeneratedColumn<int> preferredRuntimeMinutes =
      GeneratedColumn<int>(
        'preferred_runtime_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(120),
      );
  static const VerificationMeta _hardExclusionsJsonMeta =
      const VerificationMeta('hardExclusionsJson');
  @override
  late final GeneratedColumn<String> hardExclusionsJson =
      GeneratedColumn<String>(
        'hard_exclusions_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    streamingServicesJson,
    preferredGenresJson,
    avoidedGenresJson,
    preferredRuntimeMinutes,
    hardExclusionsJson,
    themeMode,
    onboardingCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('streaming_services_json')) {
      context.handle(
        _streamingServicesJsonMeta,
        streamingServicesJson.isAcceptableOrUnknown(
          data['streaming_services_json']!,
          _streamingServicesJsonMeta,
        ),
      );
    }
    if (data.containsKey('preferred_genres_json')) {
      context.handle(
        _preferredGenresJsonMeta,
        preferredGenresJson.isAcceptableOrUnknown(
          data['preferred_genres_json']!,
          _preferredGenresJsonMeta,
        ),
      );
    }
    if (data.containsKey('avoided_genres_json')) {
      context.handle(
        _avoidedGenresJsonMeta,
        avoidedGenresJson.isAcceptableOrUnknown(
          data['avoided_genres_json']!,
          _avoidedGenresJsonMeta,
        ),
      );
    }
    if (data.containsKey('preferred_runtime_minutes')) {
      context.handle(
        _preferredRuntimeMinutesMeta,
        preferredRuntimeMinutes.isAcceptableOrUnknown(
          data['preferred_runtime_minutes']!,
          _preferredRuntimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('hard_exclusions_json')) {
      context.handle(
        _hardExclusionsJsonMeta,
        hardExclusionsJson.isAcceptableOrUnknown(
          data['hard_exclusions_json']!,
          _hardExclusionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      streamingServicesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}streaming_services_json'],
      )!,
      preferredGenresJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_genres_json'],
      )!,
      avoidedGenresJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avoided_genres_json'],
      )!,
      preferredRuntimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferred_runtime_minutes'],
      )!,
      hardExclusionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hard_exclusions_json'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
    );
  }

  @override
  $UserPreferencesTableTable createAlias(String alias) {
    return $UserPreferencesTableTable(attachedDatabase, alias);
  }
}

class UserPreferenceRow extends DataClass
    implements Insertable<UserPreferenceRow> {
  final int id;
  final String streamingServicesJson;
  final String preferredGenresJson;
  final String avoidedGenresJson;
  final int preferredRuntimeMinutes;
  final String hardExclusionsJson;
  final String themeMode;
  final bool onboardingCompleted;
  const UserPreferenceRow({
    required this.id,
    required this.streamingServicesJson,
    required this.preferredGenresJson,
    required this.avoidedGenresJson,
    required this.preferredRuntimeMinutes,
    required this.hardExclusionsJson,
    required this.themeMode,
    required this.onboardingCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['streaming_services_json'] = Variable<String>(streamingServicesJson);
    map['preferred_genres_json'] = Variable<String>(preferredGenresJson);
    map['avoided_genres_json'] = Variable<String>(avoidedGenresJson);
    map['preferred_runtime_minutes'] = Variable<int>(preferredRuntimeMinutes);
    map['hard_exclusions_json'] = Variable<String>(hardExclusionsJson);
    map['theme_mode'] = Variable<String>(themeMode);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    return map;
  }

  UserPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesTableCompanion(
      id: Value(id),
      streamingServicesJson: Value(streamingServicesJson),
      preferredGenresJson: Value(preferredGenresJson),
      avoidedGenresJson: Value(avoidedGenresJson),
      preferredRuntimeMinutes: Value(preferredRuntimeMinutes),
      hardExclusionsJson: Value(hardExclusionsJson),
      themeMode: Value(themeMode),
      onboardingCompleted: Value(onboardingCompleted),
    );
  }

  factory UserPreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferenceRow(
      id: serializer.fromJson<int>(json['id']),
      streamingServicesJson: serializer.fromJson<String>(
        json['streamingServicesJson'],
      ),
      preferredGenresJson: serializer.fromJson<String>(
        json['preferredGenresJson'],
      ),
      avoidedGenresJson: serializer.fromJson<String>(json['avoidedGenresJson']),
      preferredRuntimeMinutes: serializer.fromJson<int>(
        json['preferredRuntimeMinutes'],
      ),
      hardExclusionsJson: serializer.fromJson<String>(
        json['hardExclusionsJson'],
      ),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'streamingServicesJson': serializer.toJson<String>(streamingServicesJson),
      'preferredGenresJson': serializer.toJson<String>(preferredGenresJson),
      'avoidedGenresJson': serializer.toJson<String>(avoidedGenresJson),
      'preferredRuntimeMinutes': serializer.toJson<int>(
        preferredRuntimeMinutes,
      ),
      'hardExclusionsJson': serializer.toJson<String>(hardExclusionsJson),
      'themeMode': serializer.toJson<String>(themeMode),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
    };
  }

  UserPreferenceRow copyWith({
    int? id,
    String? streamingServicesJson,
    String? preferredGenresJson,
    String? avoidedGenresJson,
    int? preferredRuntimeMinutes,
    String? hardExclusionsJson,
    String? themeMode,
    bool? onboardingCompleted,
  }) => UserPreferenceRow(
    id: id ?? this.id,
    streamingServicesJson: streamingServicesJson ?? this.streamingServicesJson,
    preferredGenresJson: preferredGenresJson ?? this.preferredGenresJson,
    avoidedGenresJson: avoidedGenresJson ?? this.avoidedGenresJson,
    preferredRuntimeMinutes:
        preferredRuntimeMinutes ?? this.preferredRuntimeMinutes,
    hardExclusionsJson: hardExclusionsJson ?? this.hardExclusionsJson,
    themeMode: themeMode ?? this.themeMode,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
  );
  UserPreferenceRow copyWithCompanion(UserPreferencesTableCompanion data) {
    return UserPreferenceRow(
      id: data.id.present ? data.id.value : this.id,
      streamingServicesJson: data.streamingServicesJson.present
          ? data.streamingServicesJson.value
          : this.streamingServicesJson,
      preferredGenresJson: data.preferredGenresJson.present
          ? data.preferredGenresJson.value
          : this.preferredGenresJson,
      avoidedGenresJson: data.avoidedGenresJson.present
          ? data.avoidedGenresJson.value
          : this.avoidedGenresJson,
      preferredRuntimeMinutes: data.preferredRuntimeMinutes.present
          ? data.preferredRuntimeMinutes.value
          : this.preferredRuntimeMinutes,
      hardExclusionsJson: data.hardExclusionsJson.present
          ? data.hardExclusionsJson.value
          : this.hardExclusionsJson,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferenceRow(')
          ..write('id: $id, ')
          ..write('streamingServicesJson: $streamingServicesJson, ')
          ..write('preferredGenresJson: $preferredGenresJson, ')
          ..write('avoidedGenresJson: $avoidedGenresJson, ')
          ..write('preferredRuntimeMinutes: $preferredRuntimeMinutes, ')
          ..write('hardExclusionsJson: $hardExclusionsJson, ')
          ..write('themeMode: $themeMode, ')
          ..write('onboardingCompleted: $onboardingCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    streamingServicesJson,
    preferredGenresJson,
    avoidedGenresJson,
    preferredRuntimeMinutes,
    hardExclusionsJson,
    themeMode,
    onboardingCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferenceRow &&
          other.id == this.id &&
          other.streamingServicesJson == this.streamingServicesJson &&
          other.preferredGenresJson == this.preferredGenresJson &&
          other.avoidedGenresJson == this.avoidedGenresJson &&
          other.preferredRuntimeMinutes == this.preferredRuntimeMinutes &&
          other.hardExclusionsJson == this.hardExclusionsJson &&
          other.themeMode == this.themeMode &&
          other.onboardingCompleted == this.onboardingCompleted);
}

class UserPreferencesTableCompanion extends UpdateCompanion<UserPreferenceRow> {
  final Value<int> id;
  final Value<String> streamingServicesJson;
  final Value<String> preferredGenresJson;
  final Value<String> avoidedGenresJson;
  final Value<int> preferredRuntimeMinutes;
  final Value<String> hardExclusionsJson;
  final Value<String> themeMode;
  final Value<bool> onboardingCompleted;
  const UserPreferencesTableCompanion({
    this.id = const Value.absent(),
    this.streamingServicesJson = const Value.absent(),
    this.preferredGenresJson = const Value.absent(),
    this.avoidedGenresJson = const Value.absent(),
    this.preferredRuntimeMinutes = const Value.absent(),
    this.hardExclusionsJson = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
  });
  UserPreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    this.streamingServicesJson = const Value.absent(),
    this.preferredGenresJson = const Value.absent(),
    this.avoidedGenresJson = const Value.absent(),
    this.preferredRuntimeMinutes = const Value.absent(),
    this.hardExclusionsJson = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
  });
  static Insertable<UserPreferenceRow> custom({
    Expression<int>? id,
    Expression<String>? streamingServicesJson,
    Expression<String>? preferredGenresJson,
    Expression<String>? avoidedGenresJson,
    Expression<int>? preferredRuntimeMinutes,
    Expression<String>? hardExclusionsJson,
    Expression<String>? themeMode,
    Expression<bool>? onboardingCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (streamingServicesJson != null)
        'streaming_services_json': streamingServicesJson,
      if (preferredGenresJson != null)
        'preferred_genres_json': preferredGenresJson,
      if (avoidedGenresJson != null) 'avoided_genres_json': avoidedGenresJson,
      if (preferredRuntimeMinutes != null)
        'preferred_runtime_minutes': preferredRuntimeMinutes,
      if (hardExclusionsJson != null)
        'hard_exclusions_json': hardExclusionsJson,
      if (themeMode != null) 'theme_mode': themeMode,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
    });
  }

  UserPreferencesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? streamingServicesJson,
    Value<String>? preferredGenresJson,
    Value<String>? avoidedGenresJson,
    Value<int>? preferredRuntimeMinutes,
    Value<String>? hardExclusionsJson,
    Value<String>? themeMode,
    Value<bool>? onboardingCompleted,
  }) {
    return UserPreferencesTableCompanion(
      id: id ?? this.id,
      streamingServicesJson:
          streamingServicesJson ?? this.streamingServicesJson,
      preferredGenresJson: preferredGenresJson ?? this.preferredGenresJson,
      avoidedGenresJson: avoidedGenresJson ?? this.avoidedGenresJson,
      preferredRuntimeMinutes:
          preferredRuntimeMinutes ?? this.preferredRuntimeMinutes,
      hardExclusionsJson: hardExclusionsJson ?? this.hardExclusionsJson,
      themeMode: themeMode ?? this.themeMode,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (streamingServicesJson.present) {
      map['streaming_services_json'] = Variable<String>(
        streamingServicesJson.value,
      );
    }
    if (preferredGenresJson.present) {
      map['preferred_genres_json'] = Variable<String>(
        preferredGenresJson.value,
      );
    }
    if (avoidedGenresJson.present) {
      map['avoided_genres_json'] = Variable<String>(avoidedGenresJson.value);
    }
    if (preferredRuntimeMinutes.present) {
      map['preferred_runtime_minutes'] = Variable<int>(
        preferredRuntimeMinutes.value,
      );
    }
    if (hardExclusionsJson.present) {
      map['hard_exclusions_json'] = Variable<String>(hardExclusionsJson.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('streamingServicesJson: $streamingServicesJson, ')
          ..write('preferredGenresJson: $preferredGenresJson, ')
          ..write('avoidedGenresJson: $avoidedGenresJson, ')
          ..write('preferredRuntimeMinutes: $preferredRuntimeMinutes, ')
          ..write('hardExclusionsJson: $hardExclusionsJson, ')
          ..write('themeMode: $themeMode, ')
          ..write('onboardingCompleted: $onboardingCompleted')
          ..write(')'))
        .toString();
  }
}

class $DismissedSuggestionsTable extends DismissedSuggestions
    with TableInfo<$DismissedSuggestionsTable, DismissedSuggestionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DismissedSuggestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tmdbIdMeta = const VerificationMeta('tmdbId');
  @override
  late final GeneratedColumn<int> tmdbId = GeneratedColumn<int>(
    'tmdb_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dismissedAtMeta = const VerificationMeta(
    'dismissedAt',
  );
  @override
  late final GeneratedColumn<DateTime> dismissedAt = GeneratedColumn<DateTime>(
    'dismissed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tmdbId,
    mediaType,
    reason,
    dismissedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dismissed_suggestions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DismissedSuggestionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tmdb_id')) {
      context.handle(
        _tmdbIdMeta,
        tmdbId.isAcceptableOrUnknown(data['tmdb_id']!, _tmdbIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tmdbIdMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('dismissed_at')) {
      context.handle(
        _dismissedAtMeta,
        dismissedAt.isAcceptableOrUnknown(
          data['dismissed_at']!,
          _dismissedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dismissedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DismissedSuggestionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DismissedSuggestionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tmdbId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tmdb_id'],
      )!,
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      dismissedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dismissed_at'],
      )!,
    );
  }

  @override
  $DismissedSuggestionsTable createAlias(String alias) {
    return $DismissedSuggestionsTable(attachedDatabase, alias);
  }
}

class DismissedSuggestionRow extends DataClass
    implements Insertable<DismissedSuggestionRow> {
  final int id;
  final int tmdbId;
  final String mediaType;
  final String reason;
  final DateTime dismissedAt;
  const DismissedSuggestionRow({
    required this.id,
    required this.tmdbId,
    required this.mediaType,
    required this.reason,
    required this.dismissedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tmdb_id'] = Variable<int>(tmdbId);
    map['media_type'] = Variable<String>(mediaType);
    map['reason'] = Variable<String>(reason);
    map['dismissed_at'] = Variable<DateTime>(dismissedAt);
    return map;
  }

  DismissedSuggestionsCompanion toCompanion(bool nullToAbsent) {
    return DismissedSuggestionsCompanion(
      id: Value(id),
      tmdbId: Value(tmdbId),
      mediaType: Value(mediaType),
      reason: Value(reason),
      dismissedAt: Value(dismissedAt),
    );
  }

  factory DismissedSuggestionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DismissedSuggestionRow(
      id: serializer.fromJson<int>(json['id']),
      tmdbId: serializer.fromJson<int>(json['tmdbId']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      reason: serializer.fromJson<String>(json['reason']),
      dismissedAt: serializer.fromJson<DateTime>(json['dismissedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tmdbId': serializer.toJson<int>(tmdbId),
      'mediaType': serializer.toJson<String>(mediaType),
      'reason': serializer.toJson<String>(reason),
      'dismissedAt': serializer.toJson<DateTime>(dismissedAt),
    };
  }

  DismissedSuggestionRow copyWith({
    int? id,
    int? tmdbId,
    String? mediaType,
    String? reason,
    DateTime? dismissedAt,
  }) => DismissedSuggestionRow(
    id: id ?? this.id,
    tmdbId: tmdbId ?? this.tmdbId,
    mediaType: mediaType ?? this.mediaType,
    reason: reason ?? this.reason,
    dismissedAt: dismissedAt ?? this.dismissedAt,
  );
  DismissedSuggestionRow copyWithCompanion(DismissedSuggestionsCompanion data) {
    return DismissedSuggestionRow(
      id: data.id.present ? data.id.value : this.id,
      tmdbId: data.tmdbId.present ? data.tmdbId.value : this.tmdbId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      reason: data.reason.present ? data.reason.value : this.reason,
      dismissedAt: data.dismissedAt.present
          ? data.dismissedAt.value
          : this.dismissedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DismissedSuggestionRow(')
          ..write('id: $id, ')
          ..write('tmdbId: $tmdbId, ')
          ..write('mediaType: $mediaType, ')
          ..write('reason: $reason, ')
          ..write('dismissedAt: $dismissedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tmdbId, mediaType, reason, dismissedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DismissedSuggestionRow &&
          other.id == this.id &&
          other.tmdbId == this.tmdbId &&
          other.mediaType == this.mediaType &&
          other.reason == this.reason &&
          other.dismissedAt == this.dismissedAt);
}

class DismissedSuggestionsCompanion
    extends UpdateCompanion<DismissedSuggestionRow> {
  final Value<int> id;
  final Value<int> tmdbId;
  final Value<String> mediaType;
  final Value<String> reason;
  final Value<DateTime> dismissedAt;
  const DismissedSuggestionsCompanion({
    this.id = const Value.absent(),
    this.tmdbId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.reason = const Value.absent(),
    this.dismissedAt = const Value.absent(),
  });
  DismissedSuggestionsCompanion.insert({
    this.id = const Value.absent(),
    required int tmdbId,
    required String mediaType,
    required String reason,
    required DateTime dismissedAt,
  }) : tmdbId = Value(tmdbId),
       mediaType = Value(mediaType),
       reason = Value(reason),
       dismissedAt = Value(dismissedAt);
  static Insertable<DismissedSuggestionRow> custom({
    Expression<int>? id,
    Expression<int>? tmdbId,
    Expression<String>? mediaType,
    Expression<String>? reason,
    Expression<DateTime>? dismissedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tmdbId != null) 'tmdb_id': tmdbId,
      if (mediaType != null) 'media_type': mediaType,
      if (reason != null) 'reason': reason,
      if (dismissedAt != null) 'dismissed_at': dismissedAt,
    });
  }

  DismissedSuggestionsCompanion copyWith({
    Value<int>? id,
    Value<int>? tmdbId,
    Value<String>? mediaType,
    Value<String>? reason,
    Value<DateTime>? dismissedAt,
  }) {
    return DismissedSuggestionsCompanion(
      id: id ?? this.id,
      tmdbId: tmdbId ?? this.tmdbId,
      mediaType: mediaType ?? this.mediaType,
      reason: reason ?? this.reason,
      dismissedAt: dismissedAt ?? this.dismissedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tmdbId.present) {
      map['tmdb_id'] = Variable<int>(tmdbId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (dismissedAt.present) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DismissedSuggestionsCompanion(')
          ..write('id: $id, ')
          ..write('tmdbId: $tmdbId, ')
          ..write('mediaType: $mediaType, ')
          ..write('reason: $reason, ')
          ..write('dismissedAt: $dismissedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedEntriesTable extends CachedEntries
    with TableInfo<$CachedEntriesTable, CachedEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [cacheKey, payloadJson, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  CachedEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedEntryRow(
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedEntriesTable createAlias(String alias) {
    return $CachedEntriesTable(attachedDatabase, alias);
  }
}

class CachedEntryRow extends DataClass implements Insertable<CachedEntryRow> {
  final String cacheKey;
  final String payloadJson;
  final DateTime cachedAt;
  const CachedEntryRow({
    required this.cacheKey,
    required this.payloadJson,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['payload_json'] = Variable<String>(payloadJson);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedEntriesCompanion toCompanion(bool nullToAbsent) {
    return CachedEntriesCompanion(
      cacheKey: Value(cacheKey),
      payloadJson: Value(payloadJson),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedEntryRow(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedEntryRow copyWith({
    String? cacheKey,
    String? payloadJson,
    DateTime? cachedAt,
  }) => CachedEntryRow(
    cacheKey: cacheKey ?? this.cacheKey,
    payloadJson: payloadJson ?? this.payloadJson,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedEntryRow copyWithCompanion(CachedEntriesCompanion data) {
    return CachedEntryRow(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedEntryRow(')
          ..write('cacheKey: $cacheKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cacheKey, payloadJson, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedEntryRow &&
          other.cacheKey == this.cacheKey &&
          other.payloadJson == this.payloadJson &&
          other.cachedAt == this.cachedAt);
}

class CachedEntriesCompanion extends UpdateCompanion<CachedEntryRow> {
  final Value<String> cacheKey;
  final Value<String> payloadJson;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedEntriesCompanion({
    this.cacheKey = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedEntriesCompanion.insert({
    required String cacheKey,
    required String payloadJson,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : cacheKey = Value(cacheKey),
       payloadJson = Value(payloadJson),
       cachedAt = Value(cachedAt);
  static Insertable<CachedEntryRow> custom({
    Expression<String>? cacheKey,
    Expression<String>? payloadJson,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedEntriesCompanion copyWith({
    Value<String>? cacheKey,
    Value<String>? payloadJson,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedEntriesCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      payloadJson: payloadJson ?? this.payloadJson,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedEntriesCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MediaItemsTable mediaItems = $MediaItemsTable(this);
  late final $LibraryEntriesTable libraryEntries = $LibraryEntriesTable(this);
  late final $ViewingEventsTable viewingEvents = $ViewingEventsTable(this);
  late final $UserPreferencesTableTable userPreferencesTable =
      $UserPreferencesTableTable(this);
  late final $DismissedSuggestionsTable dismissedSuggestions =
      $DismissedSuggestionsTable(this);
  late final $CachedEntriesTable cachedEntries = $CachedEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mediaItems,
    libraryEntries,
    viewingEvents,
    userPreferencesTable,
    dismissedSuggestions,
    cachedEntries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('library_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'library_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('viewing_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MediaItemsTableCreateCompanionBuilder = MediaItemsCompanion Function({
  Value<int> id,
  required int tmdbId,
  required String mediaType,
  required String title,
  Value<String?> originalTitle,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  Value<String> overview,
  Value<String?> releaseDate,
  Value<int?> runtimeMinutes,
  Value<String> genresJson,
  Value<double> tmdbVoteAverage,
  Value<int?> numberOfSeasons,
  Value<int?> numberOfEpisodes,
  Value<int?> episodeRuntimeMinutes,
  Value<String?> tvStatus,
  Value<bool> isAdult,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$MediaItemsTableUpdateCompanionBuilder = MediaItemsCompanion Function({
  Value<int> id,
  Value<int> tmdbId,
  Value<String> mediaType,
  Value<String> title,
  Value<String?> originalTitle,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  Value<String> overview,
  Value<String?> releaseDate,
  Value<int?> runtimeMinutes,
  Value<String> genresJson,
  Value<double> tmdbVoteAverage,
  Value<int?> numberOfSeasons,
  Value<int?> numberOfEpisodes,
  Value<int?> episodeRuntimeMinutes,
  Value<String?> tvStatus,
  Value<bool> isAdult,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$MediaItemsTableReferences
    extends BaseReferences<_$AppDatabase, $MediaItemsTable, MediaItemRow> {
  $$MediaItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LibraryEntriesTable, List<LibraryEntryRow>>
  _libraryEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.libraryEntries,
    aliasName: 'media_items__id__library_entries__media_item_id',
  );

  $$LibraryEntriesTableProcessedTableManager get libraryEntriesRefs {
    final manager = $$LibraryEntriesTableTableManager(
      $_db,
      $_db.libraryEntries,
    ).filter((f) => f.mediaItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_libraryEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MediaItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tmdbId => $composableBuilder(
    column: $table.tmdbId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runtimeMinutes => $composableBuilder(
    column: $table.runtimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genresJson => $composableBuilder(
    column: $table.genresJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tmdbVoteAverage => $composableBuilder(
    column: $table.tmdbVoteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfSeasons => $composableBuilder(
    column: $table.numberOfSeasons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfEpisodes => $composableBuilder(
    column: $table.numberOfEpisodes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get episodeRuntimeMinutes => $composableBuilder(
    column: $table.episodeRuntimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tvStatus => $composableBuilder(
    column: $table.tvStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdult => $composableBuilder(
    column: $table.isAdult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> libraryEntriesRefs(
    Expression<bool> Function($$LibraryEntriesTableFilterComposer f) f,
  ) {
    final $$LibraryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.libraryEntries,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.libraryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tmdbId => $composableBuilder(
    column: $table.tmdbId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runtimeMinutes => $composableBuilder(
    column: $table.runtimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genresJson => $composableBuilder(
    column: $table.genresJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tmdbVoteAverage => $composableBuilder(
    column: $table.tmdbVoteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfSeasons => $composableBuilder(
    column: $table.numberOfSeasons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfEpisodes => $composableBuilder(
    column: $table.numberOfEpisodes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get episodeRuntimeMinutes => $composableBuilder(
    column: $table.episodeRuntimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tvStatus => $composableBuilder(
    column: $table.tvStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdult => $composableBuilder(
    column: $table.isAdult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MediaItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tmdbId =>
      $composableBuilder(column: $table.tmdbId, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get runtimeMinutes => $composableBuilder(
    column: $table.runtimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genresJson => $composableBuilder(
    column: $table.genresJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tmdbVoteAverage => $composableBuilder(
    column: $table.tmdbVoteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfSeasons => $composableBuilder(
    column: $table.numberOfSeasons,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfEpisodes => $composableBuilder(
    column: $table.numberOfEpisodes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get episodeRuntimeMinutes => $composableBuilder(
    column: $table.episodeRuntimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tvStatus =>
      $composableBuilder(column: $table.tvStatus, builder: (column) => column);

  GeneratedColumn<bool> get isAdult =>
      $composableBuilder(column: $table.isAdult, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> libraryEntriesRefs<T extends Object>(
    Expression<T> Function($$LibraryEntriesTableAnnotationComposer a) f,
  ) {
    final $$LibraryEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.libraryEntries,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.libraryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaItemsTable,
          MediaItemRow,
          $$MediaItemsTableFilterComposer,
          $$MediaItemsTableOrderingComposer,
          $$MediaItemsTableAnnotationComposer,
          $$MediaItemsTableCreateCompanionBuilder,
          $$MediaItemsTableUpdateCompanionBuilder,
          (MediaItemRow, $$MediaItemsTableReferences),
          MediaItemRow,
          PrefetchHooks Function({bool libraryEntriesRefs})
        > {
  $$MediaItemsTableTableManager(_$AppDatabase db, $MediaItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tmdbId = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<int?> runtimeMinutes = const Value.absent(),
                Value<String> genresJson = const Value.absent(),
                Value<double> tmdbVoteAverage = const Value.absent(),
                Value<int?> numberOfSeasons = const Value.absent(),
                Value<int?> numberOfEpisodes = const Value.absent(),
                Value<int?> episodeRuntimeMinutes = const Value.absent(),
                Value<String?> tvStatus = const Value.absent(),
                Value<bool> isAdult = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MediaItemsCompanion(
                id: id,
                tmdbId: tmdbId,
                mediaType: mediaType,
                title: title,
                originalTitle: originalTitle,
                posterPath: posterPath,
                backdropPath: backdropPath,
                overview: overview,
                releaseDate: releaseDate,
                runtimeMinutes: runtimeMinutes,
                genresJson: genresJson,
                tmdbVoteAverage: tmdbVoteAverage,
                numberOfSeasons: numberOfSeasons,
                numberOfEpisodes: numberOfEpisodes,
                episodeRuntimeMinutes: episodeRuntimeMinutes,
                tvStatus: tvStatus,
                isAdult: isAdult,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tmdbId,
                required String mediaType,
                required String title,
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<int?> runtimeMinutes = const Value.absent(),
                Value<String> genresJson = const Value.absent(),
                Value<double> tmdbVoteAverage = const Value.absent(),
                Value<int?> numberOfSeasons = const Value.absent(),
                Value<int?> numberOfEpisodes = const Value.absent(),
                Value<int?> episodeRuntimeMinutes = const Value.absent(),
                Value<String?> tvStatus = const Value.absent(),
                Value<bool> isAdult = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MediaItemsCompanion.insert(
                id: id,
                tmdbId: tmdbId,
                mediaType: mediaType,
                title: title,
                originalTitle: originalTitle,
                posterPath: posterPath,
                backdropPath: backdropPath,
                overview: overview,
                releaseDate: releaseDate,
                runtimeMinutes: runtimeMinutes,
                genresJson: genresJson,
                tmdbVoteAverage: tmdbVoteAverage,
                numberOfSeasons: numberOfSeasons,
                numberOfEpisodes: numberOfEpisodes,
                episodeRuntimeMinutes: episodeRuntimeMinutes,
                tvStatus: tvStatus,
                isAdult: isAdult,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MediaItemsTable, MediaItemRow>(table),
                  $$MediaItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({libraryEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (libraryEntriesRefs) db.libraryEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (libraryEntriesRefs)
                    await $_getPrefetchedDataByColumns<
                      MediaItemRow,
                      $MediaItemsTable,
                      LibraryEntryRow,
                      $LibraryEntriesTable
                    >(
                      currentTable: table,
                      referencedTable: $$MediaItemsTableReferences
                          ._libraryEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MediaItemsTableReferences(
                            db,
                            table,
                            p0,
                          ).libraryEntriesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'media_item_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MediaItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaItemsTable,
      MediaItemRow,
      $$MediaItemsTableFilterComposer,
      $$MediaItemsTableOrderingComposer,
      $$MediaItemsTableAnnotationComposer,
      $$MediaItemsTableCreateCompanionBuilder,
      $$MediaItemsTableUpdateCompanionBuilder,
      (MediaItemRow, $$MediaItemsTableReferences),
      MediaItemRow,
      PrefetchHooks Function({bool libraryEntriesRefs})
    >;
typedef $$LibraryEntriesTableCreateCompanionBuilder =
    LibraryEntriesCompanion Function({
      Value<int> id,
      required int mediaItemId,
      required String status,
      Value<int?> personalRating,
      Value<String?> personalNote,
      Value<String> tagsJson,
      Value<int?> currentSeason,
      Value<int?> currentEpisode,
      required DateTime lastActivityAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LibraryEntriesTableUpdateCompanionBuilder =
    LibraryEntriesCompanion Function({
      Value<int> id,
      Value<int> mediaItemId,
      Value<String> status,
      Value<int?> personalRating,
      Value<String?> personalNote,
      Value<String> tagsJson,
      Value<int?> currentSeason,
      Value<int?> currentEpisode,
      Value<DateTime> lastActivityAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$LibraryEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $LibraryEntriesTable, LibraryEntryRow> {
  $$LibraryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MediaItemsTable _mediaItemIdTable(_$AppDatabase db) => db.mediaItems
      .createAlias('library_entries__media_item_id__media_items__id');

  $$MediaItemsTableProcessedTableManager get mediaItemId {
    final $_column = $_itemColumn<int>('media_item_id')!;

    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ViewingEventsTable, List<ViewingEventRow>>
  _viewingEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.viewingEvents,
    aliasName: 'library_entries__id__viewing_events__library_entry_id',
  );

  $$ViewingEventsTableProcessedTableManager get viewingEventsRefs {
    final manager = $$ViewingEventsTableTableManager(
      $_db,
      $_db.viewingEvents,
    ).filter((f) => f.libraryEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_viewingEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LibraryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LibraryEntriesTable> {
  $$LibraryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get personalRating => $composableBuilder(
    column: $table.personalRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentSeason => $composableBuilder(
    column: $table.currentSeason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentEpisode => $composableBuilder(
    column: $table.currentEpisode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActivityAt => $composableBuilder(
    column: $table.lastActivityAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaItemsTableFilterComposer get mediaItemId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> viewingEventsRefs(
    Expression<bool> Function($$ViewingEventsTableFilterComposer f) f,
  ) {
    final $$ViewingEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.viewingEvents,
      getReferencedColumn: (t) => t.libraryEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViewingEventsTableFilterComposer(
            $db: $db,
            $table: $db.viewingEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LibraryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LibraryEntriesTable> {
  $$LibraryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get personalRating => $composableBuilder(
    column: $table.personalRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentSeason => $composableBuilder(
    column: $table.currentSeason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentEpisode => $composableBuilder(
    column: $table.currentEpisode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActivityAt => $composableBuilder(
    column: $table.lastActivityAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaItemsTableOrderingComposer get mediaItemId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LibraryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LibraryEntriesTable> {
  $$LibraryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get personalRating => $composableBuilder(
    column: $table.personalRating,
    builder: (column) => column,
  );

  GeneratedColumn<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<int> get currentSeason => $composableBuilder(
    column: $table.currentSeason,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentEpisode => $composableBuilder(
    column: $table.currentEpisode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActivityAt => $composableBuilder(
    column: $table.lastActivityAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MediaItemsTableAnnotationComposer get mediaItemId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> viewingEventsRefs<T extends Object>(
    Expression<T> Function($$ViewingEventsTableAnnotationComposer a) f,
  ) {
    final $$ViewingEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.viewingEvents,
      getReferencedColumn: (t) => t.libraryEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViewingEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.viewingEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LibraryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LibraryEntriesTable,
          LibraryEntryRow,
          $$LibraryEntriesTableFilterComposer,
          $$LibraryEntriesTableOrderingComposer,
          $$LibraryEntriesTableAnnotationComposer,
          $$LibraryEntriesTableCreateCompanionBuilder,
          $$LibraryEntriesTableUpdateCompanionBuilder,
          (LibraryEntryRow, $$LibraryEntriesTableReferences),
          LibraryEntryRow,
          PrefetchHooks Function({bool mediaItemId, bool viewingEventsRefs})
        > {
  $$LibraryEntriesTableTableManager(
    _$AppDatabase db,
    $LibraryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mediaItemId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> personalRating = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<int?> currentSeason = const Value.absent(),
                Value<int?> currentEpisode = const Value.absent(),
                Value<DateTime> lastActivityAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LibraryEntriesCompanion(
                id: id,
                mediaItemId: mediaItemId,
                status: status,
                personalRating: personalRating,
                personalNote: personalNote,
                tagsJson: tagsJson,
                currentSeason: currentSeason,
                currentEpisode: currentEpisode,
                lastActivityAt: lastActivityAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mediaItemId,
                required String status,
                Value<int?> personalRating = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<int?> currentSeason = const Value.absent(),
                Value<int?> currentEpisode = const Value.absent(),
                required DateTime lastActivityAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LibraryEntriesCompanion.insert(
                id: id,
                mediaItemId: mediaItemId,
                status: status,
                personalRating: personalRating,
                personalNote: personalNote,
                tagsJson: tagsJson,
                currentSeason: currentSeason,
                currentEpisode: currentEpisode,
                lastActivityAt: lastActivityAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LibraryEntriesTable, LibraryEntryRow>(table),
                  $$LibraryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mediaItemId = false, viewingEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (viewingEventsRefs) db.viewingEvents,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mediaItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mediaItemId,
                            referencedTable: $$LibraryEntriesTableReferences
                                ._mediaItemIdTable(db),
                            referencedColumn: $$LibraryEntriesTableReferences
                                ._mediaItemIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (viewingEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          LibraryEntryRow,
                          $LibraryEntriesTable,
                          ViewingEventRow,
                          $ViewingEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$LibraryEntriesTableReferences
                              ._viewingEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LibraryEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).viewingEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'library_entry_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LibraryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LibraryEntriesTable,
      LibraryEntryRow,
      $$LibraryEntriesTableFilterComposer,
      $$LibraryEntriesTableOrderingComposer,
      $$LibraryEntriesTableAnnotationComposer,
      $$LibraryEntriesTableCreateCompanionBuilder,
      $$LibraryEntriesTableUpdateCompanionBuilder,
      (LibraryEntryRow, $$LibraryEntriesTableReferences),
      LibraryEntryRow,
      PrefetchHooks Function({bool mediaItemId, bool viewingEventsRefs})
    >;
typedef $$ViewingEventsTableCreateCompanionBuilder =
    ViewingEventsCompanion Function({
      Value<int> id,
      required int libraryEntryId,
      required String eventType,
      Value<int?> season,
      Value<int?> episode,
      required DateTime occurredAt,
      Value<String?> note,
    });
typedef $$ViewingEventsTableUpdateCompanionBuilder =
    ViewingEventsCompanion Function({
      Value<int> id,
      Value<int> libraryEntryId,
      Value<String> eventType,
      Value<int?> season,
      Value<int?> episode,
      Value<DateTime> occurredAt,
      Value<String?> note,
    });

final class $$ViewingEventsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ViewingEventsTable, ViewingEventRow> {
  $$ViewingEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LibraryEntriesTable _libraryEntryIdTable(_$AppDatabase db) => db
      .libraryEntries
      .createAlias('viewing_events__library_entry_id__library_entries__id');

  $$LibraryEntriesTableProcessedTableManager get libraryEntryId {
    final $_column = $_itemColumn<int>('library_entry_id')!;

    final manager = $$LibraryEntriesTableTableManager(
      $_db,
      $_db.libraryEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_libraryEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ViewingEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ViewingEventsTable> {
  $$ViewingEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get episode => $composableBuilder(
    column: $table.episode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$LibraryEntriesTableFilterComposer get libraryEntryId {
    final $$LibraryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.libraryEntryId,
      referencedTable: $db.libraryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.libraryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ViewingEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ViewingEventsTable> {
  $$ViewingEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get episode => $composableBuilder(
    column: $table.episode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$LibraryEntriesTableOrderingComposer get libraryEntryId {
    final $$LibraryEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.libraryEntryId,
      referencedTable: $db.libraryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.libraryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ViewingEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViewingEventsTable> {
  $$ViewingEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get episode =>
      $composableBuilder(column: $table.episode, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$LibraryEntriesTableAnnotationComposer get libraryEntryId {
    final $$LibraryEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.libraryEntryId,
      referencedTable: $db.libraryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.libraryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ViewingEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ViewingEventsTable,
          ViewingEventRow,
          $$ViewingEventsTableFilterComposer,
          $$ViewingEventsTableOrderingComposer,
          $$ViewingEventsTableAnnotationComposer,
          $$ViewingEventsTableCreateCompanionBuilder,
          $$ViewingEventsTableUpdateCompanionBuilder,
          (ViewingEventRow, $$ViewingEventsTableReferences),
          ViewingEventRow,
          PrefetchHooks Function({bool libraryEntryId})
        > {
  $$ViewingEventsTableTableManager(_$AppDatabase db, $ViewingEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViewingEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViewingEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViewingEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> libraryEntryId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int?> season = const Value.absent(),
                Value<int?> episode = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => ViewingEventsCompanion(
                id: id,
                libraryEntryId: libraryEntryId,
                eventType: eventType,
                season: season,
                episode: episode,
                occurredAt: occurredAt,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int libraryEntryId,
                required String eventType,
                Value<int?> season = const Value.absent(),
                Value<int?> episode = const Value.absent(),
                required DateTime occurredAt,
                Value<String?> note = const Value.absent(),
              }) => ViewingEventsCompanion.insert(
                id: id,
                libraryEntryId: libraryEntryId,
                eventType: eventType,
                season: season,
                episode: episode,
                occurredAt: occurredAt,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ViewingEventsTable, ViewingEventRow>(table),
                  $$ViewingEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({libraryEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (libraryEntryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.libraryEntryId,
                        referencedTable: $$ViewingEventsTableReferences
                            ._libraryEntryIdTable(db),
                        referencedColumn: $$ViewingEventsTableReferences
                            ._libraryEntryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ViewingEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ViewingEventsTable,
      ViewingEventRow,
      $$ViewingEventsTableFilterComposer,
      $$ViewingEventsTableOrderingComposer,
      $$ViewingEventsTableAnnotationComposer,
      $$ViewingEventsTableCreateCompanionBuilder,
      $$ViewingEventsTableUpdateCompanionBuilder,
      (ViewingEventRow, $$ViewingEventsTableReferences),
      ViewingEventRow,
      PrefetchHooks Function({bool libraryEntryId})
    >;
typedef $$UserPreferencesTableTableCreateCompanionBuilder =
    UserPreferencesTableCompanion Function({
      Value<int> id,
      Value<String> streamingServicesJson,
      Value<String> preferredGenresJson,
      Value<String> avoidedGenresJson,
      Value<int> preferredRuntimeMinutes,
      Value<String> hardExclusionsJson,
      Value<String> themeMode,
      Value<bool> onboardingCompleted,
    });
typedef $$UserPreferencesTableTableUpdateCompanionBuilder =
    UserPreferencesTableCompanion Function({
      Value<int> id,
      Value<String> streamingServicesJson,
      Value<String> preferredGenresJson,
      Value<String> avoidedGenresJson,
      Value<int> preferredRuntimeMinutes,
      Value<String> hardExclusionsJson,
      Value<String> themeMode,
      Value<bool> onboardingCompleted,
    });

class $$UserPreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get streamingServicesJson => $composableBuilder(
    column: $table.streamingServicesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredGenresJson => $composableBuilder(
    column: $table.preferredGenresJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avoidedGenresJson => $composableBuilder(
    column: $table.avoidedGenresJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferredRuntimeMinutes => $composableBuilder(
    column: $table.preferredRuntimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hardExclusionsJson => $composableBuilder(
    column: $table.hardExclusionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get streamingServicesJson => $composableBuilder(
    column: $table.streamingServicesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredGenresJson => $composableBuilder(
    column: $table.preferredGenresJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avoidedGenresJson => $composableBuilder(
    column: $table.avoidedGenresJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferredRuntimeMinutes => $composableBuilder(
    column: $table.preferredRuntimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hardExclusionsJson => $composableBuilder(
    column: $table.hardExclusionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get streamingServicesJson => $composableBuilder(
    column: $table.streamingServicesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredGenresJson => $composableBuilder(
    column: $table.preferredGenresJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avoidedGenresJson => $composableBuilder(
    column: $table.avoidedGenresJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preferredRuntimeMinutes => $composableBuilder(
    column: $table.preferredRuntimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hardExclusionsJson => $composableBuilder(
    column: $table.hardExclusionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );
}

class $$UserPreferencesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTableTable,
          UserPreferenceRow,
          $$UserPreferencesTableTableFilterComposer,
          $$UserPreferencesTableTableOrderingComposer,
          $$UserPreferencesTableTableAnnotationComposer,
          $$UserPreferencesTableTableCreateCompanionBuilder,
          $$UserPreferencesTableTableUpdateCompanionBuilder,
          (
            UserPreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTableTable,
              UserPreferenceRow
            >,
          ),
          UserPreferenceRow,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> streamingServicesJson = const Value.absent(),
                Value<String> preferredGenresJson = const Value.absent(),
                Value<String> avoidedGenresJson = const Value.absent(),
                Value<int> preferredRuntimeMinutes = const Value.absent(),
                Value<String> hardExclusionsJson = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
              }) => UserPreferencesTableCompanion(
                id: id,
                streamingServicesJson: streamingServicesJson,
                preferredGenresJson: preferredGenresJson,
                avoidedGenresJson: avoidedGenresJson,
                preferredRuntimeMinutes: preferredRuntimeMinutes,
                hardExclusionsJson: hardExclusionsJson,
                themeMode: themeMode,
                onboardingCompleted: onboardingCompleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> streamingServicesJson = const Value.absent(),
                Value<String> preferredGenresJson = const Value.absent(),
                Value<String> avoidedGenresJson = const Value.absent(),
                Value<int> preferredRuntimeMinutes = const Value.absent(),
                Value<String> hardExclusionsJson = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
              }) => UserPreferencesTableCompanion.insert(
                id: id,
                streamingServicesJson: streamingServicesJson,
                preferredGenresJson: preferredGenresJson,
                avoidedGenresJson: avoidedGenresJson,
                preferredRuntimeMinutes: preferredRuntimeMinutes,
                hardExclusionsJson: hardExclusionsJson,
                themeMode: themeMode,
                onboardingCompleted: onboardingCompleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserPreferencesTableTable, UserPreferenceRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $UserPreferencesTableTable,
                    UserPreferenceRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTableTable,
      UserPreferenceRow,
      $$UserPreferencesTableTableFilterComposer,
      $$UserPreferencesTableTableOrderingComposer,
      $$UserPreferencesTableTableAnnotationComposer,
      $$UserPreferencesTableTableCreateCompanionBuilder,
      $$UserPreferencesTableTableUpdateCompanionBuilder,
      (
        UserPreferenceRow,
        BaseReferences<
          _$AppDatabase,
          $UserPreferencesTableTable,
          UserPreferenceRow
        >,
      ),
      UserPreferenceRow,
      PrefetchHooks Function()
    >;
typedef $$DismissedSuggestionsTableCreateCompanionBuilder =
    DismissedSuggestionsCompanion Function({
      Value<int> id,
      required int tmdbId,
      required String mediaType,
      required String reason,
      required DateTime dismissedAt,
    });
typedef $$DismissedSuggestionsTableUpdateCompanionBuilder =
    DismissedSuggestionsCompanion Function({
      Value<int> id,
      Value<int> tmdbId,
      Value<String> mediaType,
      Value<String> reason,
      Value<DateTime> dismissedAt,
    });

class $$DismissedSuggestionsTableFilterComposer
    extends Composer<_$AppDatabase, $DismissedSuggestionsTable> {
  $$DismissedSuggestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tmdbId => $composableBuilder(
    column: $table.tmdbId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DismissedSuggestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DismissedSuggestionsTable> {
  $$DismissedSuggestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tmdbId => $composableBuilder(
    column: $table.tmdbId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DismissedSuggestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DismissedSuggestionsTable> {
  $$DismissedSuggestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tmdbId =>
      $composableBuilder(column: $table.tmdbId, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => column,
  );
}

class $$DismissedSuggestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DismissedSuggestionsTable,
          DismissedSuggestionRow,
          $$DismissedSuggestionsTableFilterComposer,
          $$DismissedSuggestionsTableOrderingComposer,
          $$DismissedSuggestionsTableAnnotationComposer,
          $$DismissedSuggestionsTableCreateCompanionBuilder,
          $$DismissedSuggestionsTableUpdateCompanionBuilder,
          (
            DismissedSuggestionRow,
            BaseReferences<
              _$AppDatabase,
              $DismissedSuggestionsTable,
              DismissedSuggestionRow
            >,
          ),
          DismissedSuggestionRow,
          PrefetchHooks Function()
        > {
  $$DismissedSuggestionsTableTableManager(
    _$AppDatabase db,
    $DismissedSuggestionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DismissedSuggestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DismissedSuggestionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DismissedSuggestionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tmdbId = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<DateTime> dismissedAt = const Value.absent(),
              }) => DismissedSuggestionsCompanion(
                id: id,
                tmdbId: tmdbId,
                mediaType: mediaType,
                reason: reason,
                dismissedAt: dismissedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tmdbId,
                required String mediaType,
                required String reason,
                required DateTime dismissedAt,
              }) => DismissedSuggestionsCompanion.insert(
                id: id,
                tmdbId: tmdbId,
                mediaType: mediaType,
                reason: reason,
                dismissedAt: dismissedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $DismissedSuggestionsTable,
                    DismissedSuggestionRow
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DismissedSuggestionsTable,
                    DismissedSuggestionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DismissedSuggestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DismissedSuggestionsTable,
      DismissedSuggestionRow,
      $$DismissedSuggestionsTableFilterComposer,
      $$DismissedSuggestionsTableOrderingComposer,
      $$DismissedSuggestionsTableAnnotationComposer,
      $$DismissedSuggestionsTableCreateCompanionBuilder,
      $$DismissedSuggestionsTableUpdateCompanionBuilder,
      (
        DismissedSuggestionRow,
        BaseReferences<
          _$AppDatabase,
          $DismissedSuggestionsTable,
          DismissedSuggestionRow
        >,
      ),
      DismissedSuggestionRow,
      PrefetchHooks Function()
    >;
typedef $$CachedEntriesTableCreateCompanionBuilder =
    CachedEntriesCompanion Function({
      required String cacheKey,
      required String payloadJson,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedEntriesTableUpdateCompanionBuilder =
    CachedEntriesCompanion Function({
      Value<String> cacheKey,
      Value<String> payloadJson,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$CachedEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedEntriesTable> {
  $$CachedEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedEntriesTable> {
  $$CachedEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedEntriesTable> {
  $$CachedEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedEntriesTable,
          CachedEntryRow,
          $$CachedEntriesTableFilterComposer,
          $$CachedEntriesTableOrderingComposer,
          $$CachedEntriesTableAnnotationComposer,
          $$CachedEntriesTableCreateCompanionBuilder,
          $$CachedEntriesTableUpdateCompanionBuilder,
          (
            CachedEntryRow,
            BaseReferences<_$AppDatabase, $CachedEntriesTable, CachedEntryRow>,
          ),
          CachedEntryRow,
          PrefetchHooks Function()
        > {
  $$CachedEntriesTableTableManager(_$AppDatabase db, $CachedEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> cacheKey = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedEntriesCompanion(
                cacheKey: cacheKey,
                payloadJson: payloadJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String cacheKey,
                required String payloadJson,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedEntriesCompanion.insert(
                cacheKey: cacheKey,
                payloadJson: payloadJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedEntriesTable, CachedEntryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedEntriesTable,
                    CachedEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedEntriesTable,
      CachedEntryRow,
      $$CachedEntriesTableFilterComposer,
      $$CachedEntriesTableOrderingComposer,
      $$CachedEntriesTableAnnotationComposer,
      $$CachedEntriesTableCreateCompanionBuilder,
      $$CachedEntriesTableUpdateCompanionBuilder,
      (
        CachedEntryRow,
        BaseReferences<_$AppDatabase, $CachedEntriesTable, CachedEntryRow>,
      ),
      CachedEntryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db, _db.mediaItems);
  $$LibraryEntriesTableTableManager get libraryEntries =>
      $$LibraryEntriesTableTableManager(_db, _db.libraryEntries);
  $$ViewingEventsTableTableManager get viewingEvents =>
      $$ViewingEventsTableTableManager(_db, _db.viewingEvents);
  $$UserPreferencesTableTableTableManager get userPreferencesTable =>
      $$UserPreferencesTableTableTableManager(_db, _db.userPreferencesTable);
  $$DismissedSuggestionsTableTableManager get dismissedSuggestions =>
      $$DismissedSuggestionsTableTableManager(_db, _db.dismissedSuggestions);
  $$CachedEntriesTableTableManager get cachedEntries =>
      $$CachedEntriesTableTableManager(_db, _db.cachedEntries);
}
