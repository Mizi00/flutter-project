import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_test/main.dart';
import 'package:app_test/models/sensor_summary.dart';
import 'package:app_test/repositories/fake_sensor_repository.dart';
import 'package:app_test/viewmodels/async_state.dart';
import 'package:app_test/viewmodels/dashboard_view_model.dart';

void main() {
  DashboardViewModel viewModelWith({
    Duration latency = Duration.zero,
    bool shouldFail = false,
  }) {
    return DashboardViewModel(
      repository: FakeSensorRepository(
        latency: latency,
        shouldFail: shouldFail,
      ),
    );
  }

  testWidgets('le dashboard affiche les données du Fake Repository', (
    tester,
  ) async {
    final viewModel = viewModelWith();
    // Sous testWidgets l'horloge est simulée : runAsync donne de vrais
    // timers, sans quoi le Future.delayed du Fake ne se résout jamais.
    await tester.runAsync(() => viewModel.load());

    await tester.pumpWidget(MyApp(viewModel: viewModel));

    expect(find.text('Salon'), findsOneWidget);
    expect(find.text('Chambre'), findsOneWidget);
    expect(find.text('Cuisine'), findsOneWidget);
  });

  testWidgets('cliquer un capteur affiche un chargement puis le détail', (
    tester,
  ) async {
    final viewModel = viewModelWith(latency: const Duration(milliseconds: 600));
    await tester.runAsync(() => viewModel.load());

    await tester.pumpWidget(MyApp(viewModel: viewModel));
    await tester.tap(find.text('Salon'));
    // Une frame lance la transition, la suivante construit la page poussée.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    // 'multi-sensor' n'existe que sur le Sensor complet, donc il prouve
    // que fetchById a bien été appelé.
    expect(find.text('multi-sensor'), findsOneWidget);
  });

  test('fetchById renvoie tous les attributs du capteur', () async {
    final sensor = await viewModelWith().fetchSensorById('1');

    expect(sensor.name, 'Salon');
    expect(sensor.type, 'multi-sensor');
    expect(sensor.batteryLevel, 87);
    expect(sensor.lastSeen, isNotNull);
  });

  test('fetchById échoue pour un id inconnu', () async {
    await expectLater(
      viewModelWith().fetchSensorById('inconnu'),
      throwsException,
    );
  });

  test(
    'un listener observe Loading puis Content, sans Provider ni widget',
    () async {
      final viewModel = viewModelWith();
      final observed = <AsyncState<SensorSummary>>[];

      expect(viewModel.state, isA<Loading<SensorSummary>>());
      viewModel.addListener(() => observed.add(viewModel.state));

      await viewModel.load();

      expect(observed.first, isA<Loading<SensorSummary>>());
      expect(observed.last, isA<Content<SensorSummary>>());
      expect((observed.last as Content<SensorSummary>).values, hasLength(10));
    },
  );

  testWidgets(
    'le dashboard affiche le spinner puis le contenu, comme dans main()',
    (tester) async {
      final viewModel = viewModelWith(
        latency: const Duration(milliseconds: 800),
      );

      // Reproduit exactement le flux de main() : load() lancé sans être
      // attendu, puis construction du widget pendant que ça charge.
      viewModel.load();
      await tester.pumpWidget(MyApp(viewModel: viewModel));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 900));

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Salon'), findsOneWidget);
    },
  );

  test('un listener observe Failure quand le repository échoue', () async {
    final viewModel = viewModelWith(shouldFail: true);
    final observed = <AsyncState<SensorSummary>>[];

    viewModel.addListener(() => observed.add(viewModel.state));

    // load() ne relance plus l'erreur : elle devient un état publié.
    await viewModel.load();

    expect(observed.last, isA<Failure<SensorSummary>>());
  });

  test('échec puis nouvelle tentative avec la même instance', () async {
    final repository = FakeSensorRepository(
      latency: Duration.zero,
      failFirstLoads: 1,
    );
    final viewModel = DashboardViewModel(repository: repository);

    await viewModel.load();
    expect(viewModel.state, isA<Failure<SensorSummary>>());

    await viewModel.load();
    expect(viewModel.state, isA<Content<SensorSummary>>());
    expect(repository.loadCount, 2);
  });

  test('des load() rapides ne lancent qu\'un seul chargement', () async {
    final repository = FakeSensorRepository(
      latency: const Duration(milliseconds: 50),
    );
    final viewModel = DashboardViewModel(repository: repository);

    await Future.wait([viewModel.load(), viewModel.load(), viewModel.load()]);
    expect(repository.loadCount, 1);

    // Terminé : une nouvelle actualisation redevient possible.
    await viewModel.load();
    expect(repository.loadCount, 2);
  });

  test('la dernière réussite survit à une erreur', () async {
    var now = DateTime(2026, 1, 1, 10, 0, 0);
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(
        latency: Duration.zero,
        sensors: const [],
      ),
      clock: () => now,
    );
    expect(viewModel.lastRefreshLabel, 'Aucune actualisation réussie');

    await viewModel.load();
    expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 10:00:00');

    final failing = DashboardViewModel(
      repository: FakeSensorRepository(
        latency: Duration.zero,
        failFirstLoads: 1,
      ),
      clock: () => now,
    );
    await failing.load();
    expect(failing.lastRefreshLabel, 'Aucune actualisation réussie');
    now = DateTime(2026, 1, 1, 10, 5, 0);
    await failing.load();
    expect(failing.lastRefreshLabel, 'Dernière actualisation : 10:05:00');
  });

  test('une erreur après un succès conserve l\'heure du succès', () async {
    var now = DateTime(2026, 1, 1, 10, 0, 0);
    final repository = _FlakyRepository();
    final viewModel = DashboardViewModel(
      repository: repository,
      clock: () => now,
    );

    await viewModel.load();
    now = DateTime(2026, 1, 1, 10, 9, 0);
    repository.fail = true;
    await viewModel.load();

    expect(viewModel.state, isA<Failure<SensorSummary>>());
    expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 10:00:00');
  });
}

class _FlakyRepository extends FakeSensorRepository {
  _FlakyRepository() : super(latency: Duration.zero);

  bool fail = false;

  @override
  Future<List<SensorSummary>> fetchAll() async {
    if (fail) throw Exception('panne');
    return super.fetchAll();
  }
}
