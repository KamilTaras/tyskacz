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
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class AttractionCreationPage extends StatefulWidget {
  AttractionCreationPage({Key? key, this.attraction}) : super(key: key);
  Attraction? attraction;
  @override
  _AttractionCreationPageState createState() => _AttractionCreationPageState();
}

class _AttractionCreationPageState extends State<AttractionCreationPage> {
  late Attraction? attraction=widget.attraction;
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



  List<String> imagesList = [];
  final userInput = '';
  Future getWebsiteData(String userInput) async {
    final url = Uri.parse(
        'https://www.flickr.com/search/?text=$userInput');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final images = html
        .querySelectorAll("> img")
        .map((element) => "https:${element.attributes['src']}")
        .toList();

    print(images.length);

    for (final image in images) {
      print(image.toString());
    }
    setState(() async {
      imagesList =await images;
    });
    // return images;
  }



  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double space = screenHeight - Constant.titleHeight;
    final double smallInputHeight = space * 0.15;
    final double descriptionHeight = space * 0.35;
    final double buttonHeight = space * 0.1;


    Future<String> buildImage (String userInput) async {
       getWebsiteData(userInput);
        return imagesList[0];

    }


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

                        onPressed: () async {

                        try {
                          bool isAddress=false;
                          LatLng coordinates;

                          // Regular expression for coordinates (latitude, longitude)
                          if(_localizationController.text!=""){
                            final coordinatesRegex = RegExp(r'^\s*(-?\d+(\.\d+)?)\s*,\s*(-?\d+(\.\d+)?)\s*$');

                            if (coordinatesRegex.hasMatch(_localizationController.text)) {
                              // If the input matches the coordinates regex
                              var match = coordinatesRegex.firstMatch(_localizationController.text);
                              var latitude = double.parse(match!.group(1)!);
                              var longitude = double.parse(match.group(3)!);
                              coordinates = LatLng(latitude, longitude);
                            } else {
                              isAddress = true;
                              // Use geocoding if the input is not coordinates
                              GeoCode geoCode = GeoCode(apiKey: "412336480991130498790x31447");
                              Coordinates geoCoordinates = await geoCode.forwardGeocoding(
                                address: _localizationController.text.trim(),
                              );

                              coordinates = LatLng(
                                geoCoordinates.latitude!.toDouble(),
                                geoCoordinates.longitude!.toDouble(),
                              );
                            }
                          }else{
                            coordinates=LatLng(0,0);
                          }



                          // Adding Attraction to the database
                          if(attraction!=null){
                            attraction!.name=_nameController.text==""?attraction!.name:_nameController.text;
                            attraction!.description=_descriptionController.text==""?attraction!.description:_descriptionController.text;
                            attraction!.coordinates=_localizationController.text==""?attraction!.coordinates:coordinates;
                            attraction!.address=_localizationController.text==""?attraction!.address:_localizationController.text;
                            databaseService.updateAttraction(attraction!);
                          }
                          else {
                            databaseService.addAttraction(
                            Attraction(
                              photoURL: await buildImage(_localizationController.text),
                              name: _nameController.text,
                              description: _descriptionController.text,
                              coordinates: coordinates,
                            ),
                          );
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Attraction added!')),
                          );
                        } catch (e) {
                          // Handle errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Adding failed: $e')),
                          );
                          print(e);
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
          color: Colors.white.withOpacity(0.5),
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

