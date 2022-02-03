import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/tippen_screen.dart';
//import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/deine_ligen_screen.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/deine_tippgruppen_screen.dart';
import 'package:flutter_auth/Screens/Dein_Profil/dein_profil_screen.dart';
import 'package:flutter_auth/Screens/Uebersicht/uebersicht_screen.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/shared/constants.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 2;

  List<Widget> _screens = [
    TippenScreen(),
    DeineLigenScreen(),
    DeinProfilScreen()
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
              backgroundColor: kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
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
