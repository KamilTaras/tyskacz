import 'package:flutter/cupertino.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui';
import 'package:ical/serializer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';


//class ExportCalendar{
  // Plan plan;
  // ExportCalendar({
  //   required this.plan,
  // });


Future<File> writeCalendar(String cal, String name) async {
  final path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  final file = File('$path/$name.ics');
  // Write the file
  return file.writeAsString(cal);
}
Future<bool> export(Plan plan) async {
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
  if (await Permission.manageExternalStorage.request().isGranted) {
  // Permission is already granted
  if(writeCalendar(cal.serialize(),plan.name)!=null) {
    return true;
  }else{
    return false;
  }
  } else {
  // Request permission
  var status = await Permission.manageExternalStorage.request();
  if (status.isGranted) {
  if(writeCalendar(cal.serialize(),plan.name)!=null){
    return true;
  }
  else{
    return false;
  }
  } else {
  return false;
  }
  }

}

//}