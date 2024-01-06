import 'attractionModel.dart';

class Event {
  final Attraction attractionWithinEvent;
  final DateTime? startDate;
  final DateTime? endDate;

  Event({
    required this.attractionWithinEvent,
    required this.startDate,
    required this.endDate,
  });

  Event copyWith({
    Attraction? attractionWithinEvent,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Event(
      attractionWithinEvent: attractionWithinEvent ?? this.attractionWithinEvent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
