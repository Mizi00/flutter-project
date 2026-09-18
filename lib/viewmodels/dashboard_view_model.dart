import 'package:app_test/models/sensor.dart';
import 'package:app_test/models/sensor_summary.dart';

import '../repositories/sensor_repository.dart';

class DashboardViewModel {
  DashboardViewModel({required SensorRepository repository})
      : _repository = repository;

  final SensorRepository _repository;

  List<SensorSummary> _sensors = [];

  // Getter pour accéder à la liste (lecture seule)
  List<SensorSummary> get sensors => List.unmodifiable(_sensors);

  Future<void> load() async {
    _sensors = await _repository.fetchAll();
  }

  // Tous les attributs d'un capteur, chargés à la demande depuis son id
  Future<Sensor> fetchSensorById(String id) => _repository.fetchById(id);

  // Nombre total de capteurs
  int get sensorCount => _sensors.length;

  // Nombre de capteurs en ligne
  int get onlineCount => _sensors.where((s) => s.isOnline).length;

  // Vrai s'il y a au moins un capteur hors ligne
  bool get hasOfflineSensors => _sensors.any((s) => !s.isOnline);

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
