import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/components/einzelne_gruppe/setting_form_einzelne_Gruppe.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';

class EinzelneGruppeScreen extends StatelessWidget {
  //final AuthService _auth = AuthService();
  final String gruppe;
  EinzelneGruppeScreen({this.gruppe});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsFormEinzelneGruppe(),
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
              gruppe,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: Icon(Icons.settings),
                label: Text('Einstellungen', style: TextStyle(fontSize: 15)),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover)),
              child: Text('Hier stehen die Gruppendaten der Gruppe $gruppe')),
        ),
      ),
    );
  }
}
