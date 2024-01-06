import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class Attraction {
  String name;
  String description;
  LatLng coordinates;
  Uri? photo; //todo: no idea what it is going to be
  String? review; // Optional property
  String? link; // Optional property

  Attraction({
    required this.name,
    required this.description,
    required this.coordinates,
    this.photo,
    this.review,
    this.link,
  });

  Attraction copyWith({
    String? name,
    String? description,
    LatLng? coordinates,
    Uri? photo,
    String? review,
    String? link,
  }) {
    return Attraction(
      name: name ?? this.name,
      description: description ?? this.description,
      coordinates: coordinates ?? this.coordinates,
      photo: photo ?? this.photo,
      review: review ?? this.review,
      link: link ?? this.link,
    );
  }
// Other methods and functionality can be added here
}



