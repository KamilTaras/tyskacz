import 'package:flutter/material.dart';
import 'package:tyskacz/Utils/Theme/colors.dart';
import '../Utils/constantValues.dart';
import 'navBarPages/mapsPage.dart';

class AttractionCreationPage extends StatefulWidget {
  const AttractionCreationPage({Key? key}) : super(key: key);

  @override
  _AttractionCreationPageState createState() => _AttractionCreationPageState();
}

class _AttractionCreationPageState extends State<AttractionCreationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _localizationController = TextEditingController();

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
        child: ListView(
          children: <Widget>[
            Container(
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
                    Placeholder(
                      fallbackWidth: 300,
                      fallbackHeight: 200,
                    ),
                    SizedBox(height: sizedBoxHeight),
                    AttractionTextField(controller: _nameController, hintText:'Attraction Name', height: 70),
                    SizedBox(height: sizedBoxHeight),
                    AttractionTextField(controller: _descriptionController, hintText:'Description', height: 250),
                    SizedBox(height: sizedBoxHeight),
                    AttractionTextField(controller: _localizationController, hintText:'Description', height: 70),
                    SizedBox(height: sizedBoxHeight),
                    Container(
                      height: 100,
                      child:FilledButton(
                        onPressed: (){},
                        child: Text('Save'),
                        ),
                    ),
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

class AttractionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;

  AttractionTextField({
    required this.controller,
    required this.hintText,
    required this.height,
  });

  @override
  _AttractionTextFieldState createState() => _AttractionTextFieldState();
}

class _AttractionTextFieldState extends State<AttractionTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: widget.height),
        ),
      ),
    );
  }
}



class MockAttraction {
  String name;
  String picPath;
  String description;

  MockAttraction(
      {required this.name, required this.picPath, required this.description});
}

MockAttraction attraction = MockAttraction(name: 'Eiffel Tower', picPath: 'picPath', description:
"""New theher nor case that lady paid read. Invitation friendship traveNew the her nor case that lady paid read. 
      Invitation friendship travelling eat everytNew the her nor case that lady paid read. Invitation friendship 
      travelling eat everything the out two.New the her nor case that lady paid read.hing the out two.New the
       her nor case that lady paid read.Illing eat everything the out two.New the her nor case that lady paid read.
       the her nor case that lady paid read.  InvitaNew the her nor case that lady paid read. Invitation friendship 
       travelling eat everything the out two.Shy you who sction friendship travelling eat everything the out two. 
       Shy you who sc Shy you who scarcely expenses debating hastened resolved. Always polite moment on is warmth 
       spirit it to hearts. Downs those still witty an balls so chief so.  Moment an little remain no up lively no.
        Way brought may off our regular country towards adapted cheered. Literature admiration frequently indulgence announcing are who you her. Was least quick """);

