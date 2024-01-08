import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Pages/attractionFinderPage.dart';
import 'package:tyskacz/Pages/SearchField.dart';

import '../DatabaseManagement/planInformation.dart';
import 'background.dart';

class CreatePlanPage extends StatefulWidget {
  const CreatePlanPage({super.key});

  @override
  State<CreatePlanPage> createState() => _CreatePlanPage();
}

class _CreatePlanPage extends State<CreatePlanPage> {

  TextEditingController _textController = TextEditingController();
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
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget createButtonWithImage(String path, String label, int type) {
    return Column(
      children: [
        IconButton(
          iconSize: 60,
          onPressed: () {
            var plan = Plan(name: 'newPlan', listOfEvents: [], tripType: TripType.values[type]);
            mockUserPlanList.add(plan);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AttractionFinderPage(plan:plan)));
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
    return Stack(
      children: [
        Background(),
        Scaffold(
        appBar: AppBar(
          // preferredSize: Size.fromHeight(30.0),s
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            Column(children: <Widget>[
              Text('Create new trip', style: Theme.of(context).textTheme.displayMedium),
              SizedBox(height: 10),
              //TODO: Search bar

              SearchField(controller: _textController, hintText:'Search for destination', height: 50, fontSize: 20, maxLines:2),
              SizedBox(height: 30),
              Row(children: <Widget>[
                createButtonWithImage(
                    'assets/photos/createBusinessTrip.png', 'Business Trip', 0),
                createButtonWithImage('assets/photos/createSightSeeingTrip.png',
                    'Sight  Seeing Trip', 1),
              ]),
              Row(children: <Widget>[
                createButtonWithImage(
                    'assets/photos/createBusinessTrip.png', 'Educational Trip', 2),
                createButtonWithImage(
                    'assets/photos/createSightSeeingTrip.png', 'Leisure Trip', 3),
              ]),
            ]),
          ]),
        ),
      ),]
    );
  }
}
