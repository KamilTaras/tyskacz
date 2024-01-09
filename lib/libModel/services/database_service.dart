import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/attraction.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'travel_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Attraction (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        photos TEXT,
        description TEXT,
        latitude REAL,
        longitude REAL,
        location TEXT
      );
    ''');
  }
  // CRUD operations for Attraction
  Future<void> addAttraction(Attraction attraction) async {
    print(attraction.toJson());
    final db = await database;
    await db.insert('attraction', attraction.toJson());
  }

  // Read: Get all attractions
  Future<List<Attraction>> getAttractions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('attraction');

    return List.generate(maps.length, (i) {
      return Attraction(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        location: maps[i]['location'],
        photos: (maps[i]['photos']),
      );
    });
  }

  // Update: Update an attraction
  Future<void> updateAttraction(Attraction attraction) async {
    final db = await database;
    await db.update(
      'attraction',
      attraction.toJson(),
      where: 'id = ?',
      whereArgs: [attraction.id],
    );
  }

  // Delete: Delete an attraction
  Future<void> deleteAttraction(int id) async {
    final db = await database;
    await db.delete(
      'attraction',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
