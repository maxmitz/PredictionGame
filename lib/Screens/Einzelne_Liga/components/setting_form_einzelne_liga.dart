import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsFormEinzelneLiga extends StatefulWidget {
  final String ligaName;
  final String ligaID;
  SettingsFormEinzelneLiga(this.ligaName, this.ligaID);

  @override
  _SettingsFormEinzelneLigaState createState() =>
      _SettingsFormEinzelneLigaState();
}

class _SettingsFormEinzelneLigaState extends State<SettingsFormEinzelneLiga> {
  final _formKey = GlobalKey<FormState>();

  int? helfer;
  String? neueLiga;
  UserData? ligaUser;
  String? _meinVerein;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (_, userData, __) {
      DatabaseServiceLiga(ligaid: widget.ligaID)
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
                    await DatabaseServiceLiga(ligaid: widget.ligaID)
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
                        .deleteLiga(widget.ligaID);
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
