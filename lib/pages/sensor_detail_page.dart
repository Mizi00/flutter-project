import 'package:flutter/material.dart';
import 'package:app_test/models/sensor.dart';
import 'package:app_test/viewmodels/dashboard_view_model.dart';

class SensorDetailPage extends StatefulWidget {
  const SensorDetailPage({
    required this.viewModel,
    required this.sensorId,
    super.key,
  });

  final DashboardViewModel viewModel;
  final String sensorId;

  @override
  State<SensorDetailPage> createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends State<SensorDetailPage> {
  late final Future<Sensor> _sensor;

  @override
  void initState() {
    super.initState();
    _sensor = widget.viewModel.fetchSensorById(widget.sensorId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sensor>(
      future: _sensor,
      builder: (context, snapshot) {
        final sensor = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(sensor?.name ?? 'Chargement…'),
          ),
          body: _body(snapshot),
        );
      },
    );
  }

  Widget _body(AsyncSnapshot<Sensor> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Impossible de charger ce capteur.\n${snapshot.error}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return _content(snapshot.data!);
  }

  Widget _content(Sensor sensor) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: sensor.isOnline
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.errorContainer,
          child: ListTile(
            leading: Icon(
              sensor.isOnline ? Icons.cloud_done : Icons.cloud_off,
            ),
            title: Text(sensor.isOnline ? 'En ligne' : 'Hors ligne'),
            subtitle: Text('Vu le ${_formatDate(sensor.lastSeen)}'),
          ),
        ),
        _group(theme, 'Identification', {
          'ID': sensor.id,
          'Type': sensor.type,
          'Pièce': sensor.room,
        }),
        _group(theme, 'Mesures', {
          'Température': '${sensor.temperature} °C',
          'Humidité': '${sensor.humidity} %',
        }),
        _group(theme, 'Appareil', {
          'Batterie': '${sensor.batteryLevel} %',
        }),
      ],
    );
  }

  Widget _group(ThemeData theme, String title, Map<String, String> rows) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const Divider(),
            for (final entry in rows.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key, style: theme.textTheme.bodyMedium),
                    Text(entry.value, style: theme.textTheme.bodyLarge),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'jamais';

    final local = date.toLocal();
    String two(int value) => value.toString().padLeft(2, '0');

    return '${two(local.day)}/${two(local.month)}/${local.year} '
        'à ${two(local.hour)}:${two(local.minute)}';
  }
}
