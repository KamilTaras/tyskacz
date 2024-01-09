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
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
      'photoURL': photoURL,
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
      {this.id,
        required this.attractionWithinEvent,
      required this.startDate,
      required this.endDate,});

  Map<String, Object?> toJson() {
    return {
      'attractionID': attractionWithinEvent.id,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    };
  }

  static Event fromJson(Map<String, dynamic> eventMap) {
    return Event(
      id: eventMap['id'],
      attractionWithinEvent: Attraction(
        id: eventMap['attractionWithinEvent'],
        name: eventMap['name']??'',
        description: eventMap['description'],
        coordinates: LatLng(eventMap['latitude'], eventMap['longitude']),
        photoURL: eventMap['photoURL'],
        link: eventMap['link'],
        address: eventMap['address'],
      ),
      startDate: DateTime.parse(eventMap['startDate']),
      endDate: DateTime.parse(eventMap['endDate']),
    );
  }
}
