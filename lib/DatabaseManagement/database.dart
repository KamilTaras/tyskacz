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
    try{
      await db.execute('''
      CREATE TABLE Attraction (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        photoURL TEXT,
        description TEXT,
        latitude REAL,
        longitude REAL,
        address TEXT,
        link TEXT
      );'''
      );
    } catch (e) {
      print(e);
      print('attraction');
    }
    try{
      await db.execute('''
      CREATE TABLE Event (
        eventID INTEGER PRIMARY KEY AUTOINCREMENT,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        attractionID INTEGER,
        FOREIGN KEY (attractionID) REFERENCES Attraction(id)
      );'''
      );
    } catch (e) {
      print(e);
      print('event');
    }
    try{
      await db.execute('''
      CREATE TABLE Plan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        tripType INTEGER
      );'''
      );
    } catch (e) {
      print(e);
      print('plan');
    }
    try{
      await db.execute('''
      CREATE TABLE EventList (
        planID INTEGER,
        eventID INTEGER,
        PRIMARY KEY (planID, eventID),
        FOREIGN KEY (planID) REFERENCES Plan(id),
        FOREIGN KEY (eventID) REFERENCES Event(eventID)
      );
    ''');
    } catch (e) {
      print(e);
      print('eventList');
    }

  }

  void getTableNames() async {
    final db = await database;
    List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    List<String> tableNames = tables.map((table) => table['name'] as String).toList();
    print(tableNames);
  }

  static deleteDB() async {
    String path = join(await getDatabasesPath(), 'travel_app.db');
    await deleteDatabase(path);
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
    var planId = await db.insert('Plan', plan.toJson());
    var events = plan.listOfEvents;
    for (Event event in events) {
      var eventId = await db.insert('Event', event.toJson());
      await db.insert('EventList', {'planID': planId, 'eventID': eventId});
    }
  print(getPlans());
  }

  Future<void> updatePlan(Plan plan) async {
    final db = await database;
    await db.update(
      'Plan',
      plan.toJson(),
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }

  Future<void> deletePlan(int planId) async {
    final db = await database;
    await db.delete(
      'Plan',
      where: 'id = ?',
      whereArgs: [planId],
    );
  }

  Future<Plan> addEventToPlan() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Plan');
    Plan plan = Plan.fromJson(maps[0]);
    final List<Map<String, dynamic>> events = await db.query('EventList');
    for (Map<String, dynamic> event in events) {
      final List<Map<String, dynamic>> eventMap = await db.query('Event', where: 'eventID = ?', whereArgs: [event['eventID']]);
      plan.listOfEvents.add(Event.fromJson(eventMap[0]));
    }
    return plan;
  }


  Future<List<Plan>> getPlans() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Plan');
    List<Plan> plans = [];
    for (Map<String, dynamic> map in maps) {
      Plan plan = Plan.fromJson(map);
      final List<Map<String, dynamic>> events = await db.query('EventList');
      for (Map<String, dynamic> event in events) {
        final List<Map<String, dynamic>> eventMap = await db.query('Event', where: 'eventID = ?', whereArgs: [event['eventID']]);
        //handle null
        if(eventMap.isEmpty){
          continue;
        }

        plan.listOfEvents.add(Event.fromJson(eventMap[0]));
      }
      plans.add(plan);
    }
    return plans;
  }

  Future<void> addEvent(Event event) async {
    final db = await database;
    // if(event.attractionWithinEvent.id == null){
    //   await addAttraction(event.attractionWithinEvent);
    // }
    await db.insert('Event', event.toJson());
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