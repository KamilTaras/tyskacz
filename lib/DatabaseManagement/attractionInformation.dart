import 'dart:ui';

import 'package:latlong2/latlong.dart';

class Attraction {
  String name;
  String description;
  Location location;
  Image photo;
  String? review; // Optional property
  String? link; // Optional property

  Attraction({
    required this.name,
    required this.description,
    required this.location,
    required this.photo,
    this.review,
    this.link,
  });

// Other methods and functionality can be added here
}


class Location {
  final String name;
  final LatLng coordinates;

  Location({required this.name, required this.coordinates});
}

class Event extends Attraction {
  final DateTime startDate;
  final DateTime endDate;
  final List<String>? listOfEquipment;

  Event({
    required String name,
    required String description,
    required Location location,
    required Image photo,
    String? review,
    String? link,
    required this.startDate,
    required this.endDate,
    List<String>? this.listOfEquipment
  }) : super(
    name: name,
    description: description,
    location: location,
    photo: photo,
    review: review,
    link: link,
  );
}
