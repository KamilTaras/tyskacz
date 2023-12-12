import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


  Widget buildStyledContainer({required double height, required Color color, required Widget child}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }

  Widget buildTextContainer(double height, Color color, String name, double fontSize) {
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

  Widget createButtonWithImage(String path){
    return IconButton(
      iconSize: 60, // Adjust the size of the IconButton
      icon: Image.asset(
        path,
        width: 150, // Adjust the width of the image
        height: 250, // Adjust the height of the image
      ),
      onPressed: () {},
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
      body:SafeArea(
        child: Column(
          children: <Widget> [
            buildTextContainer(pageNameHeight, Colors.transparent, pageName, pageNameFontSize),
            SizedBox(height: 40),
            buildTextContainer(40, Colors.transparent, searchLabel, 15),
            Placeholder(fallbackHeight: 40, fallbackWidth: 100,),
            Column(
              children: <Widget>[

                Row(
                  children: <Widget>[
                    createButtonWithImage('assets/photos/createBusinessTrip.png'),
                  ]
                ),
              ]
            ),
            ]
        )
      ),
    );
  }
}
