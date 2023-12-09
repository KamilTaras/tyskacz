import 'package:flutter/material.dart';
import 'package:tyskacz/Pages/calendarPage.dart';
import 'package:tyskacz/Pages/homePage.dart';

import '../constantValues.dart';
import 'mapsPage.dart';
import 'plansPage.dart';

class NavBarClass extends StatefulWidget {
  const NavBarClass({super.key});

  @override
  State<NavBarClass> createState() => _NavBarClassState();
}

class _NavBarClassState extends State<NavBarClass> {
  int selectedItem = 0;
  late List allPages;

  HomePage homePage = HomePage();
  PlanPage planPage = PlanPage();
  CalendarPage calendarPage = CalendarPage();
  MapPage mapPage = MapPage();

  @override
  void initState() {
    // TODO: implement initState
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
    return Theme(
        data: ThemeData(canvasColor: Constant.mainGreenColor),
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
