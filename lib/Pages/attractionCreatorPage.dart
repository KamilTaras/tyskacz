import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Utils/Theme/colors.dart';
import '../DatabaseManagement/attractionInformation.dart';
import '../Utils/constantValues.dart';
import 'navBarPages/mapsPage.dart';
import 'package:latlong2/latlong.dart';
import 'uiElements.dart';
import 'package:geocode/geocode.dart';

class AttractionCreationPage extends StatefulWidget {
  const AttractionCreationPage({Key? key}) : super(key: key);

  @override
  _AttractionCreationPageState createState() => _AttractionCreationPageState();
}

class _AttractionCreationPageState extends State<AttractionCreationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _localizationController = TextEditingController();
  DatabaseService databaseService = DatabaseService();
  final double componentsMargin = 5.0;
  final double ratingFontSize = 20.0;
  final double titleFontSize = 25.0;
  final double mainContainerMargin = 10.0;
  final double topBarHeight = 20.0;
  final double sizedBoxHeight = 5;

  final String date = '24.10.2023 - 11.11.2023';
  final String localization = 'Szczecin, Dabie 33';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double space = screenHeight - Constant.titleHeight;
    final double smallInputHeight = space * 0.15;
    final double descriptionHeight = space * 0.35;
    final double buttonHeight = space * 0.1;

    return Stack(children: [
      BackgroundSuitcase(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: AppBar(
              // backgroundColor: Colors.transparent,
              ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(mainContainerMargin),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //TODO: insert pic
                   CreateTitle(screenWidth: screenWidth, title: 'Add Attraction'),
                    // SizedBox(height: sizedBoxHeight),
                    AttractionTextField(
                        controller: _nameController,
                        hintText: 'Attraction Name',
                        height: smallInputHeight,
                        maxLines: 2),
                    // SizedBox(height: sizedBoxHeight),
                    AttractionTextField(
                        controller: _descriptionController,
                        hintText: 'Description',
                        height: descriptionHeight,
                        maxLines: 12),
                    // SizedBox(height: sizedBoxHeight),
                    AttractionTextField(
                        controller: _localizationController,
                        hintText: 'Localization',
                        height: smallInputHeight),
                    // SizedBox(height: sizedBoxHeight),
                    Container(
                      height: buttonHeight,
                      width: double.infinity,
                      child: FilledButton(
                        //TODO: create attraction after pressing the button
                        // jak można wrzucać takie rzeczy do onPressed? to jest niemożliwe
                        onPressed: () async {
                          try {
                            var coords = LatLng(
                                double.parse(
                                    _localizationController.text.split(',')[0]),
                                double.parse(
                                    _localizationController.text.split(',')[1]));
                            databaseService.addAttraction(Attraction(
                              photoURL:
                                  'https://www.w3schools.com/w3css/img_lights.jpg',
                              name: _nameController.text,
                              description: _descriptionController.text,
                              coordinates: coords,
                              //,
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('attraction added!')));
                          } catch (e) {


                          GeoCode geoCode =
                              GeoCode(apiKey: "412336480991130498790x31447");

                          try {
                            Coordinates coordinates =
                                await geoCode.forwardGeocoding(
                                    address: _localizationController.text);

                            databaseService.addAttraction(Attraction(
                              photoURL:
                                  'https://www.w3schools.com/w3css/img_lights.jpg',
                              name: _nameController.text,
                              description: _descriptionController.text,

                              coordinates: LatLng(
                                  coordinates.latitude!.toDouble(),
                                  coordinates.longitude!.toDouble()),
                              //,));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('attraction added!')));

                            //print("Latitude: ${coordinates.latitude}");
                            //print("Longitude: ${coordinates.longitude}");
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('adding failed')));
                            print(e);
                          }
                        }

                        },
                        child: Text('Save', style: TextStyle(fontSize: 30),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class AttractionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final double fontSize = 25;
  final int? maxLines;

  AttractionTextField({
    required this.controller,
    required this.hintText,
    required this.height,
    this.maxLines = 1,
  });

  @override
  _AttractionTextFieldState createState() => _AttractionTextFieldState();
}

class _AttractionTextFieldState extends State<AttractionTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: mainGreen.withOpacity(0.8),
                width: 3.0),// Adjust the opacity as needed
        ),
        child: Container(
          height: widget.height,
          child: TextField(
            controller: widget.controller,
            style: TextStyle(fontSize: widget.fontSize, color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[850], fontFamily: 'MainFont'),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            maxLines: null,
            minLines: 1,
          ),
        ),
      ),
    );
  }
}

