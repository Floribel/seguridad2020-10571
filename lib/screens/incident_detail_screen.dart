import 'package:flutter/material.dart';
import '../models/incident.dart';
import 'package:audioplayers/audioplayers.dart';

class IncidentDetailScreen extends StatelessWidget {
  final Incident incident;

  IncidentDetailScreen({required this.incident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Incidencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              incident.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(incident.date),
            SizedBox(height: 16),
            Text(incident.description),
            SizedBox(height: 16),
            incident.photo != null ? Image.file(incident.photo!) : Container(),
            SizedBox(height: 16),
            incident.audio != null
                ? IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () async {
                      AudioPlayer audioPlayer = AudioPlayer();
                      await audioPlayer.play(incident.audio!.path,
                          isLocal: true);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
