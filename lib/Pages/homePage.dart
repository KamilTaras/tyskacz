import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(70.0),
              child: Image(
                image: AssetImage('assets/photos/logo_TySkacz_light.png'),
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Container()),
                ElevatedButton(onPressed: () {}, child: Container())
              ],
            ),
            Text(
              'Home Page',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ],
    );
  }
}
