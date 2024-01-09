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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double logoSize = screenHeight * 0.3;

    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: logoSize, // Adjust height based on screen height
                width: logoSize,
                child: Image(
                  image: AssetImage('assets/photos/logo_TySkacz_light.png'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: screenHeight * 0.25, // Adjust height based on screen height
                    width: screenHeight * 0.25, // Adjust width based on screen height
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
                    height: screenHeight * 0.25,
                    width: screenHeight * 0.25,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttractionCreationPage(),
                          ),
                        );
                      },
                      child: Text('Create an\nAttraction'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
