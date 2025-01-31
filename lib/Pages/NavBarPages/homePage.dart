import 'package:flutter/material.dart';
import '../../DatabaseManagement/userInformation.dart';
import '../../main.dart';
import '../attractionCreatorPage.dart';
import '../EventPage.dart';
import '../tripCreatorPage.dart';
import '../AuthorisationPages/signIn.dart';
import '../../Utils/Theme/colors.dart';
import '../uiElements.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final User user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double logoHeight = screenHeight * 0.3;
    final double logoWidth = screenWidth * 0.4;

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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CreateTitle(title:'Home', screenWidth: screenWidth),
                Container(
                  height: logoHeight, // Adjust height based on screen height
                  width: logoWidth,
                  child: Image(
                    image: AssetImage('assets/photos/logo_TySkacz_light.png'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.25, // Adjust height based on screen height
                      width: screenWidth * 0.45,// Adjust width based on screen height
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePlanPage(user: widget.user),
                            ),
                          );
                        },
                        child: const Text('Create a Plan',  style:TextStyle(fontSize: 25,),textAlign: TextAlign.center,),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.45,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttractionCreationPage(),
                            ),
                          );
                        },
                        child: Text('Create an Attraction', style:TextStyle(fontSize: 25,),textAlign: TextAlign.center,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
