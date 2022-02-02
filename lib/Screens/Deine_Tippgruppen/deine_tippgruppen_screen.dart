import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/components/beitreten_form.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/components/gruppen_daten.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/components/setting_form.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';

class DeineTippgruppenScreen extends StatelessWidget {
  @override
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

    void _showBeitretenPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: BeitretenForm(),
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
              'Gruppen',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.library_add),
                label: Text('Erstellen', style: TextStyle(fontSize: 15)),
                onPressed: () => _showSettingsPanel(),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.group_add),
                label: Text('Beitreten', style: TextStyle(fontSize: 15)),
                onPressed: () => _showBeitretenPanel(),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover)),
              child: Gruppendaten()),
        ),
      ),
    );
  }
}
