import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/incident.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'incidents.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE incidents(id INTEGER PRIMARY KEY, title TEXT, date TEXT, description TEXT, photo TEXT, audio TEXT)',
        );
      },
    );
  }

  Future<void> saveIncident(Incident incident) async {
    final db = await database;
    await db.insert(
      'incidents',
      incident.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Incident>> getIncidents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('incidents');
    return List.generate(maps.length, (i) {
      return Incident.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllIncidents() async {
    final db = await database;
    await db.delete('incidents');
  }
}
