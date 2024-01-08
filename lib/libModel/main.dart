import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/add_attraction_page.dart';
import 'views/home_page.dart';
import 'view_models/attraction_provider.dart';
// import 'view_models/user_view_model.dart';
// Import other providers

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AttractionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavBarClass(),
    );
  }
}
class NavBarClass extends StatefulWidget {
  const NavBarClass({super.key});

  @override
  State<NavBarClass> createState() => _NavBarClassState();
}

class _NavBarClassState extends State<NavBarClass> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Nagły atak spawacza',
            ),



          ],
        ),
        body: <Widget>[
          HomePage(),
          AddAttractionPage(),
        ][currentPageIndex]);
  }
}

