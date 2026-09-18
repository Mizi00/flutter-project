import 'package:flutter/material.dart';
import 'package:app_test/viewmodels/dashboard_view_model.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({required this.viewModel, super.key});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total capteurs: ${viewModel.sensorCount}'),
            Text('En ligne: ${viewModel.onlineCount}'),
            Text('Hors ligne: ${viewModel.sensors.length - viewModel.onlineCount}'),
            Text('Température moyenne: ${viewModel.averageTemperature.toStringAsFixed(1)}°C'),
            Text('Humidité moyenne: ${viewModel.averageHumidity.toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }
}
