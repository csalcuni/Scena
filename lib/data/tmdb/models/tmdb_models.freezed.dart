// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TmdbGenreDto {

 int get id; String get name;
/// Create a copy of TmdbGenreDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbGenreDtoCopyWith<TmdbGenreDto> get copyWith => _$TmdbGenreDtoCopyWithImpl<TmdbGenreDto>(this as TmdbGenreDto, _$identity);

  /// Serializes this TmdbGenreDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbGenreDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbGenreDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbGenreDto;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as TmdbGenreDto;
  return 'TmdbGenreDto(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $TmdbGenreDtoCopyWith<$Res>  {
  factory $TmdbGenreDtoCopyWith(TmdbGenreDto value, $Res Function(TmdbGenreDto) _then) = _$TmdbGenreDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$TmdbGenreDtoCopyWithImpl<$Res>
    implements $TmdbGenreDtoCopyWith<$Res> {
  _$TmdbGenreDtoCopyWithImpl(this._self, this._then);

  final TmdbGenreDto _self;
  final $Res Function(TmdbGenreDto) _then;

/// Create a copy of TmdbGenreDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(TmdbGenreDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbGenreDto].
extension TmdbGenreDtoPatterns on TmdbGenreDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbGenreDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbGenreDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbGenreDto value)  $default,){
final _that = this;
switch (_that) {
case _TmdbGenreDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbGenreDto value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbGenreDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbGenreDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _TmdbGenreDto():
return $default(_that.id,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _TmdbGenreDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbGenreDto implements TmdbGenreDto {
  const _TmdbGenreDto({required this.id, this.name = ''});
  factory _TmdbGenreDto.fromJson(Map<String, dynamic> json) => _$TmdbGenreDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;

/// Create a copy of TmdbGenreDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbGenreDtoCopyWith<_TmdbGenreDto> get copyWith => __$TmdbGenreDtoCopyWithImpl<_TmdbGenreDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbGenreDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbGenreDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'TmdbGenreDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TmdbGenreDtoCopyWith<$Res> implements $TmdbGenreDtoCopyWith<$Res> {
  factory _$TmdbGenreDtoCopyWith(_TmdbGenreDto value, $Res Function(_TmdbGenreDto) _then) = __$TmdbGenreDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$TmdbGenreDtoCopyWithImpl<$Res>
    implements _$TmdbGenreDtoCopyWith<$Res> {
  __$TmdbGenreDtoCopyWithImpl(this._self, this._then);

  final _TmdbGenreDto _self;
  final $Res Function(_TmdbGenreDto) _then;

/// Create a copy of TmdbGenreDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_TmdbGenreDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TmdbGenreResponse {

 List<TmdbGenreDto> get genres;
/// Create a copy of TmdbGenreResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbGenreResponseCopyWith<TmdbGenreResponse> get copyWith => _$TmdbGenreResponseCopyWithImpl<TmdbGenreResponse>(this as TmdbGenreResponse, _$identity);

  /// Serializes this TmdbGenreResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbGenreResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbGenreResponse&&const DeepCollectionEquality().equals(other.genres, _this.genres));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbGenreResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.genres));
}

@override
String toString() {
  final _this = this as TmdbGenreResponse;
  return 'TmdbGenreResponse(genres: ${_this.genres})';
}


}

/// @nodoc
abstract mixin class $TmdbGenreResponseCopyWith<$Res>  {
  factory $TmdbGenreResponseCopyWith(TmdbGenreResponse value, $Res Function(TmdbGenreResponse) _then) = _$TmdbGenreResponseCopyWithImpl;
@useResult
$Res call({
 List<TmdbGenreDto> genres
});




}
/// @nodoc
class _$TmdbGenreResponseCopyWithImpl<$Res>
    implements $TmdbGenreResponseCopyWith<$Res> {
  _$TmdbGenreResponseCopyWithImpl(this._self, this._then);

  final TmdbGenreResponse _self;
  final $Res Function(TmdbGenreResponse) _then;

/// Create a copy of TmdbGenreResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? genres = null,}) {
  return _then(TmdbGenreResponse(
genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<TmdbGenreDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbGenreResponse].
extension TmdbGenreResponsePatterns on TmdbGenreResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbGenreResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbGenreResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbGenreResponse value)  $default,){
final _that = this;
switch (_that) {
case _TmdbGenreResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbGenreResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbGenreResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TmdbGenreDto> genres)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbGenreResponse() when $default != null:
return $default(_that.genres);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TmdbGenreDto> genres)  $default,) {final _that = this;
switch (_that) {
case _TmdbGenreResponse():
return $default(_that.genres);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TmdbGenreDto> genres)?  $default,) {final _that = this;
switch (_that) {
case _TmdbGenreResponse() when $default != null:
return $default(_that.genres);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbGenreResponse implements TmdbGenreResponse {
  const _TmdbGenreResponse({ List<TmdbGenreDto> genres = const <TmdbGenreDto>[]}): _genres = genres;
  factory _TmdbGenreResponse.fromJson(Map<String, dynamic> json) => _$TmdbGenreResponseFromJson(json);

 final  List<TmdbGenreDto> _genres;
@override@JsonKey() List<TmdbGenreDto> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}


/// Create a copy of TmdbGenreResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbGenreResponseCopyWith<_TmdbGenreResponse> get copyWith => __$TmdbGenreResponseCopyWithImpl<_TmdbGenreResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbGenreResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbGenreResponse&&const DeepCollectionEquality().equals(other.genres, _genres));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_genres));
}

@override
String toString() {
    return 'TmdbGenreResponse(genres: $genres)';
}


}

/// @nodoc
abstract mixin class _$TmdbGenreResponseCopyWith<$Res> implements $TmdbGenreResponseCopyWith<$Res> {
  factory _$TmdbGenreResponseCopyWith(_TmdbGenreResponse value, $Res Function(_TmdbGenreResponse) _then) = __$TmdbGenreResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TmdbGenreDto> genres
});




}
/// @nodoc
class __$TmdbGenreResponseCopyWithImpl<$Res>
    implements _$TmdbGenreResponseCopyWith<$Res> {
  __$TmdbGenreResponseCopyWithImpl(this._self, this._then);

  final _TmdbGenreResponse _self;
  final $Res Function(_TmdbGenreResponse) _then;

/// Create a copy of TmdbGenreResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? genres = null,}) {
  return _then(_TmdbGenreResponse(
genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<TmdbGenreDto>,
  ));
}


}


/// @nodoc
mixin _$TmdbMovieSummary {

 bool get adult;@JsonKey(name: 'backdrop_path') String? get backdropPath;@JsonKey(name: 'genre_ids') List<int> get genreIds; int get id;@JsonKey(name: 'original_title') String get originalTitle; String get overview;@JsonKey(name: 'poster_path') String? get posterPath;@JsonKey(name: 'release_date') String get releaseDate; String get title;@JsonKey(name: 'vote_average') double get voteAverage;
/// Create a copy of TmdbMovieSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbMovieSummaryCopyWith<TmdbMovieSummary> get copyWith => _$TmdbMovieSummaryCopyWithImpl<TmdbMovieSummary>(this as TmdbMovieSummary, _$identity);

  /// Serializes this TmdbMovieSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbMovieSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbMovieSummary&&(identical(other.adult, _this.adult) || other.adult == _this.adult)&&(identical(other.backdropPath, _this.backdropPath) || other.backdropPath == _this.backdropPath)&&const DeepCollectionEquality().equals(other.genreIds, _this.genreIds)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.originalTitle, _this.originalTitle) || other.originalTitle == _this.originalTitle)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.posterPath, _this.posterPath) || other.posterPath == _this.posterPath)&&(identical(other.releaseDate, _this.releaseDate) || other.releaseDate == _this.releaseDate)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.voteAverage, _this.voteAverage) || other.voteAverage == _this.voteAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbMovieSummary;
  return Object.hash(runtimeType,_this.adult,_this.backdropPath,const DeepCollectionEquality().hash(_this.genreIds),_this.id,_this.originalTitle,_this.overview,_this.posterPath,_this.releaseDate,_this.title,_this.voteAverage);
}

@override
String toString() {
  final _this = this as TmdbMovieSummary;
  return 'TmdbMovieSummary(adult: ${_this.adult}, backdropPath: ${_this.backdropPath}, genreIds: ${_this.genreIds}, id: ${_this.id}, originalTitle: ${_this.originalTitle}, overview: ${_this.overview}, posterPath: ${_this.posterPath}, releaseDate: ${_this.releaseDate}, title: ${_this.title}, voteAverage: ${_this.voteAverage})';
}


}

