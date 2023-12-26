import 'package:flutter/material.dart';
import 'MockEvents.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  final List<MockEvent> listOfEvents = [
    MockEvent(
      attractionWithinEvent: MockAttraction(
        name: 'Pigs in Paris',
        picPath: 'assets/photos/logo_TySkacz_light.png',
        description: 'building',
      ),
      startDate: DateTime(2023, 1, 1),
      endDate: DateTime(2023, 1, 1),
    )
    // Add more attractions as needed
  ];
  final DayOfEvents day1 = DayOfEvents(eventsList: listOfEvents);
  final List<DayOfEvents> listOfDays = [day1];

  @override
  Widget build(BuildContext context) {
    // Initialize listOfDays here in the constructor body

    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Text(
                'Calendar Page',
                style: TextStyle(fontSize: 25),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listOfEvents.length,
                  itemBuilder: (context, index) {
                    return DayOfEventsEntry(dayOfEvents: listOfDays[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DayOfEventsEntry extends StatelessWidget {
  const DayOfEventsEntry({Key? key, required this.dayOfEvents});
  final DayOfEvents dayOfEvents;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DayOfEvents {
  List<MockEvent> eventsList = [];

  DayOfEvents({required this.eventsList});
}
