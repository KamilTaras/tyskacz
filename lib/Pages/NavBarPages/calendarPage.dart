import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';

class UserCalendarPage extends StatefulWidget {
  const UserCalendarPage({super.key});

  @override
  State<UserCalendarPage> createState() => _UserCalendarPageState();
}

class _UserCalendarPageState extends State<UserCalendarPage> {
  @override
  DatabaseService databaseService = DatabaseService();

  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
        future: databaseService.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No events found');
          }
          List<Event> eventList = snapshot.data!;
          return CalendarPage(eventList: eventList);
        });
  }
}

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

      for (var date = startDate;
          date.isBefore(endDate);
          date = date.add(Duration(days: 1))) {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Calendar Page',
                    style: TextStyle(fontSize: 25),
                  ),
                  Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: eventsMap.length,
                      itemBuilder: (context, index) {
                        DateTime date = eventsMap.keys.elementAt(index);
                        List<Attraction> attractions = eventsMap[date]!;

                        return DayOfEventsEntry(
                            date: date, attractions: attractions);
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
  const DayOfEventsEntry(
      {Key? key, required this.date, required this.attractions});

  final DateTime date;
  final List<Attraction> attractions;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Date: ${date}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            children: attractions.map((attraction) {
              return ListTile(
                leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 50,
                      minHeight: 50,
                      maxWidth: 70,
                      maxHeight: 70,
                    ),
                    child: Image.network(
                      attraction.photoURL,
                      fit: BoxFit.cover,
                    )),
                title: Text(attraction.name),
                subtitle: Text(attraction.description),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
