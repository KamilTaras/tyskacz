import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/exportCalendar.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:tyskacz/Pages/SwipableListEntry.dart';

import 'EventPage.dart';
import 'NavBarPages/mapsPage.dart';
import 'attractionFinderPage.dart';

class PlanPage extends StatefulWidget {
  PlanPage({super.key, required this.plan});
  Plan plan;
  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
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

  @override
  Widget build(BuildContext context) {
    var plan = widget.plan;

    return Scaffold(
      appBar: AppBar(
        // preferredSize: Size.fromHeight(30.0),s
      ),
      body: SafeArea(
        child: Column(
          children: <Widget> [
            Container(
                height: 50,
                width: 200,
                child: Text(
                  'Your Plan',
                  style: TextStyle(fontSize: pageNameFontSize, fontWeight: FontWeight.bold),
                )
            )
            ,
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

                      onSwipe: () {setState(() {plan.listOfEvents.removeAt(index);});}
                  );
                },
              ),
            ),
            SizedBox(height: 50), // Optional spacing
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:Column(
                children:[
                  SizedBox(
                    height: 50,//not nice
                    width: double
                        .infinity, // Makes the button stretch to the width of the screen
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
                    height: 50,//not nice
                    width: double
                        .infinity, // Makes the button stretch to the width of the screen
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
                  SizedBox(
                    height: 50,//not nice
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
                  child: Image.network(
                    widget.event.attractionWithinEvent.photoURL,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(widget.event.attractionWithinEvent.name),
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

