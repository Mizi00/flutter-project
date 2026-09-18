import 'package:freezed_annotation/freezed_annotation.dart';
part 'sensor.freezed.dart';
part 'sensor.g.dart';

@freezed
abstract class Sensor with _$Sensor {
  const factory Sensor({
    required String id,
    required String name,
    required String room,
    required double temperature,
    required double humidity,
    @Default(false) bool isOnline,
    @Default('multi-sensor') String type,
    @Default(100) int batteryLevel,
    DateTime? lastSeen,
  }) = _Sensor;
  factory Sensor.fromJson(Map<String, Object?> json) => _$SensorFromJson(json);
}