/// @nodoc
abstract mixin class $TmdbMovieSummaryCopyWith<$Res>  {
  factory $TmdbMovieSummaryCopyWith(TmdbMovieSummary value, $Res Function(TmdbMovieSummary) _then) = _$TmdbMovieSummaryCopyWithImpl;
@useResult
$Res call({
 bool adult,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'genre_ids') List<int> genreIds, int id,@JsonKey(name: 'original_title') String originalTitle, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'release_date') String releaseDate, String title,@JsonKey(name: 'vote_average') double voteAverage
});




}
/// @nodoc
class _$TmdbMovieSummaryCopyWithImpl<$Res>
    implements $TmdbMovieSummaryCopyWith<$Res> {
  _$TmdbMovieSummaryCopyWithImpl(this._self, this._then);

  final TmdbMovieSummary _self;
  final $Res Function(TmdbMovieSummary) _then;

/// Create a copy of TmdbMovieSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? adult = null,Object? backdropPath = freezed,Object? genreIds = null,Object? id = null,Object? originalTitle = null,Object? overview = null,Object? posterPath = freezed,Object? releaseDate = null,Object? title = null,Object? voteAverage = null,}) {
  return _then(TmdbMovieSummary(
adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,genreIds: null == genreIds ? _self.genreIds : genreIds // ignore: cast_nullable_to_non_nullable
as List<int>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: null == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbMovieSummary].
extension TmdbMovieSummaryPatterns on TmdbMovieSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbMovieSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbMovieSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbMovieSummary value)  $default,){
final _that = this;
switch (_that) {
case _TmdbMovieSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbMovieSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbMovieSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool adult, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'genre_ids')  List<int> genreIds,  int id, @JsonKey(name: 'original_title')  String originalTitle,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'release_date')  String releaseDate,  String title, @JsonKey(name: 'vote_average')  double voteAverage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbMovieSummary() when $default != null:
return $default(_that.adult,_that.backdropPath,_that.genreIds,_that.id,_that.originalTitle,_that.overview,_that.posterPath,_that.releaseDate,_that.title,_that.voteAverage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool adult, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'genre_ids')  List<int> genreIds,  int id, @JsonKey(name: 'original_title')  String originalTitle,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'release_date')  String releaseDate,  String title, @JsonKey(name: 'vote_average')  double voteAverage)  $default,) {final _that = this;
switch (_that) {
case _TmdbMovieSummary():
return $default(_that.adult,_that.backdropPath,_that.genreIds,_that.id,_that.originalTitle,_that.overview,_that.posterPath,_that.releaseDate,_that.title,_that.voteAverage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool adult, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'genre_ids')  List<int> genreIds,  int id, @JsonKey(name: 'original_title')  String originalTitle,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'release_date')  String releaseDate,  String title, @JsonKey(name: 'vote_average')  double voteAverage)?  $default,) {final _that = this;
switch (_that) {
case _TmdbMovieSummary() when $default != null:
return $default(_that.adult,_that.backdropPath,_that.genreIds,_that.id,_that.originalTitle,_that.overview,_that.posterPath,_that.releaseDate,_that.title,_that.voteAverage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbMovieSummary implements TmdbMovieSummary {
  const _TmdbMovieSummary({this.adult = false, @JsonKey(name: 'backdrop_path') this.backdropPath, @JsonKey(name: 'genre_ids')  List<int> genreIds = const <int>[], required this.id, @JsonKey(name: 'original_title') this.originalTitle = '', this.overview = '', @JsonKey(name: 'poster_path') this.posterPath, @JsonKey(name: 'release_date') this.releaseDate = '', this.title = '', @JsonKey(name: 'vote_average') this.voteAverage = 0}): _genreIds = genreIds;
  factory _TmdbMovieSummary.fromJson(Map<String, dynamic> json) => _$TmdbMovieSummaryFromJson(json);

@override@JsonKey() final  bool adult;
@override@JsonKey(name: 'backdrop_path') final  String? backdropPath;
 final  List<int> _genreIds;
@override@JsonKey(name: 'genre_ids') List<int> get genreIds {
  if (_genreIds is EqualUnmodifiableListView) return _genreIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genreIds);
}

@override final  int id;
@override@JsonKey(name: 'original_title') final  String originalTitle;
@override@JsonKey() final  String overview;
@override@JsonKey(name: 'poster_path') final  String? posterPath;
@override@JsonKey(name: 'release_date') final  String releaseDate;
@override@JsonKey() final  String title;
@override@JsonKey(name: 'vote_average') final  double voteAverage;

/// Create a copy of TmdbMovieSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbMovieSummaryCopyWith<_TmdbMovieSummary> get copyWith => __$TmdbMovieSummaryCopyWithImpl<_TmdbMovieSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbMovieSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbMovieSummary&&(identical(other.adult, adult) || other.adult == adult)&&(identical(other.backdropPath, backdropPath) || other.backdropPath == backdropPath)&&const DeepCollectionEquality().equals(other.genreIds, _genreIds)&&(identical(other.id, id) || other.id == id)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterPath, posterPath) || other.posterPath == posterPath)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.voteAverage, voteAverage) || other.voteAverage == voteAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,adult,backdropPath,const DeepCollectionEquality().hash(_genreIds),id,originalTitle,overview,posterPath,releaseDate,title,voteAverage);
}

@override
String toString() {
    return 'TmdbMovieSummary(adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, voteAverage: $voteAverage)';
}


}

/// @nodoc
abstract mixin class _$TmdbMovieSummaryCopyWith<$Res> implements $TmdbMovieSummaryCopyWith<$Res> {
  factory _$TmdbMovieSummaryCopyWith(_TmdbMovieSummary value, $Res Function(_TmdbMovieSummary) _then) = __$TmdbMovieSummaryCopyWithImpl;
@override @useResult
$Res call({
 bool adult,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'genre_ids') List<int> genreIds, int id,@JsonKey(name: 'original_title') String originalTitle, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'release_date') String releaseDate, String title,@JsonKey(name: 'vote_average') double voteAverage
});




}
/// @nodoc
class __$TmdbMovieSummaryCopyWithImpl<$Res>
    implements _$TmdbMovieSummaryCopyWith<$Res> {
  __$TmdbMovieSummaryCopyWithImpl(this._self, this._then);

  final _TmdbMovieSummary _self;
  final $Res Function(_TmdbMovieSummary) _then;

/// Create a copy of TmdbMovieSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? adult = null,Object? backdropPath = freezed,Object? genreIds = null,Object? id = null,Object? originalTitle = null,Object? overview = null,Object? posterPath = freezed,Object? releaseDate = null,Object? title = null,Object? voteAverage = null,}) {
  return _then(_TmdbMovieSummary(
adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,genreIds: null == genreIds ? _self._genreIds : genreIds // ignore: cast_nullable_to_non_nullable
as List<int>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: null == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TmdbTvSummary {

 bool get adult;@JsonKey(name: 'backdrop_path') String? get backdropPath;@JsonKey(name: 'first_air_date') String get firstAirDate;@JsonKey(name: 'genre_ids') List<int> get genreIds; int get id; String get name;@JsonKey(name: 'original_name') String get originalName; String get overview;@JsonKey(name: 'poster_path') String? get posterPath;@JsonKey(name: 'vote_average') double get voteAverage;
/// Create a copy of TmdbTvSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbTvSummaryCopyWith<TmdbTvSummary> get copyWith => _$TmdbTvSummaryCopyWithImpl<TmdbTvSummary>(this as TmdbTvSummary, _$identity);

  /// Serializes this TmdbTvSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbTvSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbTvSummary&&(identical(other.adult, _this.adult) || other.adult == _this.adult)&&(identical(other.backdropPath, _this.backdropPath) || other.backdropPath == _this.backdropPath)&&(identical(other.firstAirDate, _this.firstAirDate) || other.firstAirDate == _this.firstAirDate)&&const DeepCollectionEquality().equals(other.genreIds, _this.genreIds)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.originalName, _this.originalName) || other.originalName == _this.originalName)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.posterPath, _this.posterPath) || other.posterPath == _this.posterPath)&&(identical(other.voteAverage, _this.voteAverage) || other.voteAverage == _this.voteAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbTvSummary;
  return Object.hash(runtimeType,_this.adult,_this.backdropPath,_this.firstAirDate,const DeepCollectionEquality().hash(_this.genreIds),_this.id,_this.name,_this.originalName,_this.overview,_this.posterPath,_this.voteAverage);
}

@override
String toString() {
  final _this = this as TmdbTvSummary;
  return 'TmdbTvSummary(adult: ${_this.adult}, backdropPath: ${_this.backdropPath}, firstAirDate: ${_this.firstAirDate}, genreIds: ${_this.genreIds}, id: ${_this.id}, name: ${_this.name}, originalName: ${_this.originalName}, overview: ${_this.overview}, posterPath: ${_this.posterPath}, voteAverage: ${_this.voteAverage})';
}


}

/// @nodoc
abstract mixin class $TmdbTvSummaryCopyWith<$Res>  {
  factory $TmdbTvSummaryCopyWith(TmdbTvSummary value, $Res Function(TmdbTvSummary) _then) = _$TmdbTvSummaryCopyWithImpl;
@useResult
$Res call({
 bool adult,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'first_air_date') String firstAirDate,@JsonKey(name: 'genre_ids') List<int> genreIds, int id, String name,@JsonKey(name: 'original_name') String originalName, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'vote_average') double voteAverage
});




}
/// @nodoc
class _$TmdbTvSummaryCopyWithImpl<$Res>
    implements $TmdbTvSummaryCopyWith<$Res> {
  _$TmdbTvSummaryCopyWithImpl(this._self, this._then);

  final TmdbTvSummary _self;
  final $Res Function(TmdbTvSummary) _then;

/// Create a copy of TmdbTvSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? adult = null,Object? backdropPath = freezed,Object? firstAirDate = null,Object? genreIds = null,Object? id = null,Object? name = null,Object? originalName = null,Object? overview = null,Object? posterPath = freezed,Object? voteAverage = null,}) {
  return _then(TmdbTvSummary(
adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,firstAirDate: null == firstAirDate ? _self.firstAirDate : firstAirDate // ignore: cast_nullable_to_non_nullable
as String,genreIds: null == genreIds ? _self.genreIds : genreIds // ignore: cast_nullable_to_non_nullable
as List<int>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbTvSummary].
extension TmdbTvSummaryPatterns on TmdbTvSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbTvSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbTvSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbTvSummary value)  $default,){
final _that = this;
switch (_that) {
case _TmdbTvSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbTvSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbTvSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool adult, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'first_air_date')  String firstAirDate, @JsonKey(name: 'genre_ids')  List<int> genreIds,  int id,  String name, @JsonKey(name: 'original_name')  String originalName,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'vote_average')  double voteAverage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbTvSummary() when $default != null:
return $default(_that.adult,_that.backdropPath,_that.firstAirDate,_that.genreIds,_that.id,_that.name,_that.originalName,_that.overview,_that.posterPath,_that.voteAverage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool adult, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'first_air_date')  String firstAirDate, @JsonKey(name: 'genre_ids')  List<int> genreIds,  int id,  String name, @JsonKey(name: 'original_name')  String originalName,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'vote_average')  double voteAverage)  $default,) {final _that = this;
switch (_that) {
case _TmdbTvSummary():
return $default(_that.adult,_that.backdropPath,_that.firstAirDate,_that.genreIds,_that.id,_that.name,_that.originalName,_that.overview,_that.posterPath,_that.voteAverage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool adult, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'first_air_date')  String firstAirDate, @JsonKey(name: 'genre_ids')  List<int> genreIds,  int id,  String name, @JsonKey(name: 'original_name')  String originalName,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'vote_average')  double voteAverage)?  $default,) {final _that = this;
switch (_that) {
case _TmdbTvSummary() when $default != null:
return $default(_that.adult,_that.backdropPath,_that.firstAirDate,_that.genreIds,_that.id,_that.name,_that.originalName,_that.overview,_that.posterPath,_that.voteAverage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbTvSummary implements TmdbTvSummary {
  const _TmdbTvSummary({this.adult = false, @JsonKey(name: 'backdrop_path') this.backdropPath, @JsonKey(name: 'first_air_date') this.firstAirDate = '', @JsonKey(name: 'genre_ids')  List<int> genreIds = const <int>[], required this.id, this.name = '', @JsonKey(name: 'original_name') this.originalName = '', this.overview = '', @JsonKey(name: 'poster_path') this.posterPath, @JsonKey(name: 'vote_average') this.voteAverage = 0}): _genreIds = genreIds;
  factory _TmdbTvSummary.fromJson(Map<String, dynamic> json) => _$TmdbTvSummaryFromJson(json);

@override@JsonKey() final  bool adult;
@override@JsonKey(name: 'backdrop_path') final  String? backdropPath;
@override@JsonKey(name: 'first_air_date') final  String firstAirDate;
 final  List<int> _genreIds;
@override@JsonKey(name: 'genre_ids') List<int> get genreIds {
  if (_genreIds is EqualUnmodifiableListView) return _genreIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genreIds);
}

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey(name: 'original_name') final  String originalName;
@override@JsonKey() final  String overview;
@override@JsonKey(name: 'poster_path') final  String? posterPath;
@override@JsonKey(name: 'vote_average') final  double voteAverage;

/// Create a copy of TmdbTvSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbTvSummaryCopyWith<_TmdbTvSummary> get copyWith => __$TmdbTvSummaryCopyWithImpl<_TmdbTvSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbTvSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbTvSummary&&(identical(other.adult, adult) || other.adult == adult)&&(identical(other.backdropPath, backdropPath) || other.backdropPath == backdropPath)&&(identical(other.firstAirDate, firstAirDate) || other.firstAirDate == firstAirDate)&&const DeepCollectionEquality().equals(other.genreIds, _genreIds)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterPath, posterPath) || other.posterPath == posterPath)&&(identical(other.voteAverage, voteAverage) || other.voteAverage == voteAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,adult,backdropPath,firstAirDate,const DeepCollectionEquality().hash(_genreIds),id,name,originalName,overview,posterPath,voteAverage);
}

@override
String toString() {
    return 'TmdbTvSummary(adult: $adult, backdropPath: $backdropPath, firstAirDate: $firstAirDate, genreIds: $genreIds, id: $id, name: $name, originalName: $originalName, overview: $overview, posterPath: $posterPath, voteAverage: $voteAverage)';
}


}

/// @nodoc
abstract mixin class _$TmdbTvSummaryCopyWith<$Res> implements $TmdbTvSummaryCopyWith<$Res> {
  factory _$TmdbTvSummaryCopyWith(_TmdbTvSummary value, $Res Function(_TmdbTvSummary) _then) = __$TmdbTvSummaryCopyWithImpl;
@override @useResult
$Res call({
 bool adult,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'first_air_date') String firstAirDate,@JsonKey(name: 'genre_ids') List<int> genreIds, int id, String name,@JsonKey(name: 'original_name') String originalName, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'vote_average') double voteAverage
});




}
/// @nodoc
class __$TmdbTvSummaryCopyWithImpl<$Res>
    implements _$TmdbTvSummaryCopyWith<$Res> {
  __$TmdbTvSummaryCopyWithImpl(this._self, this._then);

  final _TmdbTvSummary _self;
  final $Res Function(_TmdbTvSummary) _then;

/// Create a copy of TmdbTvSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? adult = null,Object? backdropPath = freezed,Object? firstAirDate = null,Object? genreIds = null,Object? id = null,Object? name = null,Object? originalName = null,Object? overview = null,Object? posterPath = freezed,Object? voteAverage = null,}) {
  return _then(_TmdbTvSummary(
adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,firstAirDate: null == firstAirDate ? _self.firstAirDate : firstAirDate // ignore: cast_nullable_to_non_nullable
as String,genreIds: null == genreIds ? _self._genreIds : genreIds // ignore: cast_nullable_to_non_nullable
as List<int>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TmdbMovieSearchResponse {

 int get page; List<TmdbMovieSummary> get results;@JsonKey(name: 'total_pages') int get totalPages;@JsonKey(name: 'total_results') int get totalResults;
/// Create a copy of TmdbMovieSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbMovieSearchResponseCopyWith<TmdbMovieSearchResponse> get copyWith => _$TmdbMovieSearchResponseCopyWithImpl<TmdbMovieSearchResponse>(this as TmdbMovieSearchResponse, _$identity);

  /// Serializes this TmdbMovieSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbMovieSearchResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbMovieSearchResponse&&(identical(other.page, _this.page) || other.page == _this.page)&&const DeepCollectionEquality().equals(other.results, _this.results)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.totalResults, _this.totalResults) || other.totalResults == _this.totalResults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbMovieSearchResponse;
  return Object.hash(runtimeType,_this.page,const DeepCollectionEquality().hash(_this.results),_this.totalPages,_this.totalResults);
}

@override
String toString() {
  final _this = this as TmdbMovieSearchResponse;
  return 'TmdbMovieSearchResponse(page: ${_this.page}, results: ${_this.results}, totalPages: ${_this.totalPages}, totalResults: ${_this.totalResults})';
}


}

/// @nodoc
abstract mixin class $TmdbMovieSearchResponseCopyWith<$Res>  {
  factory $TmdbMovieSearchResponseCopyWith(TmdbMovieSearchResponse value, $Res Function(TmdbMovieSearchResponse) _then) = _$TmdbMovieSearchResponseCopyWithImpl;
@useResult
$Res call({
 int page, List<TmdbMovieSummary> results,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'total_results') int totalResults
});




}
/// @nodoc
class _$TmdbMovieSearchResponseCopyWithImpl<$Res>
    implements $TmdbMovieSearchResponseCopyWith<$Res> {
  _$TmdbMovieSearchResponseCopyWithImpl(this._self, this._then);

  final TmdbMovieSearchResponse _self;
  final $Res Function(TmdbMovieSearchResponse) _then;

/// Create a copy of TmdbMovieSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? results = null,Object? totalPages = null,Object? totalResults = null,}) {
  return _then(TmdbMovieSearchResponse(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<TmdbMovieSummary>,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbMovieSearchResponse].
extension TmdbMovieSearchResponsePatterns on TmdbMovieSearchResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbMovieSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbMovieSearchResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbMovieSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _TmdbMovieSearchResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbMovieSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbMovieSearchResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  List<TmdbMovieSummary> results, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'total_results')  int totalResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbMovieSearchResponse() when $default != null:
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  List<TmdbMovieSummary> results, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'total_results')  int totalResults)  $default,) {final _that = this;
switch (_that) {
case _TmdbMovieSearchResponse():
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  List<TmdbMovieSummary> results, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'total_results')  int totalResults)?  $default,) {final _that = this;
switch (_that) {
case _TmdbMovieSearchResponse() when $default != null:
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbMovieSearchResponse implements TmdbMovieSearchResponse {
  const _TmdbMovieSearchResponse({this.page = 1,  List<TmdbMovieSummary> results = const <TmdbMovieSummary>[], @JsonKey(name: 'total_pages') this.totalPages = 0, @JsonKey(name: 'total_results') this.totalResults = 0}): _results = results;
  factory _TmdbMovieSearchResponse.fromJson(Map<String, dynamic> json) => _$TmdbMovieSearchResponseFromJson(json);

@override@JsonKey() final  int page;
 final  List<TmdbMovieSummary> _results;
@override@JsonKey() List<TmdbMovieSummary> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey(name: 'total_pages') final  int totalPages;
@override@JsonKey(name: 'total_results') final  int totalResults;

/// Create a copy of TmdbMovieSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbMovieSearchResponseCopyWith<_TmdbMovieSearchResponse> get copyWith => __$TmdbMovieSearchResponseCopyWithImpl<_TmdbMovieSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbMovieSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbMovieSearchResponse&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.results, _results)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,const DeepCollectionEquality().hash(_results),totalPages,totalResults);
}

@override
String toString() {
    return 'TmdbMovieSearchResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
}


}

/// @nodoc
abstract mixin class _$TmdbMovieSearchResponseCopyWith<$Res> implements $TmdbMovieSearchResponseCopyWith<$Res> {
  factory _$TmdbMovieSearchResponseCopyWith(_TmdbMovieSearchResponse value, $Res Function(_TmdbMovieSearchResponse) _then) = __$TmdbMovieSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 int page, List<TmdbMovieSummary> results,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'total_results') int totalResults
});




}
/// @nodoc
class __$TmdbMovieSearchResponseCopyWithImpl<$Res>
    implements _$TmdbMovieSearchResponseCopyWith<$Res> {
  __$TmdbMovieSearchResponseCopyWithImpl(this._self, this._then);

  final _TmdbMovieSearchResponse _self;
  final $Res Function(_TmdbMovieSearchResponse) _then;

/// Create a copy of TmdbMovieSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? results = null,Object? totalPages = null,Object? totalResults = null,}) {
  return _then(_TmdbMovieSearchResponse(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<TmdbMovieSummary>,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TmdbTvSearchResponse {

 int get page; List<TmdbTvSummary> get results;@JsonKey(name: 'total_pages') int get totalPages;@JsonKey(name: 'total_results') int get totalResults;
/// Create a copy of TmdbTvSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbTvSearchResponseCopyWith<TmdbTvSearchResponse> get copyWith => _$TmdbTvSearchResponseCopyWithImpl<TmdbTvSearchResponse>(this as TmdbTvSearchResponse, _$identity);

  /// Serializes this TmdbTvSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbTvSearchResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbTvSearchResponse&&(identical(other.page, _this.page) || other.page == _this.page)&&const DeepCollectionEquality().equals(other.results, _this.results)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.totalResults, _this.totalResults) || other.totalResults == _this.totalResults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbTvSearchResponse;
  return Object.hash(runtimeType,_this.page,const DeepCollectionEquality().hash(_this.results),_this.totalPages,_this.totalResults);
}

@override
String toString() {
  final _this = this as TmdbTvSearchResponse;
  return 'TmdbTvSearchResponse(page: ${_this.page}, results: ${_this.results}, totalPages: ${_this.totalPages}, totalResults: ${_this.totalResults})';
}


}

/// @nodoc
abstract mixin class $TmdbTvSearchResponseCopyWith<$Res>  {
  factory $TmdbTvSearchResponseCopyWith(TmdbTvSearchResponse value, $Res Function(TmdbTvSearchResponse) _then) = _$TmdbTvSearchResponseCopyWithImpl;
@useResult
$Res call({
 int page, List<TmdbTvSummary> results,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'total_results') int totalResults
});




}
/// @nodoc
class _$TmdbTvSearchResponseCopyWithImpl<$Res>
    implements $TmdbTvSearchResponseCopyWith<$Res> {
  _$TmdbTvSearchResponseCopyWithImpl(this._self, this._then);

  final TmdbTvSearchResponse _self;
  final $Res Function(TmdbTvSearchResponse) _then;

/// Create a copy of TmdbTvSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? results = null,Object? totalPages = null,Object? totalResults = null,}) {
  return _then(TmdbTvSearchResponse(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<TmdbTvSummary>,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbTvSearchResponse].
extension TmdbTvSearchResponsePatterns on TmdbTvSearchResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbTvSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbTvSearchResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbTvSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _TmdbTvSearchResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbTvSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbTvSearchResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  List<TmdbTvSummary> results, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'total_results')  int totalResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbTvSearchResponse() when $default != null:
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  List<TmdbTvSummary> results, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'total_results')  int totalResults)  $default,) {final _that = this;
switch (_that) {
case _TmdbTvSearchResponse():
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  List<TmdbTvSummary> results, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'total_results')  int totalResults)?  $default,) {final _that = this;
switch (_that) {
case _TmdbTvSearchResponse() when $default != null:
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbTvSearchResponse implements TmdbTvSearchResponse {
  const _TmdbTvSearchResponse({this.page = 1,  List<TmdbTvSummary> results = const <TmdbTvSummary>[], @JsonKey(name: 'total_pages') this.totalPages = 0, @JsonKey(name: 'total_results') this.totalResults = 0}): _results = results;
  factory _TmdbTvSearchResponse.fromJson(Map<String, dynamic> json) => _$TmdbTvSearchResponseFromJson(json);

@override@JsonKey() final  int page;
 final  List<TmdbTvSummary> _results;
@override@JsonKey() List<TmdbTvSummary> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey(name: 'total_pages') final  int totalPages;
@override@JsonKey(name: 'total_results') final  int totalResults;

/// Create a copy of TmdbTvSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbTvSearchResponseCopyWith<_TmdbTvSearchResponse> get copyWith => __$TmdbTvSearchResponseCopyWithImpl<_TmdbTvSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbTvSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbTvSearchResponse&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.results, _results)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,const DeepCollectionEquality().hash(_results),totalPages,totalResults);
}

@override
String toString() {
    return 'TmdbTvSearchResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
}


}

/// @nodoc
abstract mixin class _$TmdbTvSearchResponseCopyWith<$Res> implements $TmdbTvSearchResponseCopyWith<$Res> {
  factory _$TmdbTvSearchResponseCopyWith(_TmdbTvSearchResponse value, $Res Function(_TmdbTvSearchResponse) _then) = __$TmdbTvSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 int page, List<TmdbTvSummary> results,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'total_results') int totalResults
});




}
/// @nodoc
class __$TmdbTvSearchResponseCopyWithImpl<$Res>
    implements _$TmdbTvSearchResponseCopyWith<$Res> {
  __$TmdbTvSearchResponseCopyWithImpl(this._self, this._then);

  final _TmdbTvSearchResponse _self;
  final $Res Function(_TmdbTvSearchResponse) _then;

/// Create a copy of TmdbTvSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? results = null,Object? totalPages = null,Object? totalResults = null,}) {
  return _then(_TmdbTvSearchResponse(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<TmdbTvSummary>,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TmdbCastMember {

 int get id; String get name; String? get character;@JsonKey(name: 'profile_path') String? get profilePath; int get order;
/// Create a copy of TmdbCastMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbCastMemberCopyWith<TmdbCastMember> get copyWith => _$TmdbCastMemberCopyWithImpl<TmdbCastMember>(this as TmdbCastMember, _$identity);

  /// Serializes this TmdbCastMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbCastMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbCastMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.character, _this.character) || other.character == _this.character)&&(identical(other.profilePath, _this.profilePath) || other.profilePath == _this.profilePath)&&(identical(other.order, _this.order) || other.order == _this.order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbCastMember;
  return Object.hash(runtimeType,_this.id,_this.name,_this.character,_this.profilePath,_this.order);
}

@override
String toString() {
  final _this = this as TmdbCastMember;
  return 'TmdbCastMember(id: ${_this.id}, name: ${_this.name}, character: ${_this.character}, profilePath: ${_this.profilePath}, order: ${_this.order})';
}


}

/// @nodoc
abstract mixin class $TmdbCastMemberCopyWith<$Res>  {
  factory $TmdbCastMemberCopyWith(TmdbCastMember value, $Res Function(TmdbCastMember) _then) = _$TmdbCastMemberCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? character,@JsonKey(name: 'profile_path') String? profilePath, int order
});




}
/// @nodoc
class _$TmdbCastMemberCopyWithImpl<$Res>
    implements $TmdbCastMemberCopyWith<$Res> {
  _$TmdbCastMemberCopyWithImpl(this._self, this._then);

  final TmdbCastMember _self;
  final $Res Function(TmdbCastMember) _then;

/// Create a copy of TmdbCastMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? character = freezed,Object? profilePath = freezed,Object? order = null,}) {
  return _then(TmdbCastMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,character: freezed == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as String?,profilePath: freezed == profilePath ? _self.profilePath : profilePath // ignore: cast_nullable_to_non_nullable
as String?,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbCastMember].
extension TmdbCastMemberPatterns on TmdbCastMember {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbCastMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbCastMember() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbCastMember value)  $default,){
final _that = this;
switch (_that) {
case _TmdbCastMember():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbCastMember value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbCastMember() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? character, @JsonKey(name: 'profile_path')  String? profilePath,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbCastMember() when $default != null:
return $default(_that.id,_that.name,_that.character,_that.profilePath,_that.order);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? character, @JsonKey(name: 'profile_path')  String? profilePath,  int order)  $default,) {final _that = this;
switch (_that) {
case _TmdbCastMember():
return $default(_that.id,_that.name,_that.character,_that.profilePath,_that.order);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? character, @JsonKey(name: 'profile_path')  String? profilePath,  int order)?  $default,) {final _that = this;
switch (_that) {
case _TmdbCastMember() when $default != null:
return $default(_that.id,_that.name,_that.character,_that.profilePath,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbCastMember implements TmdbCastMember {
  const _TmdbCastMember({required this.id, this.name = '', this.character, @JsonKey(name: 'profile_path') this.profilePath, this.order = 0});
  factory _TmdbCastMember.fromJson(Map<String, dynamic> json) => _$TmdbCastMemberFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? character;
@override@JsonKey(name: 'profile_path') final  String? profilePath;
@override@JsonKey() final  int order;

/// Create a copy of TmdbCastMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbCastMemberCopyWith<_TmdbCastMember> get copyWith => __$TmdbCastMemberCopyWithImpl<_TmdbCastMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbCastMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbCastMember&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.character, character) || other.character == character)&&(identical(other.profilePath, profilePath) || other.profilePath == profilePath)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,character,profilePath,order);
}

@override
String toString() {
    return 'TmdbCastMember(id: $id, name: $name, character: $character, profilePath: $profilePath, order: $order)';
}


}

/// @nodoc
abstract mixin class _$TmdbCastMemberCopyWith<$Res> implements $TmdbCastMemberCopyWith<$Res> {
  factory _$TmdbCastMemberCopyWith(_TmdbCastMember value, $Res Function(_TmdbCastMember) _then) = __$TmdbCastMemberCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? character,@JsonKey(name: 'profile_path') String? profilePath, int order
});




}
/// @nodoc
class __$TmdbCastMemberCopyWithImpl<$Res>
    implements _$TmdbCastMemberCopyWith<$Res> {
  __$TmdbCastMemberCopyWithImpl(this._self, this._then);

  final _TmdbCastMember _self;
  final $Res Function(_TmdbCastMember) _then;

/// Create a copy of TmdbCastMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? character = freezed,Object? profilePath = freezed,Object? order = null,}) {
  return _then(_TmdbCastMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,character: freezed == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as String?,profilePath: freezed == profilePath ? _self.profilePath : profilePath // ignore: cast_nullable_to_non_nullable
as String?,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TmdbCrewMember {

 int get id; String get name; String get job;@JsonKey(name: 'profile_path') String? get profilePath;
/// Create a copy of TmdbCrewMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbCrewMemberCopyWith<TmdbCrewMember> get copyWith => _$TmdbCrewMemberCopyWithImpl<TmdbCrewMember>(this as TmdbCrewMember, _$identity);

  /// Serializes this TmdbCrewMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbCrewMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbCrewMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.job, _this.job) || other.job == _this.job)&&(identical(other.profilePath, _this.profilePath) || other.profilePath == _this.profilePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbCrewMember;
  return Object.hash(runtimeType,_this.id,_this.name,_this.job,_this.profilePath);
}

@override
String toString() {
  final _this = this as TmdbCrewMember;
  return 'TmdbCrewMember(id: ${_this.id}, name: ${_this.name}, job: ${_this.job}, profilePath: ${_this.profilePath})';
}


}

/// @nodoc
abstract mixin class $TmdbCrewMemberCopyWith<$Res>  {
  factory $TmdbCrewMemberCopyWith(TmdbCrewMember value, $Res Function(TmdbCrewMember) _then) = _$TmdbCrewMemberCopyWithImpl;
@useResult
$Res call({
 int id, String name, String job,@JsonKey(name: 'profile_path') String? profilePath
});




}
/// @nodoc
class _$TmdbCrewMemberCopyWithImpl<$Res>
    implements $TmdbCrewMemberCopyWith<$Res> {
  _$TmdbCrewMemberCopyWithImpl(this._self, this._then);

  final TmdbCrewMember _self;
  final $Res Function(TmdbCrewMember) _then;

/// Create a copy of TmdbCrewMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? job = null,Object? profilePath = freezed,}) {
  return _then(TmdbCrewMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as String,profilePath: freezed == profilePath ? _self.profilePath : profilePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbCrewMember].
extension TmdbCrewMemberPatterns on TmdbCrewMember {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbCrewMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbCrewMember() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbCrewMember value)  $default,){
final _that = this;
switch (_that) {
case _TmdbCrewMember():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbCrewMember value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbCrewMember() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String job, @JsonKey(name: 'profile_path')  String? profilePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbCrewMember() when $default != null:
return $default(_that.id,_that.name,_that.job,_that.profilePath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String job, @JsonKey(name: 'profile_path')  String? profilePath)  $default,) {final _that = this;
switch (_that) {
case _TmdbCrewMember():
return $default(_that.id,_that.name,_that.job,_that.profilePath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String job, @JsonKey(name: 'profile_path')  String? profilePath)?  $default,) {final _that = this;
switch (_that) {
case _TmdbCrewMember() when $default != null:
return $default(_that.id,_that.name,_that.job,_that.profilePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbCrewMember implements TmdbCrewMember {
  const _TmdbCrewMember({required this.id, this.name = '', this.job = '', @JsonKey(name: 'profile_path') this.profilePath});
  factory _TmdbCrewMember.fromJson(Map<String, dynamic> json) => _$TmdbCrewMemberFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String job;
@override@JsonKey(name: 'profile_path') final  String? profilePath;

/// Create a copy of TmdbCrewMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbCrewMemberCopyWith<_TmdbCrewMember> get copyWith => __$TmdbCrewMemberCopyWithImpl<_TmdbCrewMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbCrewMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbCrewMember&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.job, job) || other.job == job)&&(identical(other.profilePath, profilePath) || other.profilePath == profilePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,job,profilePath);
}

@override
String toString() {
    return 'TmdbCrewMember(id: $id, name: $name, job: $job, profilePath: $profilePath)';
}


}

/// @nodoc
abstract mixin class _$TmdbCrewMemberCopyWith<$Res> implements $TmdbCrewMemberCopyWith<$Res> {
  factory _$TmdbCrewMemberCopyWith(_TmdbCrewMember value, $Res Function(_TmdbCrewMember) _then) = __$TmdbCrewMemberCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String job,@JsonKey(name: 'profile_path') String? profilePath
});




}
/// @nodoc
class __$TmdbCrewMemberCopyWithImpl<$Res>
    implements _$TmdbCrewMemberCopyWith<$Res> {
  __$TmdbCrewMemberCopyWithImpl(this._self, this._then);

  final _TmdbCrewMember _self;
  final $Res Function(_TmdbCrewMember) _then;

/// Create a copy of TmdbCrewMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? job = null,Object? profilePath = freezed,}) {
  return _then(_TmdbCrewMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as String,profilePath: freezed == profilePath ? _self.profilePath : profilePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TmdbCredits {

 List<TmdbCastMember> get cast; List<TmdbCrewMember> get crew;
/// Create a copy of TmdbCredits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbCreditsCopyWith<TmdbCredits> get copyWith => _$TmdbCreditsCopyWithImpl<TmdbCredits>(this as TmdbCredits, _$identity);

  /// Serializes this TmdbCredits to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbCredits;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbCredits&&const DeepCollectionEquality().equals(other.cast, _this.cast)&&const DeepCollectionEquality().equals(other.crew, _this.crew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbCredits;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.cast),const DeepCollectionEquality().hash(_this.crew));
}

@override
String toString() {
  final _this = this as TmdbCredits;
  return 'TmdbCredits(cast: ${_this.cast}, crew: ${_this.crew})';
}


}

/// @nodoc
abstract mixin class $TmdbCreditsCopyWith<$Res>  {
  factory $TmdbCreditsCopyWith(TmdbCredits value, $Res Function(TmdbCredits) _then) = _$TmdbCreditsCopyWithImpl;
@useResult
$Res call({
 List<TmdbCastMember> cast, List<TmdbCrewMember> crew
});




}
/// @nodoc
class _$TmdbCreditsCopyWithImpl<$Res>
    implements $TmdbCreditsCopyWith<$Res> {
  _$TmdbCreditsCopyWithImpl(this._self, this._then);

  final TmdbCredits _self;
  final $Res Function(TmdbCredits) _then;

/// Create a copy of TmdbCredits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cast = null,Object? crew = null,}) {
  return _then(TmdbCredits(
cast: null == cast ? _self.cast : cast // ignore: cast_nullable_to_non_nullable
as List<TmdbCastMember>,crew: null == crew ? _self.crew : crew // ignore: cast_nullable_to_non_nullable
as List<TmdbCrewMember>,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbCredits].
extension TmdbCreditsPatterns on TmdbCredits {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbCredits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbCredits() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbCredits value)  $default,){
final _that = this;
switch (_that) {
case _TmdbCredits():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbCredits value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbCredits() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TmdbCastMember> cast,  List<TmdbCrewMember> crew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbCredits() when $default != null:
return $default(_that.cast,_that.crew);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TmdbCastMember> cast,  List<TmdbCrewMember> crew)  $default,) {final _that = this;
switch (_that) {
case _TmdbCredits():
return $default(_that.cast,_that.crew);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TmdbCastMember> cast,  List<TmdbCrewMember> crew)?  $default,) {final _that = this;
switch (_that) {
case _TmdbCredits() when $default != null:
return $default(_that.cast,_that.crew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbCredits implements TmdbCredits {
  const _TmdbCredits({ List<TmdbCastMember> cast = const <TmdbCastMember>[],  List<TmdbCrewMember> crew = const <TmdbCrewMember>[]}): _cast = cast,_crew = crew;
  factory _TmdbCredits.fromJson(Map<String, dynamic> json) => _$TmdbCreditsFromJson(json);

 final  List<TmdbCastMember> _cast;
@override@JsonKey() List<TmdbCastMember> get cast {
  if (_cast is EqualUnmodifiableListView) return _cast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cast);
}

 final  List<TmdbCrewMember> _crew;
@override@JsonKey() List<TmdbCrewMember> get crew {
  if (_crew is EqualUnmodifiableListView) return _crew;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_crew);
}


/// Create a copy of TmdbCredits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbCreditsCopyWith<_TmdbCredits> get copyWith => __$TmdbCreditsCopyWithImpl<_TmdbCredits>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbCreditsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbCredits&&const DeepCollectionEquality().equals(other.cast, _cast)&&const DeepCollectionEquality().equals(other.crew, _crew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_cast),const DeepCollectionEquality().hash(_crew));
}

@override
String toString() {
    return 'TmdbCredits(cast: $cast, crew: $crew)';
}


}

/// @nodoc
abstract mixin class _$TmdbCreditsCopyWith<$Res> implements $TmdbCreditsCopyWith<$Res> {
  factory _$TmdbCreditsCopyWith(_TmdbCredits value, $Res Function(_TmdbCredits) _then) = __$TmdbCreditsCopyWithImpl;
@override @useResult
$Res call({
 List<TmdbCastMember> cast, List<TmdbCrewMember> crew
});




}
/// @nodoc
class __$TmdbCreditsCopyWithImpl<$Res>
    implements _$TmdbCreditsCopyWith<$Res> {
  __$TmdbCreditsCopyWithImpl(this._self, this._then);

  final _TmdbCredits _self;
  final $Res Function(_TmdbCredits) _then;

/// Create a copy of TmdbCredits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cast = null,Object? crew = null,}) {
  return _then(_TmdbCredits(
cast: null == cast ? _self._cast : cast // ignore: cast_nullable_to_non_nullable
as List<TmdbCastMember>,crew: null == crew ? _self._crew : crew // ignore: cast_nullable_to_non_nullable
as List<TmdbCrewMember>,
  ));
}


}


/// @nodoc
mixin _$TmdbMovieDetails {

 int get id; String get title;@JsonKey(name: 'original_title') String get originalTitle; String get overview;@JsonKey(name: 'poster_path') String? get posterPath;@JsonKey(name: 'backdrop_path') String? get backdropPath;@JsonKey(name: 'release_date') String get releaseDate; int? get runtime; List<TmdbGenreDto> get genres;@JsonKey(name: 'vote_average') double get voteAverage; bool get adult; TmdbCredits? get credits;
/// Create a copy of TmdbMovieDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbMovieDetailsCopyWith<TmdbMovieDetails> get copyWith => _$TmdbMovieDetailsCopyWithImpl<TmdbMovieDetails>(this as TmdbMovieDetails, _$identity);

  /// Serializes this TmdbMovieDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbMovieDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbMovieDetails&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.originalTitle, _this.originalTitle) || other.originalTitle == _this.originalTitle)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.posterPath, _this.posterPath) || other.posterPath == _this.posterPath)&&(identical(other.backdropPath, _this.backdropPath) || other.backdropPath == _this.backdropPath)&&(identical(other.releaseDate, _this.releaseDate) || other.releaseDate == _this.releaseDate)&&(identical(other.runtime, _this.runtime) || other.runtime == _this.runtime)&&const DeepCollectionEquality().equals(other.genres, _this.genres)&&(identical(other.voteAverage, _this.voteAverage) || other.voteAverage == _this.voteAverage)&&(identical(other.adult, _this.adult) || other.adult == _this.adult)&&(identical(other.credits, _this.credits) || other.credits == _this.credits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbMovieDetails;
  return Object.hash(runtimeType,_this.id,_this.title,_this.originalTitle,_this.overview,_this.posterPath,_this.backdropPath,_this.releaseDate,_this.runtime,const DeepCollectionEquality().hash(_this.genres),_this.voteAverage,_this.adult,_this.credits);
}

@override
String toString() {
  final _this = this as TmdbMovieDetails;
  return 'TmdbMovieDetails(id: ${_this.id}, title: ${_this.title}, originalTitle: ${_this.originalTitle}, overview: ${_this.overview}, posterPath: ${_this.posterPath}, backdropPath: ${_this.backdropPath}, releaseDate: ${_this.releaseDate}, runtime: ${_this.runtime}, genres: ${_this.genres}, voteAverage: ${_this.voteAverage}, adult: ${_this.adult}, credits: ${_this.credits})';
}


}

/// @nodoc
abstract mixin class $TmdbMovieDetailsCopyWith<$Res>  {
  factory $TmdbMovieDetailsCopyWith(TmdbMovieDetails value, $Res Function(TmdbMovieDetails) _then) = _$TmdbMovieDetailsCopyWithImpl;
@useResult
$Res call({
 int id, String title,@JsonKey(name: 'original_title') String originalTitle, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'release_date') String releaseDate, int? runtime, List<TmdbGenreDto> genres,@JsonKey(name: 'vote_average') double voteAverage, bool adult, TmdbCredits? credits
});


$TmdbCreditsCopyWith<$Res>? get credits;

}
/// @nodoc
class _$TmdbMovieDetailsCopyWithImpl<$Res>
    implements $TmdbMovieDetailsCopyWith<$Res> {
  _$TmdbMovieDetailsCopyWithImpl(this._self, this._then);

  final TmdbMovieDetails _self;
  final $Res Function(TmdbMovieDetails) _then;

/// Create a copy of TmdbMovieDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? originalTitle = null,Object? overview = null,Object? posterPath = freezed,Object? backdropPath = freezed,Object? releaseDate = null,Object? runtime = freezed,Object? genres = null,Object? voteAverage = null,Object? adult = null,Object? credits = freezed,}) {
  return _then(TmdbMovieDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: null == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String,runtime: freezed == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as int?,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<TmdbGenreDto>,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as TmdbCredits?,
  ));
}
/// Create a copy of TmdbMovieDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TmdbCreditsCopyWith<$Res>? get credits {
    if (_self.credits == null) {
    return null;
  }

  return $TmdbCreditsCopyWith<$Res>(_self.credits!, (value) {
    return _then(_self.copyWith(credits: value));
  });
}
}


