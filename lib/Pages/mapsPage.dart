import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';





class Attraction{ //temporary class for testing purposes, a real attraction object will be used in the future
  double latitude;
  double longitude;
  String imageUrl;
  Attraction({required this.latitude, required this.longitude, this.imageUrl = "https://i.ibb.co/VC549LS/Fat-Pig.png"});
}



class AttractionMapMarker extends StatelessWidget {
  final double imageSize;
  final double pinSize;
  Attraction attraction;


  AttractionMapMarker({super.key,

    this.pinSize = 60.0,
    this.imageSize = 50.0,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: pinSize,
      //height: pinSize,
      child: Stack(
        children: [
          Positioned(child:
              Image.asset(
                'assets/photos/Pin.png',
                width: pinSize,
              ),
          ),
          Positioned(
            left: (pinSize - imageSize) / 2,
            top: (pinSize - imageSize) / 2-1,

            child:
          Container(
              child: ClipOval(
                child: Image.network(
                  attraction.imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class AttractionMapMarkers extends StatelessWidget {
  double pinSize;
  AttractionMapMarkers ({super.key, this.pinSize = 60});

  var attractions = [
    Attraction(latitude:30,longitude: 40),
    Attraction(latitude:40,longitude: 40, imageUrl: 'https://obiektowe.tarkett.pl/media/img/M/TH_3917011_3707003_3708011_3912011_3914011_800_800.jpg')
  ];
  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers:attractions.map((e) => Marker(
        point: LatLng(e.latitude, e.longitude),
        width: pinSize,
        height: pinSize*1.5,
        child: AttractionMapMarker(attraction: e, pinSize: pinSize, imageSize: pinSize-10,),
      )).toList()
    );
  }
}






class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(

      options: const MapOptions(
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        AttractionMapMarkers(),
      ],
    );
  }
}

