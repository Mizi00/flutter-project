import 'package:flutter/material.dart';
import 'package:app_test/models/sensor.dart';

class SensorDetailPage extends StatelessWidget {
  final Sensor sensor;

  const SensorDetailPage({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sensor.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${sensor.id}'),
            Text('Pièce: ${sensor.room}'),
            Text('Température: ${sensor.temperature}°C'),
            Text('Humidité: ${sensor.humidity}%'),
            Text('Statut: ${sensor.isOnline ? 'En ligne' : 'Hors ligne'}'),
          ],
        ),
      ),
    );
  }
}
