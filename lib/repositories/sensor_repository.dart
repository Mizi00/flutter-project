import '../models/sensor.dart';
import '../models/sensor_summary.dart';

abstract interface class SensorRepository {
  /// Le strict nécessaire pour la liste du dashboard.
  Future<List<SensorSummary>> fetchAll();

  /// Tous les attributs d'un seul capteur.
  Future<Sensor> fetchById(String id);
}
