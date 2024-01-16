import 'package:flutter/material.dart';
import 'package:tyskacz/DatabaseManagement/database.dart';
import 'package:tyskacz/DatabaseManagement/mocks.dart';
import 'package:tyskacz/Utils/Theme/themeConstant.dart';

import '../../DatabaseManagement/userInformation.dart';
import 'calendarPage.dart';
import 'homePage.dart';
import 'mapsPage.dart';
import 'plansListPage.dart';
import 'allAttractionspage.dart';

class NavBarClass extends StatefulWidget {
  const NavBarClass({super.key, required this.user});
  final User user;
  @override
  State<NavBarClass> createState() => _NavBarClassState();
}

class _NavBarClassState extends State<NavBarClass> {
  late User user = widget.user;
  int selectedItem = 0;
  late List allPages;
  DatabaseService databaseService = DatabaseService();
  HomePage homePage = const HomePage();
  late PlanListPage planPage = PlanListPage(user: user);
  AllAttractionsPage allAttractionsPage = const AllAttractionsPage();
  late UserCalendarPage calendarPage = UserCalendarPage(user: user);
  GlobalMapPage mapPage = const GlobalMapPage();

  @override
  void initState() {
    super.initState();
    allPages = [homePage, planPage, allAttractionsPage, calendarPage, mapPage];
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
                icon: Icon(Icons.access_time_sharp),
                label: "Attractions",
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
