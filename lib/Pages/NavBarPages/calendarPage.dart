import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<MockAttraction>> eventsMap = {
      DateTime(2023, 1, 1): [
        MockAttraction(
          name: 'Pigs in Paris',
          picPath: 'assets/photos/logo_TySkacz_light.png',
          description: 'building',
        ),
        MockAttraction(
          name: 'Działeczka',
          picPath: 'assets/photos/logo_TySkacz_light.png',
          description: 'deep in the forrest',
        ),
      ],
      DateTime(2023, 1, 2): [
        MockAttraction(
          name: 'Tank U',
          picPath: 'assets/photos/logo_TySkacz_light.png',
          description: 'building',
        ),
        MockAttraction(
          name: 'Paprykarz',
          picPath: 'assets/photos/logo_TySkacz_light.png',
          description: 'building',
        ),
      ],
    };

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
                        List<MockAttraction> attractions = eventsMap[date]!;

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
  final List<MockAttraction> attractions;

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
                  child: Image.asset(attraction.picPath, fit: BoxFit.cover),
                ),
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

class MockAttraction {
  String name;
  String picPath;
  String description;

  MockAttraction({
    required this.name,
    required this.picPath,
    required this.description,
  });
}
