import 'package:flutter/material.dart';

import 'widgets/sensor_card.dart';
import 'pages/sensor_detail_page.dart';
import 'pages/statistics_page.dart';
import 'viewmodels/dashboard_view_model.dart';
import 'repositories/fake_sensor_repository.dart';

Future<void> main() async {
  final repository = FakeSensorRepository();
  final viewModel = DashboardViewModel(repository: repository);

  await viewModel.load();

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.viewModel, super.key});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(viewModel: viewModel),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.viewModel, super.key});

  final DashboardViewModel viewModel;

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
                MaterialPageRoute(
                  builder: (context) => StatisticsPage(viewModel: viewModel),
                ),
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
                  builder: (context) => SensorDetailPage(
                    viewModel: viewModel,
                    sensorId: sensor.id,
                  ),
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
