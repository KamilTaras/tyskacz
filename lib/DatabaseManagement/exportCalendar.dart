import 'package:flutter/cupertino.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui';
import 'package:ical/serializer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';




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