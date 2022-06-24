import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/ligen_daten.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/setting_form.dart';
import 'package:flutter_auth/Services/auth.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:provider/provider.dart';

class DeineLigenScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showAddLeaguePanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    void _showLogoutPanel(UserData? userData) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        primary: Colors.green[200],
                        backgroundColor: Colors.green[200]),
                    child: Text(
                      'Ausloggen',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    return Consumer<UserData?>(builder: (_, userData, __) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(
              'Ligen',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.library_add),
                label: Text('Hinzufügen'),
                onPressed: () => _showAddLeaguePanel(),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.settings),
                label: Text(
                  'Einstellungen',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () => _showLogoutPanel(userData),
              ),
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover)),
              child: Ligendaten()),
        ),
      );
    });
  }
}
