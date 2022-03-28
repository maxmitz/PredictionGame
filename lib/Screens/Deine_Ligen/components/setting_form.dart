import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_auth/models/liga.dart';

import '../../../shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentVerband;
  String _currentTeamtyp;
  String _currentSpielklasse;
  String _currentLiga;
  String _currentLigaLink;

  List<String> teamtypshilfe =
      new List<String>.filled(1, 'Bitte zuerst Verband wählen', growable: true);
  List<String> spielklassehilfe =
      new List<String>.filled(1, 'Bitte zuerst Teamtyp wählen', growable: true);
  List<String> ligahilfe = new List<String>.filled(
      1, 'Bitte zuerst Spielklasse wählen',
      growable: true);
  var verbandgewaehlt = false;
  final List<String> alleverbaende = ['Baden', 'Rheinland'];
  final List<String> alleteamtypen = ['Herren'];
  final List<String> teamtypshilfe2 = ['Karlsruhe'];
  final List<String> teamtypshilfe3 = ['Trier/Saar'];
  final List<String> spielklassehilfe2 = ['Herren'];
  final String ligaLinkDJK = 'karlsruhe-kreisklasse-b2';
  final String ligaLinkTrier = 'kreisliga-b-triersaarburg';

  //Stream
  // ignore: close_sinks
  StreamController<List<String>> controller = StreamController();
  UserData userData;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userData = snapshot.data;
            if (userData.ligen.length > 2) {
              return Column(
                children: [
                  Text(
                    'Du kannst maximal 3 Ligen hinzufügen. Lösche eine Liga, um eine andere Liga hinzuzufügen.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              );
            } else {
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Auswahl Verband',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Bitte auswählen' : null,
                      items: alleverbaende.map((verband) {
                        return DropdownMenuItem(
                          value: verband ?? 'Wähle deine Verband aus',
                          child: Text('$verband'),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        _currentVerband = value;

                        setState(() {
                          teamtypshilfe = ['Herren'];
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Auswahl Teamtyp',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Bitte auswählen' : null,
                      items: teamtypshilfe.map((teamtyp) {
                        return DropdownMenuItem(
                          value: teamtyp ?? 'Wähle deinen Teamtyp aus',
                          child: Text('$teamtyp'),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        _currentTeamtyp = value;

                        setState(() {
                          if (_currentVerband == 'Rheinland') {
                            spielklassehilfe = ['Kreisliga B'];
                          } else {
                            spielklassehilfe = new List<String>.filled(
                                klassezuligaBaden.length, 'Hallo');
                            for (int j = 0; j < klassezuligaBaden.length; j++) {
                              spielklassehilfe[j] = klassezuligaBaden[j][0];
                            }
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Auswahl Spielklasse',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Bitte auswählen' : null,
                      items: spielklassehilfe.map((spielklasse) {
                        return DropdownMenuItem(
                          value: spielklasse ?? 'Wähle deine Spielklasse aus',
                          child: Text('$spielklasse'),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        _currentSpielklasse = value;
                        setState(() {
                          for (int i = 0; i < klassezuligaBaden.length; i++) {
                            if (_currentSpielklasse ==
                                klassezuligaBaden[i][0]) {
                              ligahilfe = new List<String>.filled(
                                  klassezuligaBaden[i].length - 1, 'Hallo');
                              for (int j = 1;
                                  j < klassezuligaBaden[i].length;
                                  j++) {
                                ligahilfe[j - 1] = klassezuligaBaden[i][j];
                              }
                            }
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Auswahl Liga',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Bitte auswählen' : null,
                      items: (_currentVerband == 'Rheinland')
                          ? ['Kreisliga B Trier/ Saarburg'].map((liga) {
                              return DropdownMenuItem(
                                value: liga ?? 'Wähle deinen Liga aus',
                                child: Text('$liga'),
                              );
                            }).toList()
                          : ligahilfe.map((liga) {
                              return DropdownMenuItem(
                                value: liga ?? 'Wähle deinen Liga aus',
                                child: Text('$liga'),
                              );
                            }).toList(),
                      onChanged: (String value) {
                        _currentLiga = value;
                        if (_currentVerband == 'Rheinland') {
                          _currentLigaLink = 'kreisliga-b-triersaarburg';
                        } else {
                          for (int i = 0; i < ligacodesBaden.length; i++) {
                            if (ligacodesBaden[i][0] == _currentLiga) {
                              _currentLigaLink = ligacodesBaden[i][1];
                            }
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                        style:
                            TextButton.styleFrom(primary: Colors.orange[200]),
                        child: Text(
                          'Hinzufügen',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Liga liga = Liga(
                                verbandname: _currentVerband,
                                teamtypsname: _currentTeamtyp,
                                spielklassename: _currentSpielklasse,
                                liganame: _currentLiga,
                                ligalink: _currentLigaLink);
                            await DatabaseService(uid: user.uid)
                                .addLigaToUserToLiga(
                                    liga, userData.uid, userData.benutzername);
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
            }
          } else {
            return Loading();
          }
        });
  }
}