/// Adds pattern-matching-related methods to [TmdbMovieDetails].
extension TmdbMovieDetailsPatterns on TmdbMovieDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbMovieDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbMovieDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbMovieDetails value)  $default,){
final _that = this;
switch (_that) {
case _TmdbMovieDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbMovieDetails value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbMovieDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(name: 'original_title')  String originalTitle,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'release_date')  String releaseDate,  int? runtime,  List<TmdbGenreDto> genres, @JsonKey(name: 'vote_average')  double voteAverage,  bool adult,  TmdbCredits? credits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbMovieDetails() when $default != null:
return $default(_that.id,_that.title,_that.originalTitle,_that.overview,_that.posterPath,_that.backdropPath,_that.releaseDate,_that.runtime,_that.genres,_that.voteAverage,_that.adult,_that.credits);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title, @JsonKey(name: 'original_title')  String originalTitle,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'release_date')  String releaseDate,  int? runtime,  List<TmdbGenreDto> genres, @JsonKey(name: 'vote_average')  double voteAverage,  bool adult,  TmdbCredits? credits)  $default,) {final _that = this;
switch (_that) {
case _TmdbMovieDetails():
return $default(_that.id,_that.title,_that.originalTitle,_that.overview,_that.posterPath,_that.backdropPath,_that.releaseDate,_that.runtime,_that.genres,_that.voteAverage,_that.adult,_that.credits);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title, @JsonKey(name: 'original_title')  String originalTitle,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'release_date')  String releaseDate,  int? runtime,  List<TmdbGenreDto> genres, @JsonKey(name: 'vote_average')  double voteAverage,  bool adult,  TmdbCredits? credits)?  $default,) {final _that = this;
switch (_that) {
case _TmdbMovieDetails() when $default != null:
return $default(_that.id,_that.title,_that.originalTitle,_that.overview,_that.posterPath,_that.backdropPath,_that.releaseDate,_that.runtime,_that.genres,_that.voteAverage,_that.adult,_that.credits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbMovieDetails implements TmdbMovieDetails {
  const _TmdbMovieDetails({required this.id, this.title = '', @JsonKey(name: 'original_title') this.originalTitle = '', this.overview = '', @JsonKey(name: 'poster_path') this.posterPath, @JsonKey(name: 'backdrop_path') this.backdropPath, @JsonKey(name: 'release_date') this.releaseDate = '', this.runtime,  List<TmdbGenreDto> genres = const <TmdbGenreDto>[], @JsonKey(name: 'vote_average') this.voteAverage = 0, this.adult = false, this.credits}): _genres = genres;
  factory _TmdbMovieDetails.fromJson(Map<String, dynamic> json) => _$TmdbMovieDetailsFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override@JsonKey(name: 'original_title') final  String originalTitle;
@override@JsonKey() final  String overview;
@override@JsonKey(name: 'poster_path') final  String? posterPath;
@override@JsonKey(name: 'backdrop_path') final  String? backdropPath;
@override@JsonKey(name: 'release_date') final  String releaseDate;
@override final  int? runtime;
 final  List<TmdbGenreDto> _genres;
@override@JsonKey() List<TmdbGenreDto> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override@JsonKey(name: 'vote_average') final  double voteAverage;
@override@JsonKey() final  bool adult;
@override final  TmdbCredits? credits;

/// Create a copy of TmdbMovieDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbMovieDetailsCopyWith<_TmdbMovieDetails> get copyWith => __$TmdbMovieDetailsCopyWithImpl<_TmdbMovieDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbMovieDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbMovieDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterPath, posterPath) || other.posterPath == posterPath)&&(identical(other.backdropPath, backdropPath) || other.backdropPath == backdropPath)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.runtime, runtime) || other.runtime == runtime)&&const DeepCollectionEquality().equals(other.genres, _genres)&&(identical(other.voteAverage, voteAverage) || other.voteAverage == voteAverage)&&(identical(other.adult, adult) || other.adult == adult)&&(identical(other.credits, credits) || other.credits == credits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,originalTitle,overview,posterPath,backdropPath,releaseDate,runtime,const DeepCollectionEquality().hash(_genres),voteAverage,adult,credits);
}

@override
String toString() {
    return 'TmdbMovieDetails(id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, runtime: $runtime, genres: $genres, voteAverage: $voteAverage, adult: $adult, credits: $credits)';
}


}

/// @nodoc
abstract mixin class _$TmdbMovieDetailsCopyWith<$Res> implements $TmdbMovieDetailsCopyWith<$Res> {
  factory _$TmdbMovieDetailsCopyWith(_TmdbMovieDetails value, $Res Function(_TmdbMovieDetails) _then) = __$TmdbMovieDetailsCopyWithImpl;
@override @useResult
$Res call({
 int id, String title,@JsonKey(name: 'original_title') String originalTitle, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'release_date') String releaseDate, int? runtime, List<TmdbGenreDto> genres,@JsonKey(name: 'vote_average') double voteAverage, bool adult, TmdbCredits? credits
});


@override $TmdbCreditsCopyWith<$Res>? get credits;

}
/// @nodoc
class __$TmdbMovieDetailsCopyWithImpl<$Res>
    implements _$TmdbMovieDetailsCopyWith<$Res> {
  __$TmdbMovieDetailsCopyWithImpl(this._self, this._then);

  final _TmdbMovieDetails _self;
  final $Res Function(_TmdbMovieDetails) _then;

/// Create a copy of TmdbMovieDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? originalTitle = null,Object? overview = null,Object? posterPath = freezed,Object? backdropPath = freezed,Object? releaseDate = null,Object? runtime = freezed,Object? genres = null,Object? voteAverage = null,Object? adult = null,Object? credits = freezed,}) {
  return _then(_TmdbMovieDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: null == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String,runtime: freezed == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as int?,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<TmdbGenreDto>,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as TmdbCredits?,
  ));
}

