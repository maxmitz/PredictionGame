import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/ligen_daten.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/setting_form.dart';
import 'package:flutter_auth/Screens/authenticate/authenticate.dart';
import 'package:flutter_auth/Services/auth.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class DeineLigenScreen extends StatelessWidget {
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

    void _showLigaPanel(UserData? userData) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
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

    return Consumer<TheUser>(builder: (_, user, __) {
      return StreamBuilder<UserData?>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data;

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
                        onPressed: () => _showSettingsPanel(),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(primary: Colors.black),
                        icon: Icon(Icons.settings),
                        label: Text('Einstellungen',
                            style: TextStyle(fontSize: 15)),
                        onPressed: () => _showLigaPanel(userData),
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
            } else {
              return Loading();
            }
          });
    });
  }
}
