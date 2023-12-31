import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/exportCalendar.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Adjusts the space distribution
      children: [
        Expanded(
          child: Center(
            // Put other widgets that should be centered here
            child: Text(
              'Plan Page',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 69,
            width: double
                .infinity, // Makes the button stretch to the width of the screen
            child: FilledButton(
              onPressed: () {export(mockPlan);}, //TODO: Fill for export
              child: const Text("Export Data To Calendar"),
            ),
          ),
        ),
      ],
    );
  }
}