/// Create a copy of TmdbMovieDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TmdbCreditsCopyWith<$Res>? get credits {
    if (_self.credits == null) {
    return null;
  }

  return $TmdbCreditsCopyWith<$Res>(_self.credits!, (value) {
    return _then(_self.copyWith(credits: value));
  });
}
}


/// @nodoc
mixin _$TmdbCreatedBy {

 int get id; String get name;@JsonKey(name: 'profile_path') String? get profilePath;
/// Create a copy of TmdbCreatedBy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbCreatedByCopyWith<TmdbCreatedBy> get copyWith => _$TmdbCreatedByCopyWithImpl<TmdbCreatedBy>(this as TmdbCreatedBy, _$identity);

  /// Serializes this TmdbCreatedBy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbCreatedBy;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbCreatedBy&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.profilePath, _this.profilePath) || other.profilePath == _this.profilePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbCreatedBy;
  return Object.hash(runtimeType,_this.id,_this.name,_this.profilePath);
}

@override
String toString() {
  final _this = this as TmdbCreatedBy;
  return 'TmdbCreatedBy(id: ${_this.id}, name: ${_this.name}, profilePath: ${_this.profilePath})';
}


}

/// @nodoc
abstract mixin class $TmdbCreatedByCopyWith<$Res>  {
  factory $TmdbCreatedByCopyWith(TmdbCreatedBy value, $Res Function(TmdbCreatedBy) _then) = _$TmdbCreatedByCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'profile_path') String? profilePath
});




}
/// @nodoc
class _$TmdbCreatedByCopyWithImpl<$Res>
    implements $TmdbCreatedByCopyWith<$Res> {
  _$TmdbCreatedByCopyWithImpl(this._self, this._then);

  final TmdbCreatedBy _self;
  final $Res Function(TmdbCreatedBy) _then;

/// Create a copy of TmdbCreatedBy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? profilePath = freezed,}) {
  return _then(TmdbCreatedBy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profilePath: freezed == profilePath ? _self.profilePath : profilePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbCreatedBy].
extension TmdbCreatedByPatterns on TmdbCreatedBy {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbCreatedBy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbCreatedBy() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbCreatedBy value)  $default,){
final _that = this;
switch (_that) {
case _TmdbCreatedBy():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbCreatedBy value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbCreatedBy() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'profile_path')  String? profilePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbCreatedBy() when $default != null:
return $default(_that.id,_that.name,_that.profilePath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'profile_path')  String? profilePath)  $default,) {final _that = this;
switch (_that) {
case _TmdbCreatedBy():
return $default(_that.id,_that.name,_that.profilePath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'profile_path')  String? profilePath)?  $default,) {final _that = this;
switch (_that) {
case _TmdbCreatedBy() when $default != null:
return $default(_that.id,_that.name,_that.profilePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbCreatedBy implements TmdbCreatedBy {
  const _TmdbCreatedBy({required this.id, this.name = '', @JsonKey(name: 'profile_path') this.profilePath});
  factory _TmdbCreatedBy.fromJson(Map<String, dynamic> json) => _$TmdbCreatedByFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey(name: 'profile_path') final  String? profilePath;

/// Create a copy of TmdbCreatedBy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbCreatedByCopyWith<_TmdbCreatedBy> get copyWith => __$TmdbCreatedByCopyWithImpl<_TmdbCreatedBy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbCreatedByToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbCreatedBy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.profilePath, profilePath) || other.profilePath == profilePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,profilePath);
}

@override
String toString() {
    return 'TmdbCreatedBy(id: $id, name: $name, profilePath: $profilePath)';
}


}

/// @nodoc
abstract mixin class _$TmdbCreatedByCopyWith<$Res> implements $TmdbCreatedByCopyWith<$Res> {
  factory _$TmdbCreatedByCopyWith(_TmdbCreatedBy value, $Res Function(_TmdbCreatedBy) _then) = __$TmdbCreatedByCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'profile_path') String? profilePath
});




}
/// @nodoc
class __$TmdbCreatedByCopyWithImpl<$Res>
    implements _$TmdbCreatedByCopyWith<$Res> {
  __$TmdbCreatedByCopyWithImpl(this._self, this._then);

  final _TmdbCreatedBy _self;
  final $Res Function(_TmdbCreatedBy) _then;

/// Create a copy of TmdbCreatedBy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? profilePath = freezed,}) {
  return _then(_TmdbCreatedBy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profilePath: freezed == profilePath ? _self.profilePath : profilePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TmdbTvDetails {

 int get id; String get name;@JsonKey(name: 'original_name') String get originalName; String get overview;@JsonKey(name: 'poster_path') String? get posterPath;@JsonKey(name: 'backdrop_path') String? get backdropPath;@JsonKey(name: 'first_air_date') String get firstAirDate;@JsonKey(name: 'episode_run_time') List<int> get episodeRunTime; List<TmdbGenreDto> get genres;@JsonKey(name: 'vote_average') double get voteAverage;@JsonKey(name: 'number_of_seasons') int? get numberOfSeasons;@JsonKey(name: 'number_of_episodes') int? get numberOfEpisodes; String get status;@JsonKey(name: 'created_by') List<TmdbCreatedBy> get createdBy; List<String> get originCountry; bool get adult; TmdbCredits? get credits;
/// Create a copy of TmdbTvDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbTvDetailsCopyWith<TmdbTvDetails> get copyWith => _$TmdbTvDetailsCopyWithImpl<TmdbTvDetails>(this as TmdbTvDetails, _$identity);

  /// Serializes this TmdbTvDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbTvDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbTvDetails&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.originalName, _this.originalName) || other.originalName == _this.originalName)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.posterPath, _this.posterPath) || other.posterPath == _this.posterPath)&&(identical(other.backdropPath, _this.backdropPath) || other.backdropPath == _this.backdropPath)&&(identical(other.firstAirDate, _this.firstAirDate) || other.firstAirDate == _this.firstAirDate)&&const DeepCollectionEquality().equals(other.episodeRunTime, _this.episodeRunTime)&&const DeepCollectionEquality().equals(other.genres, _this.genres)&&(identical(other.voteAverage, _this.voteAverage) || other.voteAverage == _this.voteAverage)&&(identical(other.numberOfSeasons, _this.numberOfSeasons) || other.numberOfSeasons == _this.numberOfSeasons)&&(identical(other.numberOfEpisodes, _this.numberOfEpisodes) || other.numberOfEpisodes == _this.numberOfEpisodes)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.createdBy, _this.createdBy)&&const DeepCollectionEquality().equals(other.originCountry, _this.originCountry)&&(identical(other.adult, _this.adult) || other.adult == _this.adult)&&(identical(other.credits, _this.credits) || other.credits == _this.credits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbTvDetails;
  return Object.hash(runtimeType,_this.id,_this.name,_this.originalName,_this.overview,_this.posterPath,_this.backdropPath,_this.firstAirDate,const DeepCollectionEquality().hash(_this.episodeRunTime),const DeepCollectionEquality().hash(_this.genres),_this.voteAverage,_this.numberOfSeasons,_this.numberOfEpisodes,_this.status,const DeepCollectionEquality().hash(_this.createdBy),const DeepCollectionEquality().hash(_this.originCountry),_this.adult,_this.credits);
}

@override
String toString() {
  final _this = this as TmdbTvDetails;
  return 'TmdbTvDetails(id: ${_this.id}, name: ${_this.name}, originalName: ${_this.originalName}, overview: ${_this.overview}, posterPath: ${_this.posterPath}, backdropPath: ${_this.backdropPath}, firstAirDate: ${_this.firstAirDate}, episodeRunTime: ${_this.episodeRunTime}, genres: ${_this.genres}, voteAverage: ${_this.voteAverage}, numberOfSeasons: ${_this.numberOfSeasons}, numberOfEpisodes: ${_this.numberOfEpisodes}, status: ${_this.status}, createdBy: ${_this.createdBy}, originCountry: ${_this.originCountry}, adult: ${_this.adult}, credits: ${_this.credits})';
}


}

/// @nodoc
abstract mixin class $TmdbTvDetailsCopyWith<$Res>  {
  factory $TmdbTvDetailsCopyWith(TmdbTvDetails value, $Res Function(TmdbTvDetails) _then) = _$TmdbTvDetailsCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'original_name') String originalName, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'first_air_date') String firstAirDate,@JsonKey(name: 'episode_run_time') List<int> episodeRunTime, List<TmdbGenreDto> genres,@JsonKey(name: 'vote_average') double voteAverage,@JsonKey(name: 'number_of_seasons') int? numberOfSeasons,@JsonKey(name: 'number_of_episodes') int? numberOfEpisodes, String status,@JsonKey(name: 'created_by') List<TmdbCreatedBy> createdBy, List<String> originCountry, bool adult, TmdbCredits? credits
});


$TmdbCreditsCopyWith<$Res>? get credits;

}
/// @nodoc
class _$TmdbTvDetailsCopyWithImpl<$Res>
    implements $TmdbTvDetailsCopyWith<$Res> {
  _$TmdbTvDetailsCopyWithImpl(this._self, this._then);

  final TmdbTvDetails _self;
  final $Res Function(TmdbTvDetails) _then;

/// Create a copy of TmdbTvDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? originalName = null,Object? overview = null,Object? posterPath = freezed,Object? backdropPath = freezed,Object? firstAirDate = null,Object? episodeRunTime = null,Object? genres = null,Object? voteAverage = null,Object? numberOfSeasons = freezed,Object? numberOfEpisodes = freezed,Object? status = null,Object? createdBy = null,Object? originCountry = null,Object? adult = null,Object? credits = freezed,}) {
  return _then(TmdbTvDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,firstAirDate: null == firstAirDate ? _self.firstAirDate : firstAirDate // ignore: cast_nullable_to_non_nullable
as String,episodeRunTime: null == episodeRunTime ? _self.episodeRunTime : episodeRunTime // ignore: cast_nullable_to_non_nullable
as List<int>,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<TmdbGenreDto>,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,numberOfSeasons: freezed == numberOfSeasons ? _self.numberOfSeasons : numberOfSeasons // ignore: cast_nullable_to_non_nullable
as int?,numberOfEpisodes: freezed == numberOfEpisodes ? _self.numberOfEpisodes : numberOfEpisodes // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as List<TmdbCreatedBy>,originCountry: null == originCountry ? _self.originCountry : originCountry // ignore: cast_nullable_to_non_nullable
as List<String>,adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as TmdbCredits?,
  ));
}
/// Create a copy of TmdbTvDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TmdbCreditsCopyWith<$Res>? get credits {
    if (_self.credits == null) {
    return null;
  }

  return $TmdbCreditsCopyWith<$Res>(_self.credits!, (value) {
    return _then(_self.copyWith(credits: value));
  });
}
}


