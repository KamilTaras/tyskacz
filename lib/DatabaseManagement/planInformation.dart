import 'attractionInformation.dart';

class Plan {
  int? id;
  final name;
  List<Event> listOfEvents;
  final TripType tripType;
  DateTime? theEarliestDateInTheList;
  DateTime? theLatestDateInTheList;
  final List<String>? listOfEquipment;


  Plan({this.id, required this.name, required this.listOfEvents, required this.tripType, this.listOfEquipment});

  void addEvent(Event event) {
    listOfEvents.add(event);
    updateEarliestAndLatestDates();
  }

  void removeEvent(Event event) {
    listOfEvents.remove(event);
    updateEarliestAndLatestDates();
  }

  void updateEarliestAndLatestDates() {
    if (listOfEvents.isEmpty) {
      theEarliestDateInTheList = null;
      theLatestDateInTheList = null;
      return;
    }

    theEarliestDateInTheList = listOfEvents.first.startDate;
    theLatestDateInTheList = listOfEvents.first.endDate;

    for (Event event in listOfEvents) {
      if (event.startDate.isBefore(theEarliestDateInTheList!)) {
        theEarliestDateInTheList = event.startDate;
      }
      if (event.endDate.isAfter(theLatestDateInTheList!)) {
        theLatestDateInTheList = event.endDate;
      }
    }
  }
  List<Attraction> getAttractions() {
    List<Attraction> attractions = [];
    for (Event event in listOfEvents) {
      attractions.add(event.attractionWithinEvent);
    }
    return attractions;
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'listOfEvents': listOfEvents,
      'tripType': tripType,
      'listOfEquipment': listOfEquipment,
    };

  }

  factory Plan.fromJson(Map<String, dynamic> json) {
    // You'll need to handle conversion of events from JSON
    return Plan(
      id: json['id'],
      name: json['name'],
      tripType: json['tripType'],
      listOfEvents: [], // Populate this based on your JSON structure
    );
  }
}

enum TripType {
  businessTrip,
  sightseeingTrip,
  educationTrip,
  leisureTrip,
  differentTypeTrip
}
