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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('ID', sensor.id),
                    const SizedBox(height: 16),
                    _buildDetailRow('Pièce', sensor.room),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Température',
                      '${sensor.temperature}°C',
                      valueColor: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Humidité',
                      '${sensor.humidity}%',
                      valueColor: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Statut: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        sensor.isOnline
                            ? const Chip(
                                label: Text('En ligne'),
                                backgroundColor: Colors.green,
                              )
                            : const Chip(
                                label: Text('Hors ligne'),
                                backgroundColor: Colors.red,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
