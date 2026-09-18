import '../models/sensor.dart';
import '../models/sensor_summary.dart';
import 'sensor_repository.dart';

class FakeSensorRepository implements SensorRepository {
  const FakeSensorRepository({
    this.latency = const Duration(milliseconds: 800),
    this.shouldFail = false,
    this.sensors,
  });

  final Duration latency;
  final bool shouldFail;
  final List<Sensor>? sensors;

  @override
  Future<List<SensorSummary>> fetchAll() async {
    await Future.delayed(latency);

    if (shouldFail) {
      throw Exception('Impossible de récupérer les capteurs');
    }

    return [
      for (final sensor in sensors ?? _knownSensors)
        SensorSummary(
          id: sensor.id,
          name: sensor.name,
          room: sensor.room,
          temperature: sensor.temperature,
          humidity: sensor.humidity,
          isOnline: sensor.isOnline,
        ),
    ];
  }

  @override
  Future<Sensor> fetchById(String id) async {
    await Future.delayed(latency);

    if (shouldFail) {
      throw Exception('Impossible de récupérer le capteur $id');
    }

    return (sensors ?? _knownSensors).firstWhere(
      (sensor) => sensor.id == id,
      orElse: () => throw Exception('Aucun capteur avec l\'id $id'),
    );
  }

  static final _knownSensors = <Sensor>[
    Sensor(
      id: '1',
      name: 'Salon',
      room: 'Living Room',
      temperature: 22.5,
      humidity: 45.0,
      isOnline: true,
      type: 'multi-sensor',
      batteryLevel: 87,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 58),
    ),
    Sensor(
      id: '2',
      name: 'Chambre',
      room: 'Bedroom',
      temperature: 20.0,
      humidity: 50.0,
      isOnline: false,
      type: 'temperature',
      batteryLevel: 12,
      lastSeen: DateTime.utc(2026, 9, 18, 13, 22),
    ),
    Sensor(
      id: '3',
      name: 'Cuisine',
      room: 'Kitchen',
      temperature: 24.5,
      humidity: 55.0,
      isOnline: true,
      type: 'smoke-detector',
      batteryLevel: 78,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 59),
    ),
    Sensor(
      id: '4',
      name: 'Salle de bain',
      room: 'Bathroom',
      temperature: 23.1,
      humidity: 72.0,
      isOnline: true,
      type: 'humidity',
      batteryLevel: 65,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 57),
    ),
    Sensor(
      id: '5',
      name: 'Bureau',
      room: 'Office',
      temperature: 21.4,
      humidity: 48.0,
      isOnline: true,
      type: 'air-quality',
      batteryLevel: 95,
      lastSeen: DateTime.utc(2026, 9, 18, 16, 0),
    ),
    Sensor(
      id: '6',
      name: 'Garage',
      room: 'Garage',
      temperature: 16.8,
      humidity: 38.0,
      isOnline: true,
      type: 'temperature',
      batteryLevel: 54,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 51),
    ),
    Sensor(
      id: '7',
      name: 'Entrée',
      room: 'Hallway',
      temperature: 19.2,
      humidity: 47.0,
      isOnline: true,
      type: 'door-window',
      batteryLevel: 81,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 59),
    ),
    Sensor(
      id: '8',
      name: 'Cave',
      room: 'Basement',
      temperature: 14.5,
      humidity: 78.0,
      isOnline: true,
      type: 'flood',
      batteryLevel: 43,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 44),
    ),
    Sensor(
      id: '9',
      name: 'Terrasse',
      room: 'Outdoor',
      temperature: 12.3,
      humidity: 61.0,
      isOnline: false,
      type: 'weather',
      batteryLevel: 0,
    ),
    Sensor(
      id: '10',
      name: 'Grenier',
      room: 'Attic',
      temperature: 28.7,
      humidity: 33.0,
      isOnline: true,
      type: 'temperature',
      batteryLevel: 22,
      lastSeen: DateTime.utc(2026, 9, 18, 15, 38),
    ),
  ];
}
