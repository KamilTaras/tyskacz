import 'package:flutter/material.dart';


class AttractionFinderPage extends StatefulWidget {
  const AttractionFinderPage({super.key});

  @override
  State<AttractionFinderPage> createState() => _AttractionFinderPage();
}
class _AttractionFinderPage extends State<AttractionFinderPage> {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Plans page',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}