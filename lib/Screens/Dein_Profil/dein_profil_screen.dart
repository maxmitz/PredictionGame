import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dein_Profil/components/settings_form.dart';
import 'package:flutter_auth/Services/auth.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/Screens/Dein_Profil/components/nutzer_daten.dart';

class DeinProfilScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().nutzerdaten,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(
              'Profil',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.person),
                label: Text('Abmelden'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.settings),
                label: Text('Einstellungen'),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  Text(
                    'Deine Freunde',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, height: 2),
                  ),
                  Expanded(child: Nutzerdaten()),
                ],
              )),
        ),
      ),
    );
  }
}
