import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';

import '../planPage.dart';

class PlanListPage extends StatefulWidget {
  PlanListPage({super.key});
  final plansList = [
    mockPlan,
    mockPlan
  ];
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
    var plansList = widget.plansList;

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
                  return PlanEntry(
                      plan: plansList[index],
                      onSwipe: () {
                        setState(() {plansList.removeAt(index);});
                      }
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



class PlanEntry extends StatefulWidget {
  PlanEntry({super.key, required this.plan, required this.onSwipe});

  final Plan plan;
  final VoidCallback onSwipe;

  @override
  _PlanEntryState createState() => _PlanEntryState();
}

class _PlanEntryState extends State<PlanEntry> {
  double _offsetX = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _offsetX += details.primaryDelta!;
          if(_offsetX<0) {
            _offsetX=0;
          }
        });
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_offsetX > 50) {
          // Swiped from left to right (right direction)
          widget.onSwipe();
        }
        // Reset the offset after the drag ends
        setState(() {
          _offsetX = 0.0;
        });
      },
      onTap: () {
        // Navigate to the new page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanPage(plan: widget.plan)),
        );
      },
      child: Transform.translate(
        offset: Offset(_offsetX, 0.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.white,
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget.plan.name),
                Text(widget.plan.tripType.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





