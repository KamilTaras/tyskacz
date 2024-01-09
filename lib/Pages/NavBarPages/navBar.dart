import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Utils/Theme/themeConstant.dart';

import 'calendarPage.dart';
import 'homePage.dart';
import 'mapsPage.dart';
import 'plansListPage.dart';

class NavBarClass extends StatefulWidget {
  const NavBarClass({super.key});

  @override
  State<NavBarClass> createState() => _NavBarClassState();
}

class _NavBarClassState extends State<NavBarClass> {
  int selectedItem = 0;
  late List allPages;
  DatabaseService databaseService = DatabaseService();
  HomePage homePage = const HomePage();
  PlanListPage planPage = const PlanListPage();
  late UserCalendarPage calendarPage = const UserCalendarPage();
  GlobalMapPage mapPage = const GlobalMapPage();

  @override
  void initState() {
    super.initState();
    allPages = [homePage, planPage, calendarPage, mapPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      body: allPages[selectedItem],
    );
  }

  Widget MyBottomNavBar() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color navBarColor =
        isDarkMode ? darkTheme.canvasColor : lightTheme.canvasColor;
    // print(navBarColor.toString());// mainGreen is your light theme color

    return Theme(
        data: ThemeData(canvasColor: navBarColor),
        child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "Plans",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Calendar",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: "Maps",
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedItem,
            onTap: (index) {
              setState(() {
                selectedItem = index;
              });
            }));
  }
}
