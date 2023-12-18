import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyskacz/Pages/attractionFinderPage.dart';

import '../Utils/constantValues.dart';

class CreatePlanPage extends StatefulWidget {
  const CreatePlanPage({super.key});

  @override
  State<CreatePlanPage> createState() => _CreatePlanPage();
}

class _CreatePlanPage extends State<CreatePlanPage> {
  final String pageName = 'Create New Trip';
  final String searchLabel = 'Search for destinations';
  final double pageNameHeight = 100;
  final double pageNameFontSize = 40;

  Widget buildStyledContainer(
      {required double height, required Color color, required Widget child}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }

  Widget buildTextContainer(
      double height, Color color, String name, double fontSize) {
    return buildStyledContainer(
      height: height,
      color: color,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

  Widget createButtonWithImage(String path, String label) {
    return Column(
      children: [
        IconButton(
          iconSize: 60,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AttractionFinderPage()));
          },
          icon: Image.asset(
            path,
            width: 170,
            height: 170,
            fit: BoxFit.cover, // Ensure the image covers the square container
          ),
        ), // Adjust the spacing between the button and label
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          Column(children: <Widget>[
            buildTextContainer(
                pageNameHeight, Colors.transparent, pageName, pageNameFontSize),
            SizedBox(height: 30),
            buildTextContainer(40, Colors.transparent, searchLabel, 15),
            Placeholder(
              fallbackHeight: 60,
              fallbackWidth: 100,
            ),
            SizedBox(height: 30),
            Row(children: <Widget>[
              createButtonWithImage(
                  'assets/photos/createBusinessTrip.png', 'Business Trip'),
              createButtonWithImage('assets/photos/createSightSeeingTrip.png',
                  'Sight  Seeing Trip'),
            ]),
            Row(children: <Widget>[
              createButtonWithImage(
                  'assets/photos/createBusinessTrip.png', 'Educational Trip'),
              createButtonWithImage(
                  'assets/photos/createSightSeeingTrip.png', 'Leisure Trip'),
            ]),
          ]),
        ]),
      ),
    );
  }
}
