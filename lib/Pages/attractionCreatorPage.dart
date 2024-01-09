import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Utils/Theme/colors.dart';
import '../DatabaseManagement/attractionInformation.dart';
import '../Utils/constantValues.dart';
import 'navBarPages/mapsPage.dart';
import 'package:latlong2/latlong.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          // backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: mainContainerMargin, horizontal: mainContainerMargin),
          width: MediaQuery.of(context).size.width - 2 * mainContainerMargin,
          height: MediaQuery.of(context).size.height - 30 - 2 * mainContainerMargin,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //TODO: insert pic
                Placeholder(
                  fallbackWidth: 300,
                  fallbackHeight: 200,
                ),
                SizedBox(height: sizedBoxHeight),
                AttractionTextField(controller: _nameController, hintText:'Attraction Name', height: 70, fontSize: 25, maxLines:2),
                SizedBox(height: sizedBoxHeight),
                AttractionTextField(controller: _descriptionController, hintText:'Description', height: 250, fontSize: 16, maxLines: 12),
                SizedBox(height: sizedBoxHeight),
                AttractionTextField(controller: _localizationController, hintText:'Localization', height: 70, fontSize: 16),
                SizedBox(height: sizedBoxHeight),
                Container(
                  height: 100,
                  child:FilledButton(
                    //TODO: create attraction after pressing the button
                    onPressed: () async {
                      try{
                        var coords=LatLng(double.parse(_localizationController.text.split(',')[0]), double.parse(_localizationController.text.split(',')[1]));
                        databaseService.addAttraction(
                            Attraction(
                              photoURL: 'https://www.w3schools.com/w3css/img_lights.jpg',
                              name: _nameController.text,
                              description: _descriptionController.text,
                              coordinates: coords,
                              //,
                            )
                        );
                      }catch(e){
                        print(e);
                      }

                      GeoCode geoCode = GeoCode(apiKey: "412336480991130498790x31447");

                      try {
                        Coordinates coordinates = await geoCode.forwardGeocoding(
                            address: _localizationController.text);
                        databaseService.addAttraction(
                            Attraction(
                              photoURL: 'https://www.w3schools.com/w3css/img_lights.jpg',
                              name: _nameController.text,
                              description: _descriptionController.text,

                              coordinates: LatLng(coordinates.latitude!.toDouble(), coordinates.longitude!.toDouble()),
                              //,
                            )
                        );
                        //print("Latitude: ${coordinates.latitude}");
                        //print("Longitude: ${coordinates.longitude}");
                      } catch (e) {
                        print(e);
                      }

                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AttractionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final double fontSize;
  final int? maxLines;

  AttractionTextField({
    required this.controller,
    required this.hintText,
    required this.height,
    required this.fontSize,
    this.maxLines = 1,
  });

  @override
  _AttractionTextFieldState createState() => _AttractionTextFieldState();
}

class _AttractionTextFieldState extends State<AttractionTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0, // Adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      child: Container(
        height: widget.height,
        child: TextField(
          controller: widget.controller,
          style: TextStyle(fontSize: widget.fontSize),
          decoration: InputDecoration(
            hintText: widget.hintText,
            // border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          maxLines: null,
          minLines: 1,
        ),
      ),
    );

  }
}

