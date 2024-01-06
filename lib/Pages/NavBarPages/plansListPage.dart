import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';

import '../planPage.dart';

class PlanListPage extends StatefulWidget {
  const PlanListPage({super.key});

  @override
  State<PlanListPage> createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> {
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
  var plansList = [
    mockPlan,
    mockPlan
  ];

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
                itemCount: plansList.length,
                itemBuilder:(context, index){
                  return PlanEntry(plan: plansList[index],
                      onDelete: () {setState(() {plansList.removeAt(index);});}
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




class PlanEntry extends StatelessWidget {
  PlanEntry({super.key, required this.plan, required this.onDelete});
  final Plan plan;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          // Swiped from left to right (right direction)
          onDelete();
        }
      },
      onTap: () {
        // Navigate to the new page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanPage(plan: plan)),
        );
      },
      //TODO: on drag add to plan
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
            Text(plan.name),
            Text(plan.tripType.name)
          ],
        ),
      ),
    );
  }

// Widget buildIconWithText(){
//
// }
}



