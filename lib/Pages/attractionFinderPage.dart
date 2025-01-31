import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import 'package:tyskacz/DatabaseManagement/userInformation.dart';
import '../DatabaseManagement/attractionInformation.dart';
import '../DatabaseManagement/planInformation.dart';
import '../../Utils/Theme/colors.dart';
import 'uiElements.dart';
import '../../Utils/constantValues.dart';



import 'AttractionPage.dart';
import 'SwipableListEntry.dart';

class AttractionFinderPage extends StatefulWidget {
  AttractionFinderPage({super.key, required this.plan, required this.user});
  User user;
  Plan plan;

  @override
  State<AttractionFinderPage> createState() => _AttractionFinderPage();
}

class _AttractionFinderPage extends State<AttractionFinderPage> {
  final DatabaseService databaseService = DatabaseService();

  TextEditingController _textController = TextEditingController();

  Widget buildTextContainer(double height, String name, double fontSize) {
    return Container(
      height: height,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

  final double pageNameFontSize = 15;

  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonHeight = screenHeight * 0.08;
    final double spaceUnderTitle = screenHeight * 0.05;

    return Stack(children: [
      Background(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            // preferredSize: Size.fromHeight(30.0),s
            ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CreateTitle(title: 'Find Attractions', screenWidth: screenWidth),
              FutureBuilder<List<Attraction>>(
                future: databaseService.getAttractions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return MessageIsEmpty(text: 'No attractions found');
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return AttractionEntry(
                            attraction: snapshot.data![index],
                            onSwipe: () async {
                              var start = await selectDate(
                                  context, "Select start date");
                              var end = await selectDate(
                                  context, "Select end date", start: start);

                              widget.plan.listOfEvents.add(Event(
                                  attractionWithinEvent: snapshot.data![index],
                                  startDate: start,
                                  endDate: end));
                              //setState(() {attractionList.removeAt(index);});
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AttractionDescriptionPage(
                                              attraction:
                                                  snapshot.data![index])));
                            });
                      },
                    ),
                  );
                },
              ),
              // Optional spacing
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: buttonHeight,
                  child: FilledButton(
                    onPressed: () {

// if plan exists update it, if not create new one
                      if (widget.plan.id != null) {
                        databaseService.updatePlan(widget.plan);
                      } else {
                        databaseService.addPlanToUser(widget.user.id!,widget.plan);

                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Plan saved!'),
                            duration: Duration(seconds: 2),
                          ),
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                    },
                    child: Text('Save',       style: TextStyle(
                      fontSize: 30,) ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Future<DateTime> selectDate(BuildContext context, String message,
      {DateTime? start = null}) async {
    final DateTime? picked = await showDatePicker(
      helpText: message,
      context: context,
      initialDate: start ?? DateTime.now(),
      firstDate: start ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked == null) {
      picked == DateTime.now();
    }
    return picked!;
  }
}


class AttractionEntry extends StatefulWidget {
  AttractionEntry({
    super.key,
    required this.attraction,
    required this.onTap,
    required this.onSwipe,
  });

  final Attraction attraction;
  final VoidCallback onTap;
  final VoidCallback onSwipe;

  @override
  _AttractionEntryState createState() => _AttractionEntryState();
}

class _AttractionEntryState extends State<AttractionEntry> {

  @override
  Widget build(BuildContext context) {
    var attraction = widget.attraction;
    return SwipableListEntry(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border(
              //   top: BorderSide(
              //     color: Constant.mainGreenColor,
              //     width: 2.0, // Adjust the border thickness as needed
              //   ),
              // ),
              color: Colors.white.withOpacity(0.7),//set border radius more than 50% of height and width to make circle
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height: 100,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        attraction.photoURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(attraction.name,       style: TextStyle(
                          fontSize: 25,fontWeight: FontWeight.bold, fontFamily: 'MainFont')),
                      Container(
                        width: 200,  // Set the desired width
                        child: Divider(
                          height: 2,
                          thickness: 2,
                          color: Constant.mainRedColor, // Choose the color you prefer
                        ),
                      ),
                      Container(
                          height: 70,
                          child: Text(attraction.description,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15, fontFamily: 'MainFont'))
                      )
                      // Other widgets if needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: widget.onTap,
        onSwipe: widget.onSwipe);
  }
}
