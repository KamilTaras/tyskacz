import 'package:flutter/cupertino.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui';
import 'package:ical/serializer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

var mockPlan = Plan(
  listOfEvents: [
    Event(
      attractionWithinEvent: Attraction(
        name: 'Visit Museum',
        description: 'Explore the fascinating world of art',
        coordinates: LatLng(0, 0),
        photoURL: "https://cdn.britannica.com/51/194651-050-747F0C18/Interior-National-Gallery-of-Art-Washington-DC.jpg",
        review: 'Great experience!',
        link: 'museum_website_url',
      ),
      startDate: DateTime(2023, 12, 1, 10, 0),
      endDate: DateTime(2023, 12, 1, 14, 0),
    ),
    Event(
      attractionWithinEvent: Attraction(
        name: 'Explore Botanical Garden',
        description: 'Enjoy the beauty of nature at the botanical garden',
        coordinates: LatLng(0, 0),
        photoURL: "https://www.tasteaway.pl/wp-content/uploads/2021/04/Dubai-Miracle-Garden_wejscie-990x742.jpg",
        review: 'A peaceful retreat!',
        link: 'garden_website_url',
      ),
      startDate: DateTime(2023, 12, 2, 9, 0),
      endDate: DateTime(2023, 12, 2, 12, 0),
      listOfEquipment: ['Camera', 'Comfortable Shoes'],
    ),
  ],
  tripType: TripType.sightseeingTrip,
);




//class ExportCalendar{
  // Plan plan;
  // ExportCalendar({
  //   required this.plan,
  // });

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
Future<File> writeCalendar(String cal, String name) async {
  final path = await _localPath;
  final file = File('$path/$name.ics');
  // Write the file
  return file.writeAsString(cal);
}
void export(Plan plan){
  ICalendar cal = ICalendar();
  for (var e in plan.listOfEvents) {
    cal.addElement(
          IEvent(
            start: e.startDate,
            end: e.endDate,
            lat: e.attractionWithinEvent.coordinates.latitude,
            lng: e.attractionWithinEvent.coordinates.longitude,
            description: e.attractionWithinEvent.description,
          )
      );
  }
  writeCalendar(cal.serialize(),'MyCalendar');
}

//}