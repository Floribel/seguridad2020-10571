import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/incident.dart';
import '../services/database_service.dart';
import 'package:path_provider/path_provider.dart';

class AddIncidentScreen extends StatefulWidget {
  @override
  _AddIncidentScreenState createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _photo;
  File? _audio;
  final DatabaseService _dbService = DatabaseService();

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _photo = File(pickedFile.path);
      });
    }
  }

  void _pickAudio() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.microphone);
    if (pickedFile != null) {
      setState(() {
        _audio = File(pickedFile.path);
      });
    }
  }

  void _saveIncident() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final date = DateTime.now().toIso8601String();

    if (title.isEmpty || description.isEmpty) {
      // Mostrar un mensaje de error si el título o la descripción están vacíos
      return;
    }

    final incident = Incident(
      title: title,
      date: date,
      description: description,
      photo: _photo,
      audio: _audio,
    );

    await _dbService.saveIncident(incident);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Incidencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: _pickAudio,
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveIncident,
              child: Text('Guardar Incidencia'),
            ),
          ],
        ),
      ),
    );
  }
}
