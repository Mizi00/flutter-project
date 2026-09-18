import 'package:flutter/material.dart';
import 'package:app_test/models/sensor_summary.dart';

class SensorCard extends StatelessWidget {
  final SensorSummary sensor;

  const SensorCard({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Colonne avec les infos
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sensor.name),
                Text('Température: ${sensor.temperature}°C'),
                Text('Humidité: ${sensor.humidity}%'),
              ],
            ),
            // Icône si hors ligne
            if (!sensor.isOnline) Icon(Icons.cloud_off, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
