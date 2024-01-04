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

class ListTileExample extends StatelessWidget {
  const ListTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Sample')),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
            subtitle: Text('Supporting text'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('B')),
            title: Text('Headline'),
            subtitle: Text(
                'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('C')),
            title: Text('Headline'),
            subtitle: Text(
                "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text."),
            trailing: Icon(Icons.favorite_rounded),
            isThreeLine: true,
          ),
          Divider(height: 0),
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
