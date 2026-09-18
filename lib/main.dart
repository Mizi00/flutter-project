import 'package:flutter/material.dart';

import 'models/sensor.dart';
import 'widgets/sensor_card.dart';
import 'pages/sensor_detail_page.dart';
import 'pages/statistics_page.dart';
import 'viewmodels/dashboard_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final viewModel = DashboardViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Capteurs'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatisticsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.sensors.length,
        itemBuilder: (context, index) {
          final sensor = viewModel.sensors[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SensorDetailPage(sensor: sensor),
                ),
              );
            },
            child: SensorCard(sensor: sensor),
          );
        },
      ),
    );
  }
}
