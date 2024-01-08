import 'package:flutter/material.dart';
import '../../main.dart';
import '../attractionCreatorPage.dart';
import '../EventPage.dart';
import '../tripCreatorPage.dart';
import '../AuthorisationPages/signIn.dart';
import '../../Utils/Theme/colors.dart';
import '../background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent, // Set background color to transparent
          appBar: AppBar(
            title: Text('Test'),
            actions: [
              Switch(
                value: themeManager.themeMode == ThemeMode.dark,
                onChanged: (newValue) {
                  setState(() {
                    themeManager.toggleTheme(newValue);
                  });
                },
              ),
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
                    height: 150,
                    width: 150,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatePlanPage(),
                          ),
                        );
                      },
                      child: Text('Create a Plan'),
                    ),
                  ),
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
                            builder: (context) => AttractionCreationPage(),
                          ),
                        );
                      },
                      child: Text('Create an\nAtraction'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Home Page',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
