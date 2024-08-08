import 'package:flutter/material.dart';
import 'incident_detail_screen.dart';
import 'add_incident_screen.dart';
import 'about_screen.dart';
import '../models/incident.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Incident> _incidents = [];

  @override
  void initState() {
    super.initState();
    _loadIncidents();
  }

  void _loadIncidents() async {
    List<Incident> incidents = await _dbService.getIncidents();
    setState(() {
      _incidents = incidents;
    });
  }

  void _addIncident() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIncidentScreen()),
    );
    _loadIncidents();
  }

  void _deleteAllIncidents() async {
    await _dbService.deleteAllIncidents();
    _loadIncidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incidencias'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteAllIncidents,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _incidents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_incidents[index].title),
            subtitle: Text(_incidents[index].date),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      IncidentDetailScreen(incident: _incidents[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addIncident,
        child: Icon(Icons.add),
      ),
    );
  }
}
