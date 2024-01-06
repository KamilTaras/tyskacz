import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';

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
                      onDelete: () {setState(() {plan.listOfEvents.removeAt(index);});}
                  );
                },
              ),
            ),
            SizedBox(height: 50), // Optional spacing
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 69,
                width: double
                    .infinity, // Makes the button stretch to the width of the screen
                child: FilledButton(
                  onPressed: () {}, //TODO: Fill for export
                  child: const Text("Export Data To Calendar"),
                ),
              ),
            ),
          ] ,
        ),
      ),
    );
  }
}




class EventEntry extends StatelessWidget {
  EventEntry({super.key, required this.event, required this.onDelete});
  final Event event;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: on drag add to plan
      onTap: onDelete,
      //TODO: in dark mode, text is not visible
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          //set border radius more than 50% of height and width to make circle
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height:100,
                width:120,
                child: Image(
                  image: AssetImage(event.attractionWithinEvent.photoURL),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(event.attractionWithinEvent.name),
                  Container(height:70,
                      child: Text(event.attractionWithinEvent.description,style:TextStyle(fontSize: 10))
                  )
                  // Other widgets if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget buildIconWithText(){
//
// }
}


class MockAttraction {

  String name;
  String picPath;
  String description;

  MockAttraction({required this.name, required this.picPath, required this.description});
}

