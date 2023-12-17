import 'attractionInformation.dart';

class Plan {
  List<Event> listOfEvents;
  final TripType tripType;
  DateTime? theEarliestDateInTheList;
  DateTime? theLatestDateInTheList;

  Plan({required this.listOfEvents, required this.tripType});

  void addEvent(Event event) {
    listOfEvents.add(event);
    updateEarliestAndLatestDates();
  }

  void removeEvent(Event event) {
    listOfEvents.remove(event);
    updateEarliestAndLatestDates();
  }

  void updateEarliestAndLatestDates() {
    if (listOfEvents.isEmpty) {
      theEarliestDateInTheList = null;
      theLatestDateInTheList = null;
      return;
    }

    theEarliestDateInTheList = listOfEvents.first.startDate;
    theLatestDateInTheList = listOfEvents.first.endDate;

    for (Event event in listOfEvents) {
      if (event.startDate.isBefore(theEarliestDateInTheList!)) {
        theEarliestDateInTheList = event.startDate;
      }
      if (event.endDate.isAfter(theLatestDateInTheList!)) {
        theLatestDateInTheList = event.endDate;
      }
    }
  }
}
enum TripType {
  businessTrip,
  sightseeingTrip,
  educationTrip,
  leisureTrip,
  differentTypeTrip
}

