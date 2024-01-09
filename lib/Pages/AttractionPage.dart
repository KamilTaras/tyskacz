import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constantValues.dart';
import 'navBarPages/mapsPage.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'background.dart';

class AttractionDescriptionPage extends StatelessWidget {
  AttractionDescriptionPage({super.key, required this.attraction});
  final Attraction attraction;

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

  Widget buildIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }


  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double picHeight = screenHeight * 0.25;
    final double picWidth = screenWidth * 0.9;
    final double nameHeight = screenHeight*0.08;
    final double listHeight = screenHeight* 0.4;
    return Stack(
      children: [
        Background(),
        Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  AppBar(
            backgroundColor: Colors.transparent,
          ),
        body: SafeArea(
          child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                margin: EdgeInsets.all( mainContainerMargin),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //TODO: insert pic
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height:picHeight,
                          width:picWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              attraction.photoURL,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      buildElevatedTextContainer(
                        nameHeight,
                        Constant.mainGreenColor,
                        attraction.name,
                        titleFontSize,
                        Colors.black,
                      ),
                      //TODO: container size dependant length of description
                      Material(
                        elevation: 8.0, // Set the desired elevation
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: listHeight,
                          width: double.infinity,
                          child:SingleChildScrollView(
                              child:Text(attraction.description)
                          ),
                        )
                      ),


                      Material(
                        elevation: 8.0, // Set the desired elevation
                        borderRadius: BorderRadius.circular(8.0),
                        color: Constant.mainRedColor,
                        child: Container(
                          height: nameHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.accessibility_sharp),
                              buildIconButton(
                                icon: Icons.map,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MapPage(attractions: [attraction])),
                                  );
                                },
                              ),
                              buildIconButton(icon: Icons.edit, onPressed: (){}),
                              Container(width: screenWidth / 3)
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
        ),
      ),
    ],
    );
  }
}