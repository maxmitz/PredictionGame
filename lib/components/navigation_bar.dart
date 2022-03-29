import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/tippen_screen.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/deine_ligen_screen.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:new_version/new_version.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({Key key}) : super(key: key);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<CustomNavigationBar> {
  /*
  @override
  void initState() {
    super.initState();
    NewVersion(
      context: context,
      //TODO if app is available for iOS change this
      iOSId: 'com.google.Vespa',
      androidId: 'com.futipp',
    ).showAlertIfNecessary();
  }
  */
  int _selectedIndex = 1;

  List<Widget> _screens = [
    TippenScreen(),
    DeineLigenScreen(),
  ];

//Style of the icons:
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Tippen',
              backgroundColor: kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports),
              label: 'Ligen',
              backgroundColor: kPrimaryColor)
        ],
        selectedLabelStyle: TextStyle(color: Colors.white),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        showUnselectedLabels: true,
        onTap: _onTabTapped,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
