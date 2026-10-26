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
    final viewModel = viewModelWith(
      latency: const Duration(milliseconds: 600),
    );
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
      expect(
        (observed.last as Content<SensorSummary>).values,
        hasLength(10),
      );
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

  test(
    'un listener observe Failure quand le repository échoue',
    () async {
      final viewModel = viewModelWith(shouldFail: true);
      final observed = <AsyncState<SensorSummary>>[];

      viewModel.addListener(() => observed.add(viewModel.state));

      // load() ne relance plus l'erreur : elle devient un état publié.
      await viewModel.load();

      expect(observed.last, isA<Failure<SensorSummary>>());
    },
  );
}
