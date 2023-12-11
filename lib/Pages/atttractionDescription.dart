
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constatntValues.dart';

import 'mapsPage.dart';

class AttractionDescriptionPage extends StatelessWidget {
  final double componentsMargin = 5.0;
  final double ratingFontSize = 20.0;
  final double titleFontSize = 25.0;
  final double mainContainerMargin = 10.0;
  final double topBarHeight = 20.0;
  final String text =
      "New the her nor case that lady paid read. Invitation friendship travelling eat everything the out two. Shy you who scarcely expenses debating hastened resolved. Always polite moment on is warmth spirit it to hearts. Downs those still witty an balls so chief so. Moment an little remain no up lively no. Way brought may off our regular country towards adapted cheered.Literature admiration frequently indulgence announcing are who you her. Was least quick ";

  Widget buildStyledContainer({required double height, required Color color, required Widget child,}){
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }

  Widget buildTextContainer(double height, Color color, String name, double fontSize, Color textColor) {
    return buildStyledContainer(
      height: height,
      color: color,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              color: textColor
          ),
        ),
      ),
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

  Widget buildIconButton({required IconData icon, required VoidCallback onPressed,}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

  Widget buildRatingContainer() {
    List<Widget>  firstRow = [buildTextContainer(35, Constant.mainRedColor, 'Average Rating:', ratingFontSize, Colors.black),Placeholder(fallbackWidth: 150, fallbackHeight: 30,) ];
    List<Widget> secondRow = [buildTextContainer(35, Constant.mainRedColor, 'Your Rating:', ratingFontSize, Colors.black),SizedBox(width: 25), Placeholder(fallbackWidth: 150, fallbackHeight: 30,)];

    return buildStyledContainer(
      height: 70,
      color: Constant.mainRedColor,
      child: Column(
        children: <Widget>[
          buildRowWithChildrenList(firstRow,  8),
          buildRowWithChildrenList(secondRow, 8),
        ],
      ),
    );
  }

  Widget buildInfoContainer(BuildContext context){
    Widget mapButton = buildIconButton(icon: Icons.map, onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage())); // Use MapsPage instead of mapsPage
    });
    Widget editButton = buildIconButton(icon: Icons.edit, onPressed: () {});

    List<Widget> firstRow = [Icon(Icons.calendar_month), buildTextContainer(55, Constant.mainRedColor, 'date', 20, Colors.black),];
    List<Widget> secondRow = [Icon(Icons.accessibility_sharp), buildTextContainer(55, Constant.mainRedColor, 'Localization', 20, Colors.black), mapButton, editButton];

    return buildStyledContainer(
      height: 110,
      color: Constant.mainRedColor,
      child: Column(
        children: <Widget>[
          buildRowWithChildrenList(firstRow,  20),
          buildRowWithChildrenList(secondRow,  20),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: topBarHeight,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: mainContainerMargin, horizontal: mainContainerMargin),
              width: MediaQuery.of(context).size.width - 2 * mainContainerMargin,
              height: MediaQuery.of(context).size.height -
                  topBarHeight -
                  2 * mainContainerMargin,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Placeholder(
                      fallbackWidth: 300,
                      fallbackHeight: 200,
                    ),
                    SizedBox(height: 20),
                    buildTextContainer(40,Constant.mainGreenColor, 'Attraction Name', titleFontSize, Colors.black),
                    SizedBox(height: 20),
                    buildRatingContainer(),
                    SizedBox(height: 20),
                    buildTextContainer(240, Constant.mainBackgroundColor, text, 15, Colors.black),
                    SizedBox(height: 20),
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