/// Adds pattern-matching-related methods to [TmdbTvDetails].
extension TmdbTvDetailsPatterns on TmdbTvDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbTvDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbTvDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbTvDetails value)  $default,){
final _that = this;
switch (_that) {
case _TmdbTvDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbTvDetails value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbTvDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'original_name')  String originalName,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'first_air_date')  String firstAirDate, @JsonKey(name: 'episode_run_time')  List<int> episodeRunTime,  List<TmdbGenreDto> genres, @JsonKey(name: 'vote_average')  double voteAverage, @JsonKey(name: 'number_of_seasons')  int? numberOfSeasons, @JsonKey(name: 'number_of_episodes')  int? numberOfEpisodes,  String status, @JsonKey(name: 'created_by')  List<TmdbCreatedBy> createdBy,  List<String> originCountry,  bool adult,  TmdbCredits? credits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbTvDetails() when $default != null:
return $default(_that.id,_that.name,_that.originalName,_that.overview,_that.posterPath,_that.backdropPath,_that.firstAirDate,_that.episodeRunTime,_that.genres,_that.voteAverage,_that.numberOfSeasons,_that.numberOfEpisodes,_that.status,_that.createdBy,_that.originCountry,_that.adult,_that.credits);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'original_name')  String originalName,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'first_air_date')  String firstAirDate, @JsonKey(name: 'episode_run_time')  List<int> episodeRunTime,  List<TmdbGenreDto> genres, @JsonKey(name: 'vote_average')  double voteAverage, @JsonKey(name: 'number_of_seasons')  int? numberOfSeasons, @JsonKey(name: 'number_of_episodes')  int? numberOfEpisodes,  String status, @JsonKey(name: 'created_by')  List<TmdbCreatedBy> createdBy,  List<String> originCountry,  bool adult,  TmdbCredits? credits)  $default,) {final _that = this;
switch (_that) {
case _TmdbTvDetails():
return $default(_that.id,_that.name,_that.originalName,_that.overview,_that.posterPath,_that.backdropPath,_that.firstAirDate,_that.episodeRunTime,_that.genres,_that.voteAverage,_that.numberOfSeasons,_that.numberOfEpisodes,_that.status,_that.createdBy,_that.originCountry,_that.adult,_that.credits);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'original_name')  String originalName,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'first_air_date')  String firstAirDate, @JsonKey(name: 'episode_run_time')  List<int> episodeRunTime,  List<TmdbGenreDto> genres, @JsonKey(name: 'vote_average')  double voteAverage, @JsonKey(name: 'number_of_seasons')  int? numberOfSeasons, @JsonKey(name: 'number_of_episodes')  int? numberOfEpisodes,  String status, @JsonKey(name: 'created_by')  List<TmdbCreatedBy> createdBy,  List<String> originCountry,  bool adult,  TmdbCredits? credits)?  $default,) {final _that = this;
switch (_that) {
case _TmdbTvDetails() when $default != null:
return $default(_that.id,_that.name,_that.originalName,_that.overview,_that.posterPath,_that.backdropPath,_that.firstAirDate,_that.episodeRunTime,_that.genres,_that.voteAverage,_that.numberOfSeasons,_that.numberOfEpisodes,_that.status,_that.createdBy,_that.originCountry,_that.adult,_that.credits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbTvDetails implements TmdbTvDetails {
  const _TmdbTvDetails({required this.id, this.name = '', @JsonKey(name: 'original_name') this.originalName = '', this.overview = '', @JsonKey(name: 'poster_path') this.posterPath, @JsonKey(name: 'backdrop_path') this.backdropPath, @JsonKey(name: 'first_air_date') this.firstAirDate = '', @JsonKey(name: 'episode_run_time')  List<int> episodeRunTime = const <int>[],  List<TmdbGenreDto> genres = const <TmdbGenreDto>[], @JsonKey(name: 'vote_average') this.voteAverage = 0, @JsonKey(name: 'number_of_seasons') this.numberOfSeasons, @JsonKey(name: 'number_of_episodes') this.numberOfEpisodes, this.status = '', @JsonKey(name: 'created_by')  List<TmdbCreatedBy> createdBy = const <TmdbCreatedBy>[],  List<String> originCountry = const <String>[], this.adult = false, this.credits}): _episodeRunTime = episodeRunTime,_genres = genres,_createdBy = createdBy,_originCountry = originCountry;
  factory _TmdbTvDetails.fromJson(Map<String, dynamic> json) => _$TmdbTvDetailsFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey(name: 'original_name') final  String originalName;
@override@JsonKey() final  String overview;
@override@JsonKey(name: 'poster_path') final  String? posterPath;
@override@JsonKey(name: 'backdrop_path') final  String? backdropPath;
@override@JsonKey(name: 'first_air_date') final  String firstAirDate;
 final  List<int> _episodeRunTime;
@override@JsonKey(name: 'episode_run_time') List<int> get episodeRunTime {
  if (_episodeRunTime is EqualUnmodifiableListView) return _episodeRunTime;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodeRunTime);
}

 final  List<TmdbGenreDto> _genres;
@override@JsonKey() List<TmdbGenreDto> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override@JsonKey(name: 'vote_average') final  double voteAverage;
@override@JsonKey(name: 'number_of_seasons') final  int? numberOfSeasons;
@override@JsonKey(name: 'number_of_episodes') final  int? numberOfEpisodes;
@override@JsonKey() final  String status;
 final  List<TmdbCreatedBy> _createdBy;
@override@JsonKey(name: 'created_by') List<TmdbCreatedBy> get createdBy {
  if (_createdBy is EqualUnmodifiableListView) return _createdBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_createdBy);
}

 final  List<String> _originCountry;
@override@JsonKey() List<String> get originCountry {
  if (_originCountry is EqualUnmodifiableListView) return _originCountry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_originCountry);
}

@override@JsonKey() final  bool adult;
@override final  TmdbCredits? credits;

/// Create a copy of TmdbTvDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbTvDetailsCopyWith<_TmdbTvDetails> get copyWith => __$TmdbTvDetailsCopyWithImpl<_TmdbTvDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbTvDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbTvDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterPath, posterPath) || other.posterPath == posterPath)&&(identical(other.backdropPath, backdropPath) || other.backdropPath == backdropPath)&&(identical(other.firstAirDate, firstAirDate) || other.firstAirDate == firstAirDate)&&const DeepCollectionEquality().equals(other.episodeRunTime, _episodeRunTime)&&const DeepCollectionEquality().equals(other.genres, _genres)&&(identical(other.voteAverage, voteAverage) || other.voteAverage == voteAverage)&&(identical(other.numberOfSeasons, numberOfSeasons) || other.numberOfSeasons == numberOfSeasons)&&(identical(other.numberOfEpisodes, numberOfEpisodes) || other.numberOfEpisodes == numberOfEpisodes)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.createdBy, _createdBy)&&const DeepCollectionEquality().equals(other.originCountry, _originCountry)&&(identical(other.adult, adult) || other.adult == adult)&&(identical(other.credits, credits) || other.credits == credits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,originalName,overview,posterPath,backdropPath,firstAirDate,const DeepCollectionEquality().hash(_episodeRunTime),const DeepCollectionEquality().hash(_genres),voteAverage,numberOfSeasons,numberOfEpisodes,status,const DeepCollectionEquality().hash(_createdBy),const DeepCollectionEquality().hash(_originCountry),adult,credits);
}

