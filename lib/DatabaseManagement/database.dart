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
        name TEXT NOT NULL,
        photoURL TEXT,
        description TEXT,
        latitude REAL,
        longitude REAL,
        address TEXT,
        link TEXT
      );'''
      );


      await db.execute('''
      CREATE TABLE Event (
        eventID INTEGER PRIMARY KEY AUTOINCREMENT,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        attractionID INTEGER,
        FOREIGN KEY (attractionID) REFERENCES Attraction(id)
      );'''
      );


      await db.execute('''
      CREATE TABLE Plan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        tripType INTEGER
      );'''
      );

      await db.execute('''
      CREATE TABLE EventList (
        planID INTEGER,
        eventID INTEGER,
        PRIMARY KEY (planID, eventID),
        FOREIGN KEY (planID) REFERENCES Plan(id),
        FOREIGN KEY (eventID) REFERENCES Event(eventID)
      );
    ''');
  }

  void getTableNames() async {
    final db = await database;
    List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    List<String> tableNames = tables.map((table) => table['name'] as String).toList();
  }

  static deleteDB() async {
    String path = join(await getDatabasesPath(), 'travel_app.db');
    await deleteDatabase(path);
  }

  // CRUD operations for Attraction
  Future<void> addAttraction(Attraction attraction) async {
    final db = await database;
    var id = await db.insert('attraction', attraction.toJson());
    attraction.id=id;
  }

  // Read: Get all attractions
  Future<List<Attraction>> getAttractions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('attraction');

    return List.generate(maps.length, (i) {
      return Attraction.fromJson(maps[i]);
    });
  }

  Future<Attraction> getAttraction(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('attraction', where: 'id = ?', whereArgs: [id]);
    return Attraction.fromJson(maps[0]);
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
    plan.id=planId;
    var events = plan.listOfEvents;
    for (Event event in events) {
      addEventToPlan(planId, event);
    }
  }

  Future<List<Event>> getPlanEvents(int planId) async {
    final db = await database;
    final List<Map<String, dynamic>> events = await db.query('EventList', where: 'planID = ?', whereArgs: [planId]);
    List<Event> listOfEvents = [];
    for (Map<String, dynamic> event in events) {
      getEvent(event['eventID']);
      listOfEvents.add(await getEvent(event['eventID']));
    }
    return listOfEvents;
  }


  Future<List<Plan>> getPlans() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Plan');
    List<Plan> plans = [];
    for (Map<String, dynamic> map in maps) {
      Plan plan = Plan.fromJson(map);
      plan.listOfEvents = await getPlanEvents(plan.id!);
      plans.add(plan);
    }
    return plans;
  }


  void addEventToPlan(int planId, Event event) async {
    final db = await database;
    var eventId = await db.insert('Event', event.toJson());
    event.id=eventId;
    await db.insert('EventList', {'planID': planId, 'eventID': eventId});
  }

  Future<void> updatePlan(Plan plan) async {
    final db = await database;
    await db.update(
      'Plan',
      plan.toJson(),
      where: 'id = ?',
      whereArgs: [plan.id],
    );
    for (Event event in plan.listOfEvents) {
      if(event.id==null){
        addEventToPlan(plan.id!, event);
      } else{
        updateEvent(event);
      }
    }
  }

  Future<void> deletePlanEvents(int planId) async {
    final db = await database;
    final List<Map<String, dynamic>> events = await db.query('EventList', where: 'planID = ?', whereArgs: [planId]);
    for (Map<String, dynamic> event in events) {
      await db.delete(
        'Event',
        where: 'eventID = ?',
        whereArgs: [event['eventID']],
      );
    }
    await db.delete(
      'EventList',
      where: 'planID = ?',
      whereArgs: [planId],
    );
  }

  Future<void> deletePlanEvent(int eventId) async {
    final db = await database;
    await db.delete(
      'EventList',
      where: 'eventID = ?',
      whereArgs: [eventId],
    );
    await deleteEvent(eventId);
  }

  Future<void> deletePlan(int planId) async {
    final db = await database;
    await db.delete(
      'Plan',
      where: 'id = ?',
      whereArgs: [planId],
    );
    deletePlanEvents(planId);
  }




  // Future<void> addEvent(Event event) async {
  //   final db = await database;
  //   await db.insert('Event', event.toJson());
  // }
  //
  Future<Attraction> getEventAttraction(int eventId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Event', where: 'eventID = ?', whereArgs: [eventId]);
    return getAttraction(maps[0]['attractionID']);
  }


  Future<void> updateEvent(Event event) async {
    final db = await database;
    await db.update(
      'Event',
      event.toJson(),
      where: 'eventID = ?',
      whereArgs: [event.id],
    );
  }



  Future<void> deleteEvent(int eventId) async {
    final db = await database;
    await db.delete(
      'Event',
      where: 'eventID = ?',
      whereArgs: [eventId],
    );
  }

  Future<Event> getEvent(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Event', where: 'eventID = ?', whereArgs: [id]);
    return Event.fromJson(maps[0], await getAttraction(maps[0]['attractionID']));
  }


  Future<List<Event>>getEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Event');
    List<Event> events = [];
    for (Map<String, dynamic> map in maps) {
      Event event = Event.fromJson(map, await getAttraction(map['attractionID']));
      events.add(event);
    }
    return events;
  }


// Other CRUD operations...
}