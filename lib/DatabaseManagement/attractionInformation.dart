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
    required String name, //x
    required String description, //x
    required Location location, //x
    required Image photo, //x
    String? review,
    String? link,
    required this.startDate, //x
    required this.endDate, //x
    List<String>? this.listOfEquipment //x
  }) : super(
    name: name,
    description: description,
    location: location,
    photo: photo,
    review: review,
    link: link,
  );
}
