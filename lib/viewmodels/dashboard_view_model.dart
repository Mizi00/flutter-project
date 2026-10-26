import 'package:flutter/foundation.dart';

import 'package:app_test/models/sensor.dart';
import 'package:app_test/models/sensor_summary.dart';

import '../repositories/sensor_repository.dart';
import 'async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required SensorRepository repository})
      : _repository = repository;

  final SensorRepository _repository;

  AsyncState<SensorSummary> _state = const Loading<SensorSummary>();

  // Lisible depuis l'extérieur, mais seul _setState peut le remplacer.
  AsyncState<SensorSummary> get state => _state;

  void _setState(AsyncState<SensorSummary> value) {
    _state = value;
    notifyListeners();
  }

  Future<void> load() async {
    _setState(const Loading<SensorSummary>());
    try {
      final sensors = await _repository.fetchAll();
      _setState(Content<SensorSummary>(sensors));
    } catch (error) {
      _setState(Failure<SensorSummary>('$error'));
    }
  }

  // Tous les attributs d'un capteur, chargés à la demande depuis son id
  Future<Sensor> fetchSensorById(String id) => _repository.fetchById(id);

  List<SensorSummary> get _sensors => switch (_state) {
        Content<SensorSummary>(:final values) => values,
        Loading<SensorSummary>() || Failure<SensorSummary>() => const [],
      };

  // Nombre total de capteurs
  int get sensorCount => _sensors.length;

  // Nombre de capteurs en ligne
  int get onlineCount => _sensors.where((s) => s.isOnline).length;

  // Nombre de capteurs hors ligne
  int get offlineCount => sensorCount - onlineCount;

  // Température moyenne
  double get averageTemperature =>
      _sensors.isEmpty
          ? 0
          : _sensors.map((s) => s.temperature).reduce((a, b) => a + b) /
              _sensors.length;

  // Humidité moyenne
  double get averageHumidity =>
      _sensors.isEmpty
          ? 0
          : _sensors.map((s) => s.humidity).reduce((a, b) => a + b) /
              _sensors.length;
}
