import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../DatabaseManagement/attractionInformation.dart';
import '../../DatabaseManagement/database.dart';
import '../AttractionPage.dart';
import '../EventPage.dart';

class GlobalMapPage extends StatefulWidget {
  const GlobalMapPage({super.key});

  @override
  State<GlobalMapPage> createState() => _GlobalMapPageState();
}

class _GlobalMapPageState extends State<GlobalMapPage> {
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Attraction>>(
        future: databaseService.getAttractions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return MapPage(attractions: []);
          }
          List<Attraction> attractions = snapshot.data!;
          return MapPage(attractions: attractions);
        });
    return const Placeholder();
  }
}



class MapPage extends StatefulWidget {
  MapPage({super.key, required this.attractions});
  List<Attraction> attractions;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    var attractions = widget.attractions;
    var coordinates = attractions.map((e) => e.coordinates).toList();
    coordinates = coordinates.length<2? [LatLng(0, 0), LatLng(1, 1)]:coordinates;
    return Stack(
      children:[
       FlutterMap(
        options: MapOptions(
          initialCameraFit: CameraFit.coordinates(coordinates: coordinates),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          AttractionMapMarkers(attractions: attractions),
        ],
      ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
         // child: IgnorePointer(
           // ignoring: true,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0, // Optional: Set elevation to 0 to remove the shadow
            ),
          //),
        ),
      ]
    );
  }
}


class AttractionMapMarker extends StatelessWidget {
  final double imageSize;
  final double pinSize;
  Attraction attraction;

  AttractionMapMarker({
    super.key,
    this.pinSize = 60.0,
    this.imageSize = 50.0,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: pinSize,
      //height: pinSize,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AttractionDescriptionPage(attraction: attraction),
              )
          );
        },
        child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              'assets/photos/Pin.png',
              width: pinSize,
            ),
          ),
          Positioned(
            left: (pinSize - imageSize) / 2,
            top: (pinSize - imageSize) / 2 - 1,
            child: Container(
              child: ClipOval(
                child: Image.network(
                  attraction.photoURL,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class AttractionMapMarkers extends StatelessWidget {
  double pinSize;
  AttractionMapMarkers({super.key, this.pinSize = 60, required this.attractions});

  List<Attraction> attractions;
  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
        markers: attractions
            .map((e) => Marker(
                  point: e.coordinates,
                  width: pinSize,
                  height: pinSize * 1.155,
                  alignment: Alignment.topCenter,
                  child: AttractionMapMarker(
                    attraction: e,
                    pinSize: pinSize,
                    imageSize: pinSize - 10,
                  ),
                ))
            .toList());
  }
}

