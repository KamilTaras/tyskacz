import 'dart:ui';
import 'package:geocode/geocode.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class Attraction {
  int? id;
  String name;
  String description;
  LatLng coordinates;
  String photoURL; //temporary, in the future replaced with API solution
  String? review; // Optional property
  String? link; // Optional property
  String? address; // Optional property
  Attraction({
    this.id,
    required this.name,
    required this.description,
    required this.coordinates,
    required this.photoURL,
    this.review,
    this.link,
    this.address,
  });
  Future<String?> get getAddress async {
    if(address == null){
      GeoCode geoCode = GeoCode(apiKey: "412336480991130498790x31447");
      var addressObj=geoCode.reverseGeocoding(latitude:coordinates.latitude, longitude: coordinates.longitude);
      address='${await addressObj.then((value) => value.streetAddress)??''} '
          '${await addressObj.then((value) => value.streetNumber)??''} '
          '${await addressObj.then((value) => value.city)??''} '
          '${await addressObj.then((value) => value.countryName)??''}';
    }
    return address;
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'description': description,
      'coordinates': coordinates,
      'photoURL': photoURL,
      'review': review,
      'link': link,
      'address': address,
    };

  }
// Other methods and functionality can be added here
}

class Event {
  int? id;
  final Attraction attractionWithinEvent;
  final DateTime startDate;
  final DateTime endDate;
  @override
  toString() {
    return 'Event: ${attractionWithinEvent.name}, ${startDate.toString()}, ${endDate.toString()}';
  }
  Event(
      {required this.attractionWithinEvent,
      required this.startDate,
      required this.endDate,});
}
