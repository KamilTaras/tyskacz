import 'dart:ui';
import 'package:geocode/geocode.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class Attraction {
  String name;
  String description;
  LatLng coordinates;
  String photoURL; //temporary, in the future replaced with API solution
  String? review; // Optional property
  String? link; // Optional property
  String? address; // Optional property
  Attraction({
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
      GeoCode geoCode = GeoCode();
      var addressObj=geoCode.reverseGeocoding(latitude:coordinates.latitude, longitude: coordinates.longitude);
      address='${await addressObj.then((value) => value.streetAddress)??''} '
          '${await addressObj.then((value) => value.streetNumber)??''} '
          '${await addressObj.then((value) => value.city)??''} '
          '${await addressObj.then((value) => value.countryName)??''}';
    }
    return address;
  }
// Other methods and functionality can be added here
}

class Event {
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
