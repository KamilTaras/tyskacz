import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constantValues.dart';
import 'navBarPages/mapsPage.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';


class AttractionDescriptionPage extends StatelessWidget {
  AttractionDescriptionPage({super.key, required this.event});
  final Event event;

  final double componentsMargin = 5.0;
  final double ratingFontSize = 20.0;
  final double titleFontSize = 25.0;
  final double mainContainerMargin = 10.0;
  final double topBarHeight = 20.0;
  final double sizedBoxHeight = 5;



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

  Widget buildElevatedContainer({
    required Widget child,
    double elevation = 8.0,
    double borderRadius = 8.0,
    Color backgroundColor = Colors.white,
  }) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: backgroundColor,
      child: child,
    );
  }

  Widget buildTextContainer(double height, Color color, String name,
      double fontSize, Color textColor) {
    return buildStyledContainer(
      height: height,
      color: color,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      ),
    );
  }

  Widget buildElevatedTextContainer(double height, Color color, String name,
      double fontSize, Color textColor) {
    return buildElevatedContainer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildTextContainer(
            height,
            color,
            name,
            fontSize,
            textColor,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildRowWithChildrenList(List<Widget> children, double sizedBoxWidth) {
    List<Widget> rowChildren = [SizedBox(width: sizedBoxWidth)];

    for (int i = 0; i < children.length; i++) {
      // Add the child widget
      rowChildren.add(children[i]);

      // Add a SizedBox after each child except the last one
      if (i < children.length - 1) {
        rowChildren.add(SizedBox(width: sizedBoxWidth));
      }
    }

    return Row(
      children: rowChildren,
    );
  }

  Widget buildIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

  Widget buildRatingContainer() {
    List<Widget> firstRow = [
      buildTextContainer(35, Colors.transparent, 'Average Rating:',
          ratingFontSize, Colors.black),
      Placeholder(
        fallbackWidth: 150,
        fallbackHeight: 30,
      )
    ];
    List<Widget> secondRow = [
      buildTextContainer(
          35, Colors.transparent, 'Your Rating:', ratingFontSize, Colors.black),
      SizedBox(width: 25),
      Placeholder(
        fallbackWidth: 150,
        fallbackHeight: 30,
      )
    ];

    Widget elevatedContainer = buildElevatedContainer(
      child: Column(
        children: <Widget>[
          buildRowWithChildrenList(firstRow, 8),
          buildRowWithChildrenList(secondRow, 8),
        ],
      ),
      backgroundColor: Constant.mainRedColor,
    );
    return elevatedContainer;
  }

  Widget buildInfoContainer(BuildContext context) {
    Widget mapButton = buildIconButton(
        icon: Icons.map,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MapPage()));
        });
    Widget editButton = buildIconButton(icon: Icons.edit, onPressed: () {});

    List<Widget> firstRow = [
      Icon(Icons.calendar_month),
      buildTextContainer(55, Colors.transparent, event.startDate.toString(), 15, Colors.black)
    ];
    List<Widget> secondRow = [
      Icon(Icons.accessibility_sharp),
      buildTextContainer(
          55, Colors.transparent, event.attractionWithinEvent.coordinates.toString(), 15, Colors.black),
      mapButton,
      editButton
    ];

    Widget elevatedContainer = buildElevatedContainer(
      child: Column(
        children: <Widget>[
          buildRowWithChildrenList(firstRow, 20),
          buildRowWithChildrenList(secondRow, 20),
        ],
      ),
      backgroundColor: Constant.mainRedColor,
    );

    return elevatedContainer;
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
        child: ListView(
          children: <Widget>[
            Container(
              color: Constant.mainBackgroundColor,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: mainContainerMargin,
                  horizontal: mainContainerMargin),
              width:
                  MediaQuery.of(context).size.width - 2 * mainContainerMargin,
              height: MediaQuery.of(context).size.height -
                  30 -
                  2 * mainContainerMargin,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //TODO: insert pic
                    Container(
                      width: 300,
                      height:200,
                      child: Image.network(
                        event.attractionWithinEvent.photoURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: sizedBoxHeight),
                    buildElevatedTextContainer(
                      40,
                      Constant.mainGreenColor,
                      event.attractionWithinEvent.name,
                      titleFontSize,
                      Colors.black,
                    ),
                    SizedBox(height: sizedBoxHeight),
                    buildRatingContainer(),
                    SizedBox(height: sizedBoxHeight),
                    //TODO: container size dependant length of description
                    Container(
                      height: 220,
                      child: ListView(
                        children: [
                          buildElevatedTextContainer(
                            500,
                            Constant.mainBackgroundColor,
                            event.attractionWithinEvent.description,
                            15,
                            Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizedBoxHeight),
                    buildInfoContainer(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}