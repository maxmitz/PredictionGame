import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsFormEinzelneLiga extends StatefulWidget {
  String ligaLink;
  SettingsFormEinzelneLiga(this.ligaLink);

  @override
  _SettingsFormEinzelneLigaState createState() =>
      _SettingsFormEinzelneLigaState(ligaLink: ligaLink);
}

class _SettingsFormEinzelneLigaState extends State<SettingsFormEinzelneLiga> {
  final _formKey = GlobalKey<FormState>();

  int helfer;
  String neueLiga;
  String ligaLink;
  _SettingsFormEinzelneLigaState({this.ligaLink});
  UserData ligaUser;
  String _meinVerein;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //UserData userData = snapshot.data;
            DatabaseServiceLiga(ligaid: ligaLink)
                .getUserDataLeagueFromFirebase(user.uid)
                .then((result) {
              setState(() {
                ligaUser = result;
              });
            });
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Zu welchem Team fühlst du dich zugehörig?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextFormField(
                    initialValue:
                        (ligaUser != null) ? ligaUser.lieblingsteam : '',
                    validator: (val) =>
                        val.isEmpty ? 'Gib dein Lieblingsteam ein.' : null,
                    onChanged: (val) {
                      _meinVerein = val;
                    },
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(primary: Colors.orange[200]),
                      child: Text(
                        'Lieblingsteam speichern',
                        style: TextStyle(color: Colors.black),
                      ),
                      //TODO füge verein zu ligatipp hinzu
                      onPressed: () async {
                        await DatabaseServiceLiga(ligaid: ligaLink)
                            .updateUserDataLeagueFromFirebase(
                                user.uid, _meinVerein);
                        //Navigator.pop(context);
                      }),
                  Divider(),
                  ElevatedButton(
                      style: TextButton.styleFrom(primary: Colors.orange[200]),
                      child: Text(
                        'Liga verlassen',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: user.uid)
                            .deleteLiga(ligaLink);
                        Navigator.pop(context);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
