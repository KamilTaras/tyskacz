import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Calendar Page',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
