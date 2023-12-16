import 'package:flutter/material.dart';
import '../Utils/Theme/themeManager.dart';
import '../main.dart';
import 'atttractionDescription.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        actions: [
          Switch(
              value: themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                setState(() {
                  themeManager.toggleTheme(newValue);
                });
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(70.0),
            child: Image(
              image: AssetImage('assets/photos/logo_TySkacz_light.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  child: FilledButton(onPressed: () {}, child: Container())),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 150,
                  width: 150,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AttractionDescriptionPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Atraction'),
                      ],
                    ),
                  ))
            ],
          ),
          Text(
            'Home Page',
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
