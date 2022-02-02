import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/ligen_daten.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/setting_form.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class DeineLigenScreen extends StatelessWidget {
  @override
  //final AuthService _auth = AuthService();

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
              'Ligen',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.library_add),
                label: Text('Hinzufügen'),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover)),
              child: Ligendaten()),
        ),
      ),
    );
  }
}