@override
String toString() {
    return 'TmdbTvDetails(id: $id, name: $name, originalName: $originalName, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, firstAirDate: $firstAirDate, episodeRunTime: $episodeRunTime, genres: $genres, voteAverage: $voteAverage, numberOfSeasons: $numberOfSeasons, numberOfEpisodes: $numberOfEpisodes, status: $status, createdBy: $createdBy, originCountry: $originCountry, adult: $adult, credits: $credits)';
}


}

/// @nodoc
abstract mixin class _$TmdbTvDetailsCopyWith<$Res> implements $TmdbTvDetailsCopyWith<$Res> {
  factory _$TmdbTvDetailsCopyWith(_TmdbTvDetails value, $Res Function(_TmdbTvDetails) _then) = __$TmdbTvDetailsCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'original_name') String originalName, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'first_air_date') String firstAirDate,@JsonKey(name: 'episode_run_time') List<int> episodeRunTime, List<TmdbGenreDto> genres,@JsonKey(name: 'vote_average') double voteAverage,@JsonKey(name: 'number_of_seasons') int? numberOfSeasons,@JsonKey(name: 'number_of_episodes') int? numberOfEpisodes, String status,@JsonKey(name: 'created_by') List<TmdbCreatedBy> createdBy, List<String> originCountry, bool adult, TmdbCredits? credits
});


@override $TmdbCreditsCopyWith<$Res>? get credits;

}
/// @nodoc
class __$TmdbTvDetailsCopyWithImpl<$Res>
    implements _$TmdbTvDetailsCopyWith<$Res> {
  __$TmdbTvDetailsCopyWithImpl(this._self, this._then);

  final _TmdbTvDetails _self;
  final $Res Function(_TmdbTvDetails) _then;

/// Create a copy of TmdbTvDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? originalName = null,Object? overview = null,Object? posterPath = freezed,Object? backdropPath = freezed,Object? firstAirDate = null,Object? episodeRunTime = null,Object? genres = null,Object? voteAverage = null,Object? numberOfSeasons = freezed,Object? numberOfEpisodes = freezed,Object? status = null,Object? createdBy = null,Object? originCountry = null,Object? adult = null,Object? credits = freezed,}) {
  return _then(_TmdbTvDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,firstAirDate: null == firstAirDate ? _self.firstAirDate : firstAirDate // ignore: cast_nullable_to_non_nullable
as String,episodeRunTime: null == episodeRunTime ? _self._episodeRunTime : episodeRunTime // ignore: cast_nullable_to_non_nullable
as List<int>,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<TmdbGenreDto>,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,numberOfSeasons: freezed == numberOfSeasons ? _self.numberOfSeasons : numberOfSeasons // ignore: cast_nullable_to_non_nullable
as int?,numberOfEpisodes: freezed == numberOfEpisodes ? _self.numberOfEpisodes : numberOfEpisodes // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self._createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as List<TmdbCreatedBy>,originCountry: null == originCountry ? _self._originCountry : originCountry // ignore: cast_nullable_to_non_nullable
as List<String>,adult: null == adult ? _self.adult : adult // ignore: cast_nullable_to_non_nullable
as bool,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as TmdbCredits?,
  ));
}

/// Create a copy of TmdbTvDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TmdbCreditsCopyWith<$Res>? get credits {
    if (_self.credits == null) {
    return null;
  }

  return $TmdbCreditsCopyWith<$Res>(_self.credits!, (value) {
    return _then(_self.copyWith(credits: value));
  });
}
}


/// @nodoc
mixin _$TmdbImageConfiguration {

@JsonKey(name: 'base_url') String get baseUrl;@JsonKey(name: 'secure_base_url') String get secureBaseUrl;@JsonKey(name: 'poster_sizes') List<String> get posterSizes;@JsonKey(name: 'backdrop_sizes') List<String> get backdropSizes;@JsonKey(name: 'profile_sizes') List<String> get profileSizes;
/// Create a copy of TmdbImageConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbImageConfigurationCopyWith<TmdbImageConfiguration> get copyWith => _$TmdbImageConfigurationCopyWithImpl<TmdbImageConfiguration>(this as TmdbImageConfiguration, _$identity);

  /// Serializes this TmdbImageConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbImageConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbImageConfiguration&&(identical(other.baseUrl, _this.baseUrl) || other.baseUrl == _this.baseUrl)&&(identical(other.secureBaseUrl, _this.secureBaseUrl) || other.secureBaseUrl == _this.secureBaseUrl)&&const DeepCollectionEquality().equals(other.posterSizes, _this.posterSizes)&&const DeepCollectionEquality().equals(other.backdropSizes, _this.backdropSizes)&&const DeepCollectionEquality().equals(other.profileSizes, _this.profileSizes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbImageConfiguration;
  return Object.hash(runtimeType,_this.baseUrl,_this.secureBaseUrl,const DeepCollectionEquality().hash(_this.posterSizes),const DeepCollectionEquality().hash(_this.backdropSizes),const DeepCollectionEquality().hash(_this.profileSizes));
}

@override
String toString() {
  final _this = this as TmdbImageConfiguration;
  return 'TmdbImageConfiguration(baseUrl: ${_this.baseUrl}, secureBaseUrl: ${_this.secureBaseUrl}, posterSizes: ${_this.posterSizes}, backdropSizes: ${_this.backdropSizes}, profileSizes: ${_this.profileSizes})';
}


}

