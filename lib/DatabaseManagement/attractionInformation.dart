import 'dart:ui';

import 'package:latlong2/latlong.dart';

class Attraction {
  String name;
  String description;
  LatLng coordinates;
  Image photo;
  String? review; // Optional property
  String? link; // Optional property

  Attraction({
    required this.name,
    required this.description,
    required this.coordinates,
    required this.photo,
    this.review,
    this.link,
  });

// Other methods and functionality can be added here
}

class Event {
  final Attraction attractionWithinEvent;
  final DateTime startDate;
  final DateTime endDate;
  final List<String>? listOfEquipment;

  Event(
      {required this.attractionWithinEvent,
      required this.startDate,
      required this.endDate,
      this.listOfEquipment});
}
