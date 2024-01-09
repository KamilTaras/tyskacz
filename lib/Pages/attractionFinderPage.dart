import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import '../DatabaseManagement/attractionInformation.dart';
import '../DatabaseManagement/mocks.dart';
import '../DatabaseManagement/planInformation.dart';
import 'AttractionPage.dart';
import 'SwipableListEntry.dart';


class AttractionFinderPage extends StatefulWidget {
  AttractionFinderPage({super.key, required this.plan});

  Plan plan;

  @override
  State<AttractionFinderPage> createState() => _AttractionFinderPage();
}

class _AttractionFinderPage extends State<AttractionFinderPage> {
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

  Widget build(BuildContext context) {
    var attractionList = mockAttractionList;
    return Scaffold(
      appBar: AppBar(
        // preferredSize: Size.fromHeight(30.0),s
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
                height: 50,
                width: 200,
                child: Text(
                  'Select attractions you would like to visit',
                  style: TextStyle(
                      fontSize: pageNameFontSize, fontWeight: FontWeight.bold),
                )
            ),

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
                          onSwipe: () {
                            widget.plan.listOfEvents.add(Event(
                                attractionWithinEvent: snapshot.data![index],
                                startDate: DateTime.now(),
                                endDate: DateTime
                                    .now())); //TODO: add date choice
                            //setState(() {attractionList.removeAt(index);});
                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AttractionDescriptionPage(
                                            attraction: attractionList[index])
                                )
                            );
                          }
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 50), // Optional spacing
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 100,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as needed
                    ),
                  ),
                  onPressed: () {
                    //if plan exists update it, if not create new one
                    //if (widget.plan.id != null)
                    //  databaseService.updatePlan(widget.plan);
                    //else
                      databaseService.addPlan(widget.plan);


                  },
                  child: Text('Save'),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
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
                  child: Image.network(
                    attraction.photoURL,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(attraction.name),
                    Container(height: 70,
                        child: Text(attraction.description,
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
        onSwipe: widget.onSwipe
    );
  }
}
