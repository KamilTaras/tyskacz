import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../DatabaseManagement/attractionModel.dart';
import '../DatabaseManagement/eventModel.dart';  // Assuming this is the path to your Event class

final eventProvider = StateNotifierProvider<EventNotifier, Event>((ref) {
  return EventNotifier();
});

class EventNotifier extends StateNotifier<Event> {
  EventNotifier()
      : super(Event(
    attractionWithinEvent: Attraction(
      name: 'Default Attraction Name',
      description: 'Default Attraction Description',
      coordinates: LatLng(0.0, 0.0),
    ),
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 1)), // Default end date is one day after start date
  ));

  static Event _initialEvent() {
    return Event(
      attractionWithinEvent: Attraction(
        name: '',
        description: '',
        coordinates: LatLng(0.0, 0.0),
      ),
      startDate:null,
      endDate: null,
    );
  }

  void setAttraction(Attraction attraction) {
    state = state.copyWith(attractionWithinEvent: attraction);
  }

  void setStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void setEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void reset() {
    state = _initialEvent();
  }
}
