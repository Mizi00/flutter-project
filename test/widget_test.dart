import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_test/main.dart';
import 'package:app_test/repositories/fake_sensor_repository.dart';
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

  test('le Fake déclenche une erreur à la demande', () async {
    await expectLater(
      viewModelWith(shouldFail: true).load(),
      throwsException,
    );
  });
}
