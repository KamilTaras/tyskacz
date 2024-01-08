import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:intl/intl.dart';
import '../background.dart';

import '../../Utils/constantValues.dart';
import '../../Utils/Theme/colors.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key, required this.eventList});
  List<Event> eventList;

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    print(eventList);
    final Map<DateTime, List<Attraction>> eventsMap = {};

    eventList.forEach((event) {
      DateTime startDate = event.startDate;
      DateTime endDate = event.endDate;

      for (var date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) {
        eventsMap.putIfAbsent(date, () => []);
        eventsMap[date]!.add(event.attractionWithinEvent);
      }
    });

    return Stack(
        children:[
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget> [
                        Text(
                          'Calendar Page',
                          style: TextStyle(fontSize: 30, fontFamily: 'Anton-Regular', fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height:20),
                        ListView.builder(
                          shrinkWrap: true, // Add this line
                          itemCount: eventsMap.length,
                          itemBuilder: (context, index) {
                            DateTime date = eventsMap.keys.elementAt(index);
                            List<Attraction> attractions = eventsMap[date]!;
                            return DayOfEventsEntry(date: date, attractions: attractions);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }

}

class DayOfEventsEntry extends StatelessWidget {
  const DayOfEventsEntry({Key? key, required this.date, required this.attractions}) : super(key: key);
  final DateTime date;
  final List<Attraction> attractions;

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                DateFormat('dd MMMM yyyy').format(date),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainGreen[200], fontFamily: 'Anton-Regular'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              child: Column(
                children: attractions.map((attraction) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        attraction.photoURL,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(attraction.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Anton-Regular')),
                    subtitle: Text(attraction.description, style: TextStyle(fontSize: 15, fontFamily: 'Anton-Regular')),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
  }
}
