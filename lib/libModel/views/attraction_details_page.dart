import 'package:flutter/material.dart';
import '../models/attraction.dart';

class AttractionDetailsPage extends StatelessWidget {
  final Attraction attraction;

  AttractionDetailsPage({Key? key, required this.attraction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attraction.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attraction.location),
            Text(attraction.longitude.toString())
            // Display attraction details here
            // Example: Text('Description: ${attraction.description}')
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
