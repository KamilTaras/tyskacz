import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import 'package:tyskacz/DatabaseManagement/exportCalendar.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:tyskacz/Pages/SwipableListEntry.dart';
import '../../Utils/Theme/colors.dart';

import 'EventPage.dart';
import 'NavBarPages/mapsPage.dart';
import 'attractionFinderPage.dart';
import 'background.dart';

class PlanPage extends StatefulWidget {
  PlanPage({super.key, required this.plan});
  Plan plan;
  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  DatabaseService databaseService = DatabaseService();
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
  final double spaceBetweenButtons = 10;

  @override
  Widget build(BuildContext context) {
    var plan = widget.plan;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;


    return Stack(
        children: [
          Background(),
          Scaffold(backgroundColor: Colors.transparent,
            appBar: AppBar(
              // preferredSize: Size.fromHeight(30.0),s
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text(
                    'Your Plan',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: plan.listOfEvents.length,
                      itemBuilder:(context, index){
                        return EventEntry(event: plan.listOfEvents[index],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventDescriptionPage(event:plan.listOfEvents[index])
                                  )
                              );
                            },

                            onSwipe: () {
                    setState(() {
                      print(plan.listOfEvents[index].toJson());
                      databaseService.deletePlanEvent(plan.listOfEvents[index].id!);
                      plan.listOfEvents.removeAt(index);
                      });}
                        );
                      },
                    ),
                  ), // Optional spacing
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: screenHeight*0.08,//not nice
                                  width: (screenWidth/ 2) - 20, // Makes the button stretch to the width of the screen
                                  child: FilledButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MapPage(attractions: plan.getAttractions(),)
                                          )
                                      );
                                    }, //TODO: Fill for export
                                    child: const Text("Show on map"),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight*0.08,//not nice
                                  width: (screenWidth/ 2) - 20, // Makes the button stretch to the width of the screen
                                  child: FilledButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AttractionFinderPage(plan:plan)
                                          )
                                      );
                                    }, //TODO: Fill for export
                                    child: const Text("Add Event"),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spaceBetweenButtons),
                            SizedBox(
                              height: screenHeight*0.08,//not nice
                              width: double
                                  .infinity, // Makes the button stretch to the width of the screen
                              child: FilledButton(
                                onPressed: () {
                                  export(plan);
                                }, //TODO: Fill for export
                                child: const Text("Export Data To Calendar"),
                              ),
                            ),
                          ]
                      )
                  ),
                ] ,
              ),
            ),
          ),]
    );
  }
}



class EventEntry extends StatefulWidget {
  EventEntry({
    super.key,
    required this.event,
    required this.onTap,
    required this.onSwipe,
  });

  final Event event;
  final VoidCallback onTap;
  final VoidCallback onSwipe;

  @override
  _EventEntryState createState() => _EventEntryState();
}

class _EventEntryState extends State<EventEntry> {

  @override
  Widget build(BuildContext context) {
    return SwipableListEntry(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 100,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                    child: Image.network(
                      widget.event.attractionWithinEvent.photoURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(widget.event.attractionWithinEvent.name, style:TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: 200,  // Set the desired width
                      child: Divider(
                        height: 20,
                        thickness: 2,
                        color: mainRed[400], // Choose the color you prefer
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Text(
                        widget.event.attractionWithinEvent.description,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    // Other widgets if needed
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: widget.onTap,
        onSwipe: widget.onSwipe
    );
  }
}

