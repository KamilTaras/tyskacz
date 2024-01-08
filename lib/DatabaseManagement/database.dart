import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../DatabaseManagement/attractionInformation.dart';
import '../DatabaseManagement/planInformation.dart';

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
      CREATE TABLE Event (
        eventID INTEGER PRIMARY KEY AUTOINCREMENT,
        dateStart TEXT NOT NULL,
        dateEnd TEXT NOT NULL,
        attractionID INTEGER,
        FOREIGN KEY (attractionID) REFERENCES Attraction(id)
      );
      CREATE TABLE Plan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        tripType INTEGER
      );
      CREATE TABLE EventList (
        planID INTEGER,
        eventID INTEGER,
        PRIMARY KEY (planID, eventID),
        FOREIGN KEY (planID) REFERENCES Plan(id),
        FOREIGN KEY (eventID) REFERENCES Event(eventID)
      );
    ''');
    print("Database created");
    await db.execute(
        'INSERT INTO Attraction (title, photos, description, latitude, longitude, location) VALUES ("Wawel Castle", "https://www.w3schools.com/w3css/img_lights.jpg", "Wawel Castle is a castle residency located in central Kraków, Poland. Built at the behest of King Casimir III the Great, it consists of a number of structures situated around the Italian-styled main courtyard.", 50.0547, 19.9355, "Wawel 5, 31-001 Kraków, Poland")'
    );
    print(getAttractions());
  }


  // CRUD operations for Attraction
  Future<void> addAttraction(Attraction attraction) async {
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
        name: maps[i]['name'],
        description: maps[i]['description'],
        coordinates: LatLng(maps[i]['latitude'], maps[i]['longitude']),
        photoURL: maps[i]['photoURL'],
        review: maps[i]['review'],
        link: maps[i]['link'],
        address: maps[i]['address'],
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


  Future<void> addPlan(Plan plan) async {
    final db = await database;
    await db.insert('Plan', plan.toJson());
  }

  Future<void> deleteItem(int itemId) async {
    final db = await database;
    await db.delete(
      'Item',
      where: 'itemID = ?',
      whereArgs: [itemId],
    );

  }

  Future<List<Plan>> getPlans() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Plan');

    return List.generate(maps.length, (i) {
      return Plan.fromJson(maps[i]);
    });
  }

  Future<void> deleteEvent(int eventId) async {
    final db = await database;
    await db.delete(
      'Event',
      where: 'eventID = ?',
      whereArgs: [eventId],
    );
  }
// Other CRUD operations...
}