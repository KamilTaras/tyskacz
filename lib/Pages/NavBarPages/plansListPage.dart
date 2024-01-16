import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/DatabaseManagement/userInformation.dart';
import 'package:tyskacz/Pages/SwipableListEntry.dart';
import '../background.dart';

import '../../DatabaseManagement/database.dart';
import '../planPage.dart';

class PlanListPage extends StatefulWidget {
  User user;
  PlanListPage({super.key, required this.user});
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      Background(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CreateTitle(title: 'Your Plans', screenWidth: screenWidth),
              FutureBuilder<List<Plan>>(
                future: databaseService.getUserPlans(widget.user.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        color: Colors.white.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'There is no plans yet! Go to home page to add some :)',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return PlanEntry(
                          user: widget.user,
                            plan: snapshot.data![index],
                            onSwipe: () {
                              setState(() {
                                databaseService
                                    .deleteUserPlan(snapshot.data![index].id!, widget.user.id!);
                                snapshot.data!.removeAt(index);
                              });
                            });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 50), // Optional spacing
              Padding(
                padding: const EdgeInsets.all(16.0),
                // child: SizedBox(
                //   height: 69,
                //   width: double
                //       .infinity, // Makes the button stretch to the width of the screen
                //   child: FilledButton(
                //     onPressed: () {}, //TODO: Fill for export
                //     child: const Text("Export Data To Calendar"),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class PlanEntry extends StatefulWidget {
  PlanEntry({super.key, required this.plan, required this.onSwipe, required this.user});
  final User user;
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
                Text(widget.plan.name, style: TextStyle(fontSize: 22),),
                Text(widget.plan.tripType.name, style: TextStyle(fontSize: 22)),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlanPage(plan: widget.plan, user:widget.user)),
          );
        },
        onSwipe: widget.onSwipe);
  }
}
