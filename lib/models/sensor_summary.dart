import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_summary.freezed.dart';

/// Ce que la liste du dashboard a besoin d'afficher.
/// Les attributs restants ne sont chargés que par [SensorRepository.fetchById].
@freezed
abstract class SensorSummary with _$SensorSummary {
  const factory SensorSummary({
    required String id,
    required String name,
    required String room,
    required double temperature,
    required double humidity,
    @Default(false) bool isOnline,
  }) = _SensorSummary;
}
