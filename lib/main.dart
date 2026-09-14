import 'package:flutter/material.dart';

import 'models/sensor.dart';
import 'widgets/sensor_card.dart';
import 'pages/sensor_detail_page.dart';

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
  final sensors = [
    Sensor(
      id: '1',
      name: 'Salon',
      room: 'Living Room',
      temperature: 22.5,
      humidity: 45.0,
      isOnline: true,
    ),
    Sensor(
      id: '2',
      name: 'Chambre',
      room: 'Bedroom',
      temperature: 20.0,
      humidity: 50.0,
      isOnline: false,
    ),
    Sensor(
      id: '3',
      name: 'Cuisine',
      room: 'Kitchen',
      temperature: 24.5,
      humidity: 55.0,
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Capteurs'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: sensors.length,
        itemBuilder: (context, index) {
          final sensor = sensors[index];
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
