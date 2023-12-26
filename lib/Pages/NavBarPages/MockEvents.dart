class MockAttraction {

  String name;
  String picPath;
  String description;

  MockAttraction({required this.name, required this.picPath, required this.description});
}

class MockEvent {
  final MockAttraction attractionWithinEvent;
  final DateTime startDate;
  final DateTime endDate;

  MockEvent(
      {required this.attractionWithinEvent,
        required this.startDate,
        required this.endDate,
      });
}