import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsFormEinzelneLiga extends StatefulWidget {
  String liga;
  SettingsFormEinzelneLiga(this.liga);

  @override
  _SettingsFormEinzelneLigaState createState() =>
      _SettingsFormEinzelneLigaState(liga: liga);
}

class _SettingsFormEinzelneLigaState extends State<SettingsFormEinzelneLiga> {
  final _formKey = GlobalKey<FormState>();

  int helfer;
  String neueLiga;
  String liga;
  _SettingsFormEinzelneLigaState({this.liga});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                      style: TextButton.styleFrom(primary: Colors.orange[200]),
                      child: Text(
                        'Liga verlassen',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).deleteLiga(liga);
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
