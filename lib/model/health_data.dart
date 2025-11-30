import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_data.freezed.dart';
part 'health_data.g.dart';

@freezed
 abstract class HealthData with _$HealthData {
  const factory HealthData({
    required int x,
    required int y,
    required DateTime dt,
  }) = _HealthData;

  factory HealthData.fromJson(Map<String, dynamic> json) => _$HealthDataFromJson(json);
}
