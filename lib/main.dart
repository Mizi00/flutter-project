import 'dart:async';

import 'package:flutter/material.dart';

import 'models/sensor_summary.dart';
import 'widgets/sensor_card.dart';
import 'pages/sensor_detail_page.dart';
import 'pages/statistics_page.dart';
import 'viewmodels/async_state.dart';
import 'viewmodels/dashboard_view_model.dart';
import 'repositories/fake_sensor_repository.dart';

void main() {
  // Démo : 1er chargement en erreur, puis réponses lentes (3 s).
  final repository = FakeSensorRepository(
    latency: const Duration(seconds: 3),
    failFirstLoads: 1,
  );
  final viewModel = DashboardViewModel(repository: repository);

  // Non attendu : la View affiche l'état Loading pendant le chargement
  // au lieu de figer le démarrage de l'app.
  unawaited(viewModel.load());

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
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Mes Capteurs'),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                tooltip: 'Actualiser',
                icon: const Icon(Icons.refresh),
                onPressed: viewModel.isLoading ? null : viewModel.load,
              ),
              IconButton(
                icon: const Icon(Icons.analytics),
                onPressed: state is Content<SensorSummary>
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatisticsPage(viewModel: viewModel),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  state is Loading<SensorSummary>
                      ? 'Actualisation en cours…'
                      : viewModel.lastRefreshLabel,
                ),
              ),
              Expanded(child: _body(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, AsyncState<SensorSummary> state) {
    return switch (state) {
      Loading<SensorSummary>() => const Center(
        child: CircularProgressIndicator(),
      ),
      Content<SensorSummary>(values: []) => const Center(
        child: Text('Aucun capteur'),
      ),
      Content<SensorSummary>(:final values) => ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          final sensor = values[index];
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
      Failure<SensorSummary>(:final message) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Erreur : $message', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: viewModel.load,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    };
  }
}
