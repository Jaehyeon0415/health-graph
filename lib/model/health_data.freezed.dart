// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HealthData {

 int get x; int get y; DateTime get dt;
/// Create a copy of HealthData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthDataCopyWith<HealthData> get copyWith => _$HealthDataCopyWithImpl<HealthData>(this as HealthData, _$identity);

  /// Serializes this HealthData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthData&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.dt, dt) || other.dt == dt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,dt);

@override
String toString() {
  return 'HealthData(x: $x, y: $y, dt: $dt)';
}


}

/// @nodoc
abstract mixin class $HealthDataCopyWith<$Res>  {
  factory $HealthDataCopyWith(HealthData value, $Res Function(HealthData) _then) = _$HealthDataCopyWithImpl;
@useResult
$Res call({
 int x, int y, DateTime dt
});




}
/// @nodoc
class _$HealthDataCopyWithImpl<$Res>
    implements $HealthDataCopyWith<$Res> {
  _$HealthDataCopyWithImpl(this._self, this._then);

  final HealthData _self;
  final $Res Function(HealthData) _then;

/// Create a copy of HealthData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? dt = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthData].
extension HealthDataPatterns on HealthData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthData value)  $default,){
final _that = this;
switch (_that) {
case _HealthData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthData value)?  $default,){
final _that = this;
switch (_that) {
case _HealthData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int x,  int y,  DateTime dt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthData() when $default != null:
return $default(_that.x,_that.y,_that.dt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int x,  int y,  DateTime dt)  $default,) {final _that = this;
switch (_that) {
case _HealthData():
return $default(_that.x,_that.y,_that.dt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int x,  int y,  DateTime dt)?  $default,) {final _that = this;
switch (_that) {
case _HealthData() when $default != null:
return $default(_that.x,_that.y,_that.dt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthData implements HealthData {
  const _HealthData({required this.x, required this.y, required this.dt});
  factory _HealthData.fromJson(Map<String, dynamic> json) => _$HealthDataFromJson(json);

@override final  int x;
@override final  int y;
@override final  DateTime dt;

/// Create a copy of HealthData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthDataCopyWith<_HealthData> get copyWith => __$HealthDataCopyWithImpl<_HealthData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthData&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.dt, dt) || other.dt == dt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,dt);

@override
String toString() {
  return 'HealthData(x: $x, y: $y, dt: $dt)';
}


}

/// @nodoc
abstract mixin class _$HealthDataCopyWith<$Res> implements $HealthDataCopyWith<$Res> {
  factory _$HealthDataCopyWith(_HealthData value, $Res Function(_HealthData) _then) = __$HealthDataCopyWithImpl;
@override @useResult
$Res call({
 int x, int y, DateTime dt
});




}
/// @nodoc
class __$HealthDataCopyWithImpl<$Res>
    implements _$HealthDataCopyWith<$Res> {
  __$HealthDataCopyWithImpl(this._self, this._then);

  final _HealthData _self;
  final $Res Function(_HealthData) _then;

/// Create a copy of HealthData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? dt = null,}) {
  return _then(_HealthData(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
