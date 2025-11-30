// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthData _$HealthDataFromJson(Map<String, dynamic> json) => _HealthData(
  x: (json['x'] as num).toInt(),
  y: (json['y'] as num).toInt(),
  dt: DateTime.parse(json['dt'] as String),
);

Map<String, dynamic> _$HealthDataToJson(_HealthData instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'dt': instance.dt.toIso8601String(),
    };
