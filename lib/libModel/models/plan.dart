import 'event.dart';

class Plan {
  final int? id;
  final String name;
  final int tripType;
  final List<Event> events;

  Plan({
    this.id,
    required this.name,
    required this.tripType,
    required this.events,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tripType': tripType,
      // Convert events to JSON, if necessary
    };
  }

  factory Plan.fromJson(Map<String, dynamic> json) {
    // You'll need to handle conversion of events from JSON
    return Plan(
      id: json['id'],
      name: json['name'],
      tripType: json['tripType'],
      events: [], // Populate this based on your JSON structure
    );
  }
}
