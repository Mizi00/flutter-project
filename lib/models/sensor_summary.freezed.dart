// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SensorSummary {

 String get id; String get name; String get room; double get temperature; double get humidity; bool get isOnline;
/// Create a copy of SensorSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorSummaryCopyWith<SensorSummary> get copyWith => _$SensorSummaryCopyWithImpl<SensorSummary>(this as SensorSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SensorSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SensorSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.room, _this.room) || other.room == _this.room)&&(identical(other.temperature, _this.temperature) || other.temperature == _this.temperature)&&(identical(other.humidity, _this.humidity) || other.humidity == _this.humidity)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline));
}


@override
int get hashCode {
  final _this = this as SensorSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.room,_this.temperature,_this.humidity,_this.isOnline);
}

@override
String toString() {
  final _this = this as SensorSummary;
  return 'SensorSummary(id: ${_this.id}, name: ${_this.name}, room: ${_this.room}, temperature: ${_this.temperature}, humidity: ${_this.humidity}, isOnline: ${_this.isOnline})';
}


}

/// @nodoc
abstract mixin class $SensorSummaryCopyWith<$Res>  {
  factory $SensorSummaryCopyWith(SensorSummary value, $Res Function(SensorSummary) _then) = _$SensorSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String room, double temperature, double humidity, bool isOnline
});




}
/// @nodoc
class _$SensorSummaryCopyWithImpl<$Res>
    implements $SensorSummaryCopyWith<$Res> {
  _$SensorSummaryCopyWithImpl(this._self, this._then);

  final SensorSummary _self;
  final $Res Function(SensorSummary) _then;

/// Create a copy of SensorSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? room = null,Object? temperature = null,Object? humidity = null,Object? isOnline = null,}) {
  return _then(SensorSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SensorSummary].
extension SensorSummaryPatterns on SensorSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SensorSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SensorSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SensorSummary value)  $default,){
final _that = this;
switch (_that) {
case _SensorSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SensorSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SensorSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String room,  double temperature,  double humidity,  bool isOnline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SensorSummary() when $default != null:
return $default(_that.id,_that.name,_that.room,_that.temperature,_that.humidity,_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String room,  double temperature,  double humidity,  bool isOnline)  $default,) {final _that = this;
switch (_that) {
case _SensorSummary():
return $default(_that.id,_that.name,_that.room,_that.temperature,_that.humidity,_that.isOnline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String room,  double temperature,  double humidity,  bool isOnline)?  $default,) {final _that = this;
switch (_that) {
case _SensorSummary() when $default != null:
return $default(_that.id,_that.name,_that.room,_that.temperature,_that.humidity,_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc


class _SensorSummary implements SensorSummary {
  const _SensorSummary({required this.id, required this.name, required this.room, required this.temperature, required this.humidity, this.isOnline = false});
  

@override final  String id;
@override final  String name;
@override final  String room;
@override final  double temperature;
@override final  double humidity;
@override@JsonKey() final  bool isOnline;

/// Create a copy of SensorSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorSummaryCopyWith<_SensorSummary> get copyWith => __$SensorSummaryCopyWithImpl<_SensorSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SensorSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.room, room) || other.room == room)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,room,temperature,humidity,isOnline);
}

@override
String toString() {
    return 'SensorSummary(id: $id, name: $name, room: $room, temperature: $temperature, humidity: $humidity, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$SensorSummaryCopyWith<$Res> implements $SensorSummaryCopyWith<$Res> {
  factory _$SensorSummaryCopyWith(_SensorSummary value, $Res Function(_SensorSummary) _then) = __$SensorSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String room, double temperature, double humidity, bool isOnline
});




}
/// @nodoc
class __$SensorSummaryCopyWithImpl<$Res>
    implements _$SensorSummaryCopyWith<$Res> {
  __$SensorSummaryCopyWithImpl(this._self, this._then);

  final _SensorSummary _self;
  final $Res Function(_SensorSummary) _then;

/// Create a copy of SensorSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? room = null,Object? temperature = null,Object? humidity = null,Object? isOnline = null,}) {
  return _then(_SensorSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
