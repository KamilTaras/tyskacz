import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:intl/intl.dart';


import '../../Utils/constantValues.dart';
import '../../Utils/Theme/colors.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key, required this.eventList});
  List<Event> eventList;

  @override
  Widget build(BuildContext context) {
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

    // final Map<DateTime, List<Attraction>> eventsMap = eventList.fold({}, (Map<DateTime, List<Attraction>> map, Event event) {
    //   DateTime startDate = event.startDate;
    //   DateTime endDate = event.endDate;
    //   List<Attraction> attractions = [event.attractionWithinEvent];
    //
    //   for (var date = startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) { //If takes longer than a day add on multiple days
    //     if (map.containsKey(date)) {
    //       map[date]!.addAll(attractions);
    //     } else {
    //       map[date] = attractions;
    //     }
    //   }
    //
    //   return map;
    // });
    print(eventsMap);
    // {
    //   DateTime(2023, 1, 1): [
    //     MockAttraction(
    //       name: 'Pigs in Paris',
    //       picPath: 'assets/photos/logo_TySkacz_light.png',
    //       description: 'building',
    //     ),
    //     MockAttraction(
    //       name: 'Działeczka',
    //       picPath: 'assets/photos/logo_TySkacz_light.png',
    //       description: 'deep in the forrest',
    //     ),
    //   ],
    //   DateTime(2023, 1, 2): [
    //     MockAttraction(
    //       name: 'Tank U',
    //       picPath: 'assets/photos/logo_TySkacz_light.png',
    //       description: 'building',
    //     ),
    //     MockAttraction(
    //       name: 'Paprykarz',
    //       picPath: 'assets/photos/logo_TySkacz_light.png',
    //       description: 'building',
    //     ),
    //   ],
    // };

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Calendar Page',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height:20),
                  Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: eventsMap.length,
                      itemBuilder: (context, index) {
                        DateTime date = eventsMap.keys.elementAt(index);
                        List<Attraction> attractions = eventsMap[date]!;

                        return DayOfEventsEntry(date: date, attractions: attractions);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DayOfEventsEntry extends StatelessWidget {
  const DayOfEventsEntry({Key? key, required this.date, required this.attractions});
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
          SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            child: Column(
              children: attractions.map((attraction) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            attraction.photoURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(attraction.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(attraction.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


