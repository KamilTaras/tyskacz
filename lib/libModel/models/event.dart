class Event {
  final int? eventID;
  final DateTime dateStart;
  final DateTime dateEnd;
  final int? attractionID;

  Event({
    this.eventID,
    required this.dateStart,
    required this.dateEnd,
    this.attractionID,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventID': eventID,
      'dateStart': dateStart.toIso8601String(),
      'dateEnd': dateEnd.toIso8601String(),
      'attractionID': attractionID,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventID: json['eventID'],
      dateStart: DateTime.parse(json['dateStart']),
      dateEnd: DateTime.parse(json['dateEnd']),
      attractionID: json['attractionID'],
    );
  }
}
