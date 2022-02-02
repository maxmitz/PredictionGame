import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class BeitretenForm extends StatefulWidget {
  @override
  _BeitretenFormState createState() => _BeitretenFormState();
}

class _BeitretenFormState extends State<BeitretenForm> {
  final _formKey = GlobalKey<FormState>();

  int helfer;
  String neueGruppe;

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
                  Text(
                    'Tritt einer Gruppe bei (Funktioniert nicht)',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.length < 3 ? 'Bitte Gruppennamen eingeben' : null,
                    onChanged: (val) => setState(() => neueGruppe = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  //slider
                  ElevatedButton(
                      style: TextButton.styleFrom(primary: Colors.orange[200]),
                      child: Text(
                        'Beitreten',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid)
                                .addGruppe(neueGruppe);
                            Navigator.pop(context);
                          }
                        }
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
