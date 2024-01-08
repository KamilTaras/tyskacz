import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Pages/SwipableListEntry.dart';

import '../../DatabaseManagement/attractionInformation.dart';
import '../../DatabaseManagement/database.dart';
import '../planPage.dart';

class PlanListPage extends StatefulWidget {
  PlanListPage({super.key});
  final plansList = mockUserPlanList;
  @override
  State<PlanListPage> createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> {
  final DatabaseService databaseService = DatabaseService();

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
                  'Your Plans',
                  style: TextStyle(fontSize: pageNameFontSize, fontWeight: FontWeight.bold),
                )
            ),
            FutureBuilder<List<Plan>>(
            future: databaseService.getPlans(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No attractions found');
              }
              return Expanded(
                  child: ListView.builder(
                    itemCount: plansList.length,
                    itemBuilder:(context, index){
                     PlanEntry(
                      plan: snapshot.data![index],
                      onSwipe: () {
                        setState(() {plansList.removeAt(index);});
                      }
                  );
                },
              )
            );
            }
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
    return SwipableListEntry(
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
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlanPage(plan: widget.plan)),
          );
        },
        onSwipe: widget.onSwipe
    );
  }
}





