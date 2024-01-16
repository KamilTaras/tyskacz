import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Pages/attractionFinderPage.dart';
import 'package:tyskacz/Pages/SearchField.dart';

import '../DatabaseManagement/planInformation.dart';
import '../DatabaseManagement/userInformation.dart';
import 'background.dart';

import '../../Utils/constantValues.dart';
import 'uiElements.dart';

class CreatePlanPage extends StatefulWidget {
  const CreatePlanPage({super.key, required this.user});
  final User user;
  @override
  State<CreatePlanPage> createState() => _CreatePlanPage();
}

class _CreatePlanPage extends State<CreatePlanPage> {

  TextEditingController _textController = TextEditingController();
  final String pageName = 'Create New Trip';
  final String searchLabel = 'Search for destinations';
  final double pageNameHeight = 100;
  final double pageNameFontSize = 40;



  Widget createButtonWithImage(String path, String label, int type, double buttonHeight, double buttonWidth, controller) {
    return Column(
      children: [
        IconButton(
          splashRadius: 10,
          iconSize: 60,
          onPressed: () {
            var plan = Plan(name: controller.text, listOfEvents: [], tripType: TripType.values[type]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AttractionFinderPage(plan:plan, user:widget.user)));
          },
          icon: Image.asset(
            path,
            width: buttonWidth,
            height: buttonHeight,
            fit: BoxFit.cover, // Ensure the image covers the square container
          ),
        ), // Adjust the spacing between the button and label
        Text(
          label,
          style: TextStyle(fontSize: 16, fontFamily: 'MainFont'),
        ),
        Container(
          width: 150,
          child: Divider(
            height: 20,
            thickness: 2,
            color: Constant.mainGreenColor, // Choose the color you prefer
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _planNameController = TextEditingController();
    final double space = screenHeight - Constant.titleHeight;
    final double textFieldHeight = space * 0.2;
    final double buttonHeight = space * 0.25;
    final double buttonWidth = screenWidth * 0.45;

    return Stack(
      children: [
        Background(),
        Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // preferredSize: Size.fromHeight(30.0),s
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CreateTitle(title:'Create new trip', screenWidth:screenWidth),
                //TODO: Search bar
                  SearchField(controller: _planNameController, hintText:'Name Your Trip', fontSize: 30),
                // SearchField(controller: _textController, hintText:'Search for destination', height: 50, fontSize: 20, maxLines:2),
                // SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            createButtonWithImage(
                                'assets/photos/createBusinessTrip.png', 'Business Trip', 0, buttonHeight, buttonWidth, _planNameController),
                            createButtonWithImage('assets/photos/createSightSeeingTrip.png',
                                'Sight  Seeing Trip', 1, buttonHeight, buttonWidth, _planNameController),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            createButtonWithImage(
                                'assets/photos/educationalTrip.png', 'Educational Trip', 2, buttonHeight, buttonWidth, _planNameController),
                            createButtonWithImage(
                                'assets/photos/leisureTrip.png', 'Leisure Trip', 3, buttonHeight, buttonWidth, _planNameController),
                          ]),
                    ]
                  ),
            ]),
          ),
        ),
      ),]
    );
  }
}
