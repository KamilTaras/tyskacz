import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:intl/intl.dart';
import 'package:tyskacz/Pages/EventPage.dart';
import '../../DatabaseManagement/userInformation.dart';
import '../uiElements.dart';

import '../../Utils/constantValues.dart';
import '../../Utils/Theme/colors.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';

class UserCalendarPage extends StatefulWidget {
  User user;
  UserCalendarPage({super.key, required this.user});

  @override
  State<UserCalendarPage> createState() => _UserCalendarPageState();
}

class _UserCalendarPageState extends State<UserCalendarPage> {
  @override
  DatabaseService databaseService = DatabaseService();

  Widget build(BuildContext context) {
    return CalendarPage(
        child: FutureBuilder<List<Event>>(
            future: databaseService.getUserEvents(widget.user.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Calendar(eventList: []);
              }
              List<Event> eventList = snapshot.data!;
              return Calendar(eventList: eventList);
            }));
  }
}

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key, required this.child});

  Widget child;

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CreateTitle(title: 'Calendar Page', screenWidth: screenWidth),
                Container(
                  height: MediaQuery.of(context)
                          .size
                          .height - // Adjust the height as needed
                      kToolbarHeight -
                      MediaQuery.of(context).padding.top -
                      20, // Additional padding
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

Map<DateTime, List<Attraction>> mapToDays(List<Event> eventList) {
  final Map<DateTime, List<Attraction>> eventsMap = {};

  eventList.forEach((event) {
    DateTime startDate = event.startDate;
    DateTime endDate = event.endDate;

    for (var date = DateTime(startDate.year, startDate.month, startDate.day);
        date.isBefore(endDate)||date.isAtSameMomentAs(endDate);
        date = date.add(Duration(days: 1))) {
      eventsMap.putIfAbsent(date, () => []);
      eventsMap[date]!.add(event.attractionWithinEvent);
    }
  });
  return eventsMap;
}

class Calendar extends StatelessWidget {
  Calendar({
    super.key,
    required this.eventList,
  });

  final List<Event> eventList;
  late final eventsMap = mapToDays(eventList);

  @override
  Widget build(BuildContext context) {
    return buildListView(context);
  }

  Widget buildListView(BuildContext context) {
    if (eventsMap.isEmpty) {
      return MessageIsEmpty(text: "There is no events yet! Go to home page to add some :)");
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: eventsMap.length,
        itemBuilder: (context, index) {
          DateTime date = eventsMap.keys.elementAt(index);
          return DayOfEventsEntry(date: date, events: eventList);
        },
      );
    }
  }
}

class DayOfEventsEntry extends StatelessWidget {
  const DayOfEventsEntry(
      {Key? key, required this.date, required this.events})
      : super(key: key);
  final DateTime date;
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //DATE
        NewDayEntry(),
        //ATTRACTIONS
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
            ),
          child: Column(
            children: events.map((event) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: CalendarEventEntry(event: event,),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Center NewDayEntry() {
    return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
              color: Constant.mainGreenColor.withOpacity(0.7),
          ),

          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Text(
              DateFormat('dd MMMM yyyy').format(date),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Anton-Regular'),
            ),
          ),
        ),
      );
  }

}

class CalendarEventEntry extends StatelessWidget {
  CalendarEventEntry({
    super.key,
    required this.event,
  });
  Event event;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDescriptionPage(
                    event: event,
                  ))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white.withOpacity(0.7),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: 100,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                    child: Image.network(
                      event.attractionWithinEvent.photoURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(event.attractionWithinEvent.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                Container(
                  width: 200, // Set the desired width
                  child: Divider(
                    height: 20,
                    thickness: 2,
                    color: mainRed[400], // Choose the color you prefer
                  ),
                ),
                Container(
                  //height: 70,
                  child: Text(
                    event.attractionWithinEvent.description,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              // Other widgets if needed
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
