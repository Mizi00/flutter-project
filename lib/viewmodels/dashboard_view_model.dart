import 'package:app_test/models/sensor.dart';

class DashboardViewModel {
  final List<Sensor> _sensors = [
    Sensor(
      id: '1',
      name: 'Salon',
      room: 'Living Room',
      temperature: 22.5,
      humidity: 45.0,
      isOnline: true,
    ),
    Sensor(
      id: '2',
      name: 'Chambre',
      room: 'Bedroom',
      temperature: 20.0,
      humidity: 50.0,
      isOnline: false,
    ),
    Sensor(
      id: '3',
      name: 'Cuisine',
      room: 'Kitchen',
      temperature: 24.5,
      humidity: 55.0,
      isOnline: true,
    ),
  ];

  // Getter pour accéder à la liste (lecture seule)
  List<Sensor> get sensors => _sensors;

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
