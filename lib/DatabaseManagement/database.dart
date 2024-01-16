import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tyskacz/DatabaseManagement/userInformation.dart';
import '../DatabaseManagement/attractionInformation.dart';
import '../DatabaseManagement/planInformation.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static const version = 1;
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
    return await openDatabase(path, version: version, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    deleteDatabase(db.path);
    await _initDatabase();
  }
  Future<bool> _isUpToDate() async {
    final db = await database;
    List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    List<String> tableNames = tables.map((table) => table['name'] as String).toList();
    if(tableNames.contains('User')){
      return true;
    }
    return false;
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
      await db.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        passwordHash TEXT NOT NULL
      );
    ''');
      await db.execute('''
      CREATE TABLE UserPlans (
        planID INTEGER,
        userID INTEGER,
        PRIMARY KEY (planID, userID),
        FOREIGN KEY (planID) REFERENCES Plan(id),
        FOREIGN KEY (userID) REFERENCES User(id)
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

  Future<void> addUser(User user) async {
    final db = await database;
    var id = await db.insert('User', user.toJson());
    user.id=id;
  }

  Future<User> getUser(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User', where: 'id = ?', whereArgs: [id]);
    return User.fromJson(maps[0]);
  }

  Future<User> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User', where: 'email = ?', whereArgs: [email]);
    return User.fromJson(maps[0]);
  }

  Future<User?> getUserByName(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User', where: 'name = ?', whereArgs: [name]);
    if(maps.isEmpty){
      return null;
    }
    return User.fromJson(maps[0]);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'User',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'User',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> addPlanToUser(int userId, int planId) async {
    final db = await database;
    await db.insert('UserPlans', {'userID': userId, 'planID': planId});
  }

  Future<List<Plan>> getUserPlans(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> plans = await db.query('UserPlans', where: 'userID = ?', whereArgs: [userId]);
    List<Plan> listOfPlans = [];
    for (Map<String, dynamic> plan in plans) {
      listOfPlans.add(await getPlan(plan['planID']));
    }
    return listOfPlans;
  }

  Future<void> deleteUserPlan(int userId, int planId) async {
    final db = await database;
    await db.delete(
      'UserPlans',
      where: 'userID = ? AND planID = ?',
      whereArgs: [userId, planId],
    );
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
    if(maps.isEmpty){
      return Attraction(
        name: 'error',
        description: 'error',
        coordinates: LatLng(0,0),
        photoURL: 'error',
      );
    }
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
    //check for events containing the attraction
    final List<Map<String, dynamic>> events = await db.query('Event', where: 'attractionID = ?', whereArgs: [id]);
    for (Map<String, dynamic> event in events) {
      deletePlanEvent(event['eventID']);
    }
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

  Future<Plan> getPlan(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Plan', where: 'id = ?', whereArgs: [id]);
    Plan plan = Plan.fromJson(maps[0]);
    plan.listOfEvents = await getPlanEvents(id);
    return plan;
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