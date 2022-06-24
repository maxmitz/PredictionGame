import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsFormEinzelneLiga extends StatefulWidget {
  String ligaName;
  String ligaID;
  SettingsFormEinzelneLiga(this.ligaName, this.ligaID);

  @override
  _SettingsFormEinzelneLigaState createState() =>
      _SettingsFormEinzelneLigaState(ligaName, ligaID);
}

class _SettingsFormEinzelneLigaState extends State<SettingsFormEinzelneLiga> {
  final _formKey = GlobalKey<FormState>();

  int? helfer;
  String? neueLiga;
  String ligaName;
  String ligaID;
  _SettingsFormEinzelneLigaState(this.ligaName, this.ligaID);
  UserData? ligaUser;
  String? _meinVerein;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (_, userData, __) {
      DatabaseServiceLiga(ligaid: ligaID)
          .getUserDataLeagueFromFirebase(userData.uid)
          .then((result) {
        setState(() {
          ligaUser = result;
        });
      });

      if (ligaUser != null) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Zu welchem Team fühlst du dich zugehörig?',
                style: TextStyle(fontSize: 18.0),
              ),
              TextFormField(
                initialValue: (ligaUser == null) ? '' : ligaUser!.lieblingsteam,
                validator: (val) =>
                    val!.isEmpty ? 'Gib dein Lieblingsteam ein.' : null,
                onChanged: (val) {
                  _meinVerein = val;
                },
              ),
              ElevatedButton(
                  style: TextButton.styleFrom(primary: Colors.orange[200]),
                  child: Text(
                    'Lieblingsteam aktualisieren',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    await DatabaseServiceLiga(ligaid: ligaID)
                        .updateUserDataLeagueFromFirebase(
                            userData.uid, _meinVerein);
                    Navigator.pop(context);
                    Navigator.of(context).pop();
                  }),
              Divider(),
              ElevatedButton(
                  style: TextButton.styleFrom(primary: Colors.orange[200]),
                  child: Text(
                    'Liga verlassen',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    await DatabaseService(uid: userData.uid)
                        .deleteLiga(ligaName);
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
