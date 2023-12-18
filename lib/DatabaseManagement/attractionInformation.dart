import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class Attraction {
  String name;
  String description;
  LatLng coordinates;
  String photoURL; //temporary, in the future replaced with API solution
  String? review; // Optional property
  String? link; // Optional property

  Attraction({
    required this.name,
    required this.description,
    required this.coordinates,
    required this.photoURL,
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
