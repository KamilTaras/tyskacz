import 'attractionInformation.dart';

class Plan {
  int? id;
  final name;
  List<Event> listOfEvents;
  final TripType tripType;
  final List<String>? listOfEquipment;


  Plan({this.id, required this.name, required this.listOfEvents, required this.tripType, this.listOfEquipment});


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
      'tripType': tripType.index,

    };

  }

  factory Plan.fromJson(Map<String, dynamic> json) {
    // You'll need to handle conversion of events from JSON
    return Plan(
      id: json['id'],
      name: json['name'],
      tripType: TripType.values[json['tripType']],
      listOfEvents: [], // Populate this based on your JSON structure
    );
  }
}

enum TripType {
  business,
  sightseeing,
  education,
  leisure,
  differentTypeTrip
}