/// @nodoc
abstract mixin class $TmdbImageConfigurationCopyWith<$Res>  {
  factory $TmdbImageConfigurationCopyWith(TmdbImageConfiguration value, $Res Function(TmdbImageConfiguration) _then) = _$TmdbImageConfigurationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'base_url') String baseUrl,@JsonKey(name: 'secure_base_url') String secureBaseUrl,@JsonKey(name: 'poster_sizes') List<String> posterSizes,@JsonKey(name: 'backdrop_sizes') List<String> backdropSizes,@JsonKey(name: 'profile_sizes') List<String> profileSizes
});




}
/// @nodoc
class _$TmdbImageConfigurationCopyWithImpl<$Res>
    implements $TmdbImageConfigurationCopyWith<$Res> {
  _$TmdbImageConfigurationCopyWithImpl(this._self, this._then);

  final TmdbImageConfiguration _self;
  final $Res Function(TmdbImageConfiguration) _then;

/// Create a copy of TmdbImageConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? secureBaseUrl = null,Object? posterSizes = null,Object? backdropSizes = null,Object? profileSizes = null,}) {
  return _then(TmdbImageConfiguration(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,secureBaseUrl: null == secureBaseUrl ? _self.secureBaseUrl : secureBaseUrl // ignore: cast_nullable_to_non_nullable
as String,posterSizes: null == posterSizes ? _self.posterSizes : posterSizes // ignore: cast_nullable_to_non_nullable
as List<String>,backdropSizes: null == backdropSizes ? _self.backdropSizes : backdropSizes // ignore: cast_nullable_to_non_nullable
as List<String>,profileSizes: null == profileSizes ? _self.profileSizes : profileSizes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TmdbImageConfiguration].
extension TmdbImageConfigurationPatterns on TmdbImageConfiguration {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbImageConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbImageConfiguration() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbImageConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _TmdbImageConfiguration():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbImageConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbImageConfiguration() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'base_url')  String baseUrl, @JsonKey(name: 'secure_base_url')  String secureBaseUrl, @JsonKey(name: 'poster_sizes')  List<String> posterSizes, @JsonKey(name: 'backdrop_sizes')  List<String> backdropSizes, @JsonKey(name: 'profile_sizes')  List<String> profileSizes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbImageConfiguration() when $default != null:
return $default(_that.baseUrl,_that.secureBaseUrl,_that.posterSizes,_that.backdropSizes,_that.profileSizes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'base_url')  String baseUrl, @JsonKey(name: 'secure_base_url')  String secureBaseUrl, @JsonKey(name: 'poster_sizes')  List<String> posterSizes, @JsonKey(name: 'backdrop_sizes')  List<String> backdropSizes, @JsonKey(name: 'profile_sizes')  List<String> profileSizes)  $default,) {final _that = this;
switch (_that) {
case _TmdbImageConfiguration():
return $default(_that.baseUrl,_that.secureBaseUrl,_that.posterSizes,_that.backdropSizes,_that.profileSizes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'base_url')  String baseUrl, @JsonKey(name: 'secure_base_url')  String secureBaseUrl, @JsonKey(name: 'poster_sizes')  List<String> posterSizes, @JsonKey(name: 'backdrop_sizes')  List<String> backdropSizes, @JsonKey(name: 'profile_sizes')  List<String> profileSizes)?  $default,) {final _that = this;
switch (_that) {
case _TmdbImageConfiguration() when $default != null:
return $default(_that.baseUrl,_that.secureBaseUrl,_that.posterSizes,_that.backdropSizes,_that.profileSizes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbImageConfiguration implements TmdbImageConfiguration {
  const _TmdbImageConfiguration({@JsonKey(name: 'base_url') this.baseUrl = '', @JsonKey(name: 'secure_base_url') this.secureBaseUrl = '', @JsonKey(name: 'poster_sizes')  List<String> posterSizes = const <String>[], @JsonKey(name: 'backdrop_sizes')  List<String> backdropSizes = const <String>[], @JsonKey(name: 'profile_sizes')  List<String> profileSizes = const <String>[]}): _posterSizes = posterSizes,_backdropSizes = backdropSizes,_profileSizes = profileSizes;
  factory _TmdbImageConfiguration.fromJson(Map<String, dynamic> json) => _$TmdbImageConfigurationFromJson(json);

@override@JsonKey(name: 'base_url') final  String baseUrl;
@override@JsonKey(name: 'secure_base_url') final  String secureBaseUrl;
 final  List<String> _posterSizes;
@override@JsonKey(name: 'poster_sizes') List<String> get posterSizes {
  if (_posterSizes is EqualUnmodifiableListView) return _posterSizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posterSizes);
}

 final  List<String> _backdropSizes;
@override@JsonKey(name: 'backdrop_sizes') List<String> get backdropSizes {
  if (_backdropSizes is EqualUnmodifiableListView) return _backdropSizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backdropSizes);
}

 final  List<String> _profileSizes;
@override@JsonKey(name: 'profile_sizes') List<String> get profileSizes {
  if (_profileSizes is EqualUnmodifiableListView) return _profileSizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profileSizes);
}


/// Create a copy of TmdbImageConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbImageConfigurationCopyWith<_TmdbImageConfiguration> get copyWith => __$TmdbImageConfigurationCopyWithImpl<_TmdbImageConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbImageConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbImageConfiguration&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.secureBaseUrl, secureBaseUrl) || other.secureBaseUrl == secureBaseUrl)&&const DeepCollectionEquality().equals(other.posterSizes, _posterSizes)&&const DeepCollectionEquality().equals(other.backdropSizes, _backdropSizes)&&const DeepCollectionEquality().equals(other.profileSizes, _profileSizes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,baseUrl,secureBaseUrl,const DeepCollectionEquality().hash(_posterSizes),const DeepCollectionEquality().hash(_backdropSizes),const DeepCollectionEquality().hash(_profileSizes));
}

@override
String toString() {
    return 'TmdbImageConfiguration(baseUrl: $baseUrl, secureBaseUrl: $secureBaseUrl, posterSizes: $posterSizes, backdropSizes: $backdropSizes, profileSizes: $profileSizes)';
}


}

/// @nodoc
abstract mixin class _$TmdbImageConfigurationCopyWith<$Res> implements $TmdbImageConfigurationCopyWith<$Res> {
  factory _$TmdbImageConfigurationCopyWith(_TmdbImageConfiguration value, $Res Function(_TmdbImageConfiguration) _then) = __$TmdbImageConfigurationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'base_url') String baseUrl,@JsonKey(name: 'secure_base_url') String secureBaseUrl,@JsonKey(name: 'poster_sizes') List<String> posterSizes,@JsonKey(name: 'backdrop_sizes') List<String> backdropSizes,@JsonKey(name: 'profile_sizes') List<String> profileSizes
});




}
/// @nodoc
class __$TmdbImageConfigurationCopyWithImpl<$Res>
    implements _$TmdbImageConfigurationCopyWith<$Res> {
  __$TmdbImageConfigurationCopyWithImpl(this._self, this._then);

  final _TmdbImageConfiguration _self;
  final $Res Function(_TmdbImageConfiguration) _then;

/// Create a copy of TmdbImageConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? secureBaseUrl = null,Object? posterSizes = null,Object? backdropSizes = null,Object? profileSizes = null,}) {
  return _then(_TmdbImageConfiguration(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,secureBaseUrl: null == secureBaseUrl ? _self.secureBaseUrl : secureBaseUrl // ignore: cast_nullable_to_non_nullable
as String,posterSizes: null == posterSizes ? _self._posterSizes : posterSizes // ignore: cast_nullable_to_non_nullable
as List<String>,backdropSizes: null == backdropSizes ? _self._backdropSizes : backdropSizes // ignore: cast_nullable_to_non_nullable
as List<String>,profileSizes: null == profileSizes ? _self._profileSizes : profileSizes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$TmdbConfigurationResponse {

 TmdbImageConfiguration? get images;
/// Create a copy of TmdbConfigurationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TmdbConfigurationResponseCopyWith<TmdbConfigurationResponse> get copyWith => _$TmdbConfigurationResponseCopyWithImpl<TmdbConfigurationResponse>(this as TmdbConfigurationResponse, _$identity);

  /// Serializes this TmdbConfigurationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TmdbConfigurationResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TmdbConfigurationResponse&&(identical(other.images, _this.images) || other.images == _this.images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TmdbConfigurationResponse;
  return Object.hash(runtimeType,_this.images);
}

@override
String toString() {
  final _this = this as TmdbConfigurationResponse;
  return 'TmdbConfigurationResponse(images: ${_this.images})';
}


}

/// @nodoc
abstract mixin class $TmdbConfigurationResponseCopyWith<$Res>  {
  factory $TmdbConfigurationResponseCopyWith(TmdbConfigurationResponse value, $Res Function(TmdbConfigurationResponse) _then) = _$TmdbConfigurationResponseCopyWithImpl;
@useResult
$Res call({
 TmdbImageConfiguration? images
});


$TmdbImageConfigurationCopyWith<$Res>? get images;

}
/// @nodoc
class _$TmdbConfigurationResponseCopyWithImpl<$Res>
    implements $TmdbConfigurationResponseCopyWith<$Res> {
  _$TmdbConfigurationResponseCopyWithImpl(this._self, this._then);

  final TmdbConfigurationResponse _self;
  final $Res Function(TmdbConfigurationResponse) _then;

/// Create a copy of TmdbConfigurationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = freezed,}) {
  return _then(TmdbConfigurationResponse(
images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as TmdbImageConfiguration?,
  ));
}
/// Create a copy of TmdbConfigurationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TmdbImageConfigurationCopyWith<$Res>? get images {
    if (_self.images == null) {
    return null;
  }

  return $TmdbImageConfigurationCopyWith<$Res>(_self.images!, (value) {
    return _then(_self.copyWith(images: value));
  });
}
}


/// Adds pattern-matching-related methods to [TmdbConfigurationResponse].
extension TmdbConfigurationResponsePatterns on TmdbConfigurationResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TmdbConfigurationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TmdbConfigurationResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TmdbConfigurationResponse value)  $default,){
final _that = this;
switch (_that) {
case _TmdbConfigurationResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TmdbConfigurationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TmdbConfigurationResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TmdbImageConfiguration? images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TmdbConfigurationResponse() when $default != null:
return $default(_that.images);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TmdbImageConfiguration? images)  $default,) {final _that = this;
switch (_that) {
case _TmdbConfigurationResponse():
return $default(_that.images);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TmdbImageConfiguration? images)?  $default,) {final _that = this;
switch (_that) {
case _TmdbConfigurationResponse() when $default != null:
return $default(_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TmdbConfigurationResponse implements TmdbConfigurationResponse {
  const _TmdbConfigurationResponse({this.images});
  factory _TmdbConfigurationResponse.fromJson(Map<String, dynamic> json) => _$TmdbConfigurationResponseFromJson(json);

@override final  TmdbImageConfiguration? images;

/// Create a copy of TmdbConfigurationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TmdbConfigurationResponseCopyWith<_TmdbConfigurationResponse> get copyWith => __$TmdbConfigurationResponseCopyWithImpl<_TmdbConfigurationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TmdbConfigurationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TmdbConfigurationResponse&&(identical(other.images, images) || other.images == images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,images);
}

@override
String toString() {
    return 'TmdbConfigurationResponse(images: $images)';
}


}

/// @nodoc
abstract mixin class _$TmdbConfigurationResponseCopyWith<$Res> implements $TmdbConfigurationResponseCopyWith<$Res> {
  factory _$TmdbConfigurationResponseCopyWith(_TmdbConfigurationResponse value, $Res Function(_TmdbConfigurationResponse) _then) = __$TmdbConfigurationResponseCopyWithImpl;
@override @useResult
$Res call({
 TmdbImageConfiguration? images
});


@override $TmdbImageConfigurationCopyWith<$Res>? get images;

}
/// @nodoc
class __$TmdbConfigurationResponseCopyWithImpl<$Res>
    implements _$TmdbConfigurationResponseCopyWith<$Res> {
  __$TmdbConfigurationResponseCopyWithImpl(this._self, this._then);

  final _TmdbConfigurationResponse _self;
  final $Res Function(_TmdbConfigurationResponse) _then;

/// Create a copy of TmdbConfigurationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = freezed,}) {
  return _then(_TmdbConfigurationResponse(
images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as TmdbImageConfiguration?,
  ));
}

/// Create a copy of TmdbConfigurationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TmdbImageConfigurationCopyWith<$Res>? get images {
    if (_self.images == null) {
    return null;
  }

  return $TmdbImageConfigurationCopyWith<$Res>(_self.images!, (value) {
    return _then(_self.copyWith(images: value));
  });
}
}

// dart format on
