import 'package:flutter/foundation.dart';

import 'package:app_test/models/sensor.dart';
import 'package:app_test/models/sensor_summary.dart';

import '../repositories/sensor_repository.dart';
import 'async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({
    required SensorRepository repository,
    DateTime Function() clock = DateTime.now,
  }) : _repository = repository,
       _clock = clock;

  final SensorRepository _repository;
  final DateTime Function() _clock;

  DateTime? _lastSuccessfulRefresh;

  AsyncState<SensorSummary> _state = const Loading<SensorSummary>();

  // Lisible depuis l'extérieur, mais seul _setState peut le remplacer.
  AsyncState<SensorSummary> get state => _state;

  void _setState(AsyncState<SensorSummary> value) {
    _state = value;
    notifyListeners();
  }

  bool get isLoading => _state is Loading<SensorSummary>;

  // Heure du dernier chargement réussi ; une erreur ne la modifie pas.
  DateTime? get lastSuccessfulRefresh => _lastSuccessfulRefresh;

  // Texte prêt à afficher : la View ne formate rien.
  String get lastRefreshLabel {
    final time = _lastSuccessfulRefresh;
    if (time == null) return 'Aucune actualisation réussie';
    String two(int n) => n.toString().padLeft(2, '0');
    return 'Dernière actualisation : ${two(time.hour)}:${two(time.minute)}:${two(time.second)}';
  }

  Future<void> load() async {
    // Un seul chargement à la fois : les appels pendant Loading sont ignorés.
    if (_loadInFlight) return;
    _loadInFlight = true;
    _setState(const Loading<SensorSummary>());
    try {
      final sensors = await _repository.fetchAll();
      _lastSuccessfulRefresh = _clock();
      _setState(Content<SensorSummary>(sensors));
    } catch (error) {
      _setState(Failure<SensorSummary>('$error'));
    } finally {
      _loadInFlight = false;
    }
  }

  bool _loadInFlight = false;

  // Tous les attributs d'un capteur, chargés à la demande depuis son id
  Future<Sensor> fetchSensorById(String id) => _repository.fetchById(id);

  List<SensorSummary> get _sensors => switch (_state) {
    Content<SensorSummary>(:final values) => values,
    Loading<SensorSummary>() || Failure<SensorSummary>() => const [],
  };

  // Nombre total de capteurs
  int get sensorCount => _sensors.length;

  // Nombre de capteurs en ligne
  int get onlineCount => _sensors.where((s) => s.isOnline).length;

  // Nombre de capteurs hors ligne
  int get offlineCount => sensorCount - onlineCount;

  // Température moyenne
  double get averageTemperature => _sensors.isEmpty
      ? 0
      : _sensors.map((s) => s.temperature).reduce((a, b) => a + b) /
            _sensors.length;

  // Humidité moyenne
  double get averageHumidity => _sensors.isEmpty
      ? 0
      : _sensors.map((s) => s.humidity).reduce((a, b) => a + b) /
            _sensors.length;
}
