import 'package:flutter/material.dart';
import 'package:app_test/models/sensor.dart';

class AddSensorPage extends StatefulWidget {
  final Sensor? sensor;

  const AddSensorPage({this.sensor});

  @override
  State<AddSensorPage> createState() => _AddSensorPageState();
}

class _AddSensorPageState extends State<AddSensorPage> {
  late TextEditingController _nameController;
  late TextEditingController _roomController;
  late TextEditingController _temperatureController;
  late TextEditingController _humidityController;
  late bool _isOnline;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sensor?.name ?? '');
    _roomController = TextEditingController(text: widget.sensor?.room ?? '');
    _temperatureController =
        TextEditingController(text: widget.sensor?.temperature.toString() ?? '');
    _humidityController =
        TextEditingController(text: widget.sensor?.humidity.toString() ?? '');
    _isOnline = widget.sensor?.isOnline ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roomController.dispose();
    _temperatureController.dispose();
    _humidityController.dispose();
    super.dispose();
  }

  void _saveSensor() {
    if (_nameController.text.isEmpty ||
        _roomController.text.isEmpty ||
        _temperatureController.text.isEmpty ||
        _humidityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Remplissez tous les champs')),
      );
      return;
    }

    final sensor = Sensor(
      id: widget.sensor?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      room: _roomController.text,
      temperature: double.parse(_temperatureController.text),
      humidity: double.parse(_humidityController.text),
      isOnline: _isOnline,
    );

    Navigator.pop(context, sensor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sensor != null ? 'Éditer' : 'Ajouter'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField('Nom', _nameController),
            const SizedBox(height: 16),
            _buildTextField('Pièce', _roomController),
            const SizedBox(height: 16),
            _buildTextField('Température (°C)', _temperatureController),
            const SizedBox(height: 16),
            _buildTextField('Humidité (%)', _humidityController),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('En ligne'),
              value: _isOnline,
              onChanged: (value) {
                setState(() {
                  _isOnline = value;
                });
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _saveSensor,
                child: Text(
                  widget.sensor != null ? 'Mettre à jour' : 'Ajouter',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
