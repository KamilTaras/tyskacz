import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/attraction.dart';
import '../models/plan.dart';

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
