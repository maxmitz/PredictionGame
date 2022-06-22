import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth/models/liga.dart';

import '../../../shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String? _currentVerband;
  String? _currentTeamtyp;
  String? _currentSpielklasse;
  String? _currentLiga;
  String? _currentLigaLink;

  List<String> teamtypshilfe =
      new List<String>.filled(1, 'Bitte zuerst Verband wählen', growable: true);
  List<String> spielklassehilfe =
      new List<String>.filled(1, 'Bitte zuerst Teamtyp wählen', growable: true);
  List<String> ligahilfe = new List<String>.filled(
      1, 'Bitte zuerst Spielklasse wählen',
      growable: true);
  var verbandgewaehlt = false;
  final List<String> alleverbaende = ['Baden', 'Rheinland', 'Südbaden'];
  final List<String> alleteamtypen = ['Herren'];

  //Stream
  UserData? userData;
  @override
  Widget build(BuildContext context) {
    return Consumer<TheUser?>(builder: (_, user, __) {
      if (user != null) {
        return StreamBuilder<UserData?>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                userData = snapshot.data;
                if (userData!.ligen!.length > 2) {
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
                          validator: (dynamic value) =>
                              value == null ? 'Bitte auswählen' : null,
                          items: alleverbaende.map((verband) {
                            return DropdownMenuItem(
                              value: verband,
                              child: Text('$verband'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
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
                          validator: (dynamic value) =>
                              value == null ? 'Bitte auswählen' : null,
                          items: teamtypshilfe.map((teamtyp) {
                            return DropdownMenuItem(
                              value: teamtyp,
                              child: Text('$teamtyp'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            _currentTeamtyp = value;

                            setState(() {
                              spielklassehilfe = [];
                              for (int i = 0; i < ligacodes.length; i++) {
                                if (ligacodes[i][0] == _currentVerband) {
                                  if (ligacodes[i][1] == _currentTeamtyp) {
                                    spielklassehilfe.add(ligacodes[i][2]);
                                  }
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
                          validator: (dynamic value) =>
                              value == null ? 'Bitte auswählen' : null,
                          items: spielklassehilfe.map((spielklasse) {
                            return DropdownMenuItem(
                              value: spielklasse,
                              child: Text('$spielklasse'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            _currentSpielklasse = value;
                            setState(() {
                              ligahilfe = [];
                              for (int i = 0; i < ligacodes.length; i++) {
                                if (ligacodes[i][0] == _currentVerband) {
                                  if (ligacodes[i][1] == _currentTeamtyp) {
                                    if (ligacodes[i][2] ==
                                        _currentSpielklasse) {
                                      for (int j = 3;
                                          j < ligacodes[i].length;
                                          j = j + 2) {
                                        ligahilfe.add(ligacodes[i][j]);
                                      }
                                    }
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
                          validator: (dynamic value) =>
                              value == null ? 'Bitte auswählen' : null,
                          items: ligahilfe.map((liga) {
                            return DropdownMenuItem(
                              value: liga,
                              child: Text('$liga'),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            _currentLiga = value;
                            for (int i = 0; i < ligacodes.length; i++) {
                              if (ligacodes[i][0] == _currentVerband) {
                                if (ligacodes[i][1] == _currentTeamtyp) {
                                  if (ligacodes[i][2] == _currentSpielklasse) {
                                    for (int j = 3;
                                        j < ligacodes[i].length;
                                        j = j + 2) {
                                      if (ligacodes[i][j] == _currentLiga) {
                                        _currentLigaLink = ligacodes[i][j + 1];
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                            style: TextButton.styleFrom(
                                primary: Colors.orange[200]),
                            child: Text(
                              'Hinzufügen',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Liga liga = Liga(
                                    verbandname: _currentVerband,
                                    teamtypsname: _currentTeamtyp,
                                    spielklassename: _currentSpielklasse,
                                    liganame: _currentLiga,
                                    ligalink: _currentLigaLink);
                                await DatabaseService(uid: user.uid)
                                    .addLigaToUserToLiga(liga, userData!.uid,
                                        userData!.benutzername);
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
      } else {
        return Loading();
      }
    });
  }
}
