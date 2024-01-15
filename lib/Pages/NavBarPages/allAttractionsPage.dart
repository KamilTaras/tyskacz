import 'package:flutter/material.dart';

import '../SwipableListEntry.dart';
import '../../DatabaseManagement/database.dart';
import '../../DatabaseManagement/attractionInformation.dart';
import '../../DatabaseManagement/planInformation.dart';

import '../background.dart';
import '../../Utils/Theme/colors.dart';
import '../attractionPage.dart';




class AllAttractionsPage extends StatefulWidget {
  const AllAttractionsPage({super.key});

  @override
  State<AllAttractionsPage> createState() => _AllAttractionsPageState();
}

class _AllAttractionsPageState extends State<AllAttractionsPage> {

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonHeight = screenHeight * 0.08;
    final double spaceUnderTitle = screenHeight * 0.05;

    return Stack(children: [
      BackgroundSuitcase(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // preferredSize: Size.fromHeight(30.0),s
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CreateTitle(title: 'Attractions', screenWidth: screenWidth),
              SizedBox(height: spaceUnderTitle),
              FutureBuilder<List<Attraction>>(
                future: databaseService.getAttractions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No attractions found');
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return AttractionEntry(
                            attraction: snapshot.data![index],
                            onSwipe: () async {
                              setState(() {
                                databaseService
                                    .deleteAttraction(snapshot.data![index].id!);
                              });
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
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: buttonHeight,
//                   child: FilledButton(
//                     onPressed: () {
//
// // if plan exists update it, if not create new one
//                       if (widget.plan.id != null) {
//                         databaseService.updatePlan(widget.plan);
//                       } else {
//                         databaseService.addPlan(widget.plan);
//                       }
//
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//
//                     },
//                     child: Text('Save',       style: TextStyle(
//                       fontSize: 30,) ),
//                   ),
//                 ),
//               ),
            ],
          ),
        ),
      ),
    ]);
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
                        fontSize: 25,fontWeight: FontWeight.bold)),
                    Container(
                      width: 200,  // Set the desired width
                      child: Divider(
                        height: 2,
                        thickness: 2,
                        color: mainRed[400], // Choose the color you prefer
                      ),
                    ),
                    Container(
                        height: 70,
                        child: Text(attraction.description,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 10))
                    )
                    // Other widgets if needed
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: widget.onTap,
        onSwipe: widget.onSwipe);
  }
}
