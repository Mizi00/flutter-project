// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sensor _$SensorFromJson(Map<String, dynamic> json) => _Sensor(
  id: json['id'] as String,
  name: json['name'] as String,
  room: json['room'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  humidity: (json['humidity'] as num).toDouble(),
  isOnline: json['isOnline'] as bool? ?? false,
  type: json['type'] as String? ?? 'multi-sensor',
  batteryLevel: (json['batteryLevel'] as num?)?.toInt() ?? 100,
  lastSeen: json['lastSeen'] == null
      ? null
      : DateTime.parse(json['lastSeen'] as String),
);

Map<String, dynamic> _$SensorToJson(_Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'room': instance.room,
  'temperature': instance.temperature,
  'humidity': instance.humidity,
  'isOnline': instance.isOnline,
  'type': instance.type,
  'batteryLevel': instance.batteryLevel,
  'lastSeen': instance.lastSeen?.toIso8601String(),
};
