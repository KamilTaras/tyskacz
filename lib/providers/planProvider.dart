import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../DatabaseManagement/eventModel.dart';
import '../DatabaseManagement/planModel.dart';

final planProvider = StateNotifierProvider<PlanNotifier, Plan>((ref) {
  return PlanNotifier();
});

class PlanNotifier extends StateNotifier<Plan> {
  PlanNotifier()
      : super(Plan(listOfEvents: [], tripType: TripType.differentTypeTrip));

  void addEvent(Event event) {
    state.addEvent(event);
    state = state;
  }

  void removeEvent(Event event) {
    state = state..removeEvent(event);
  }

// Add any other methods you need to modify the Plan
}
