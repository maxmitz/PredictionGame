import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_auth/models/liga.dart';

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
  var alleteamtypen = ['Herren'];
  var ligacodes_baden = [
    'oberliga-baden-wuerttemberg',
    'verbandsliga-baden-fb-1',
    'nordbaden-landesliga-mittelbaden-fb-1',
    'nordbaden-landesliga-odenwald-fb-1',
    'nordbaden-landesliga-rhein-neckar-fb-1',
    'kreisliga-bruchsal-fb-1',
    'kreisliga-buchen-fb-1',
    'kreisliga-heidelberg-fb-1',
    'kreisliga-heidelberg-fb-1',
    'kreisliga-mannheim-fb-1',
    'kreisliga-mosbach-fb-1',
    'kreisliga-pforzheim-fb-1',
    'kreisliga-sinsheim-fb-1',
    'kreisliga-tauberbischofsheim-fb-1',
    'kreisklasse-a-bruchsal-fb-1',
    'kreisklasse-a-buchen-fb-1',
    'kreisklasse-a-heidelberg-fb-1',
    'kreisklasse-a-karlsruhe-1-fb-1',
    'kreisklasse-a-karlsruhe-2-fb-1',
    'kreisklasse-a-mannheim-1-fb-1',
    'kreisklasse-a-mannheim-2-fb-1',
    'kreisklasse-a-mosbach-fb-1',
    'kreisklasse-a-pforzheim-1-fb-1',
    'kreisklasse-a-pforzheim-2-fb-1',
    'kreisklasse-a-sinsheim-fb-1',
    'kreisklasse-a-tauberbischofsheim-fb-1',
    'kreisklasse-b-bruchsal-hardt-fb-1',
    'nordbaden-kk-b-bruchsal-fb-1',
    'nordbaden-kk-b-buchen-1-fb-1',
    'nordbaden-kk-b-heidelberg-fb-1',
    'nordbaden-kkb-karlsruhe-1-fb-1',
    'nordbaden-kkb-karlsruhe-2-fb-1',
    'nordbaden-kkb-karlsruhe-3-fb-1',
    'nordbaden-kk-b-mannheim-1-fb-1',
    'nordbaden-kk-b-mannheim-2-fb-1',
    'nordbaden-kk-a-mannheim-3-fb-1',
    'nordbaden-kk-b-mosbach-1-fb-1',
    'nordbaden-kk-b-mosbach-2-fb-1',
    'nordbaden-kk-b-pforzheim-1-fb-1',
    'nordbaden-kk-b-pforzheim-2-fb-1',
    'nordbaden-kk-b-sinsheim-1-fb-1',
    'nordbaden-kk-b-sinsheim-2-fb-1',
    'nordbaden-kk-b-tauberbischofsheim-fb-1',
    'nordbaden-kreisklasse-c-heidelberg-ost-6710',
    'nordbaden-kreisklasse-c-heidelberg-west-6709',
    'nordbaden-kreisklasse-c-karlsruhe-1-6713',
    'nordbaden-kreisklasse-c-karlsruhe-2-6714',
    'nordbaden-kreisklasse-c-karlsruhe-3-6715',
    'nordbaden-kreisklasse-c-karlsruhe-4-6716',
    'nordbaden-kreisklasse-c-mannheim-1-6711',
    'nordbaden-kreisklasse-c-pforzheim-1-6718',
    'nordbaden-kreisklasse-c-pforzheim-2-6719',
    'nordbaden-kreisklasse-c-pforzheim-3-6720',
    'nordbaden-kreisklasse-c-tauberbischofsheim-1-6721'
  ];
  List<String> teamtypshilfe =
      new List<String>.filled(1, 'Bitte zuerst Verband wählen', growable: true);
  List<String> spielklassehilfe =
      new List<String>.filled(1, 'Bitte zuerst Teamtyp wählen', growable: true);
  List<String> ligahilfe = new List<String>.filled(
      1, 'Bitte zuerst Spielklasse wählen',
      growable: true);
  var verbandgewaehlt = false;
  final List<String> alleverbanden2 = ['Mittelbaden', 'Rheinland'];
  final List<String> teamtypshilfe2 = ['Karlsruhe'];
  final List<String> teamtypshilfe3 = ['Trier/Saar'];
  final List<String> spielklassehilfe2 = ['Herren'];
  final List<String> ligahilfe2 = ['Kreisklasse B2'];
  final List<String> ligahilfe3 = ['Kreisliga B'];
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
                    items: alleverbanden2.map((verband) {
                      return DropdownMenuItem(
                        value: verband ?? 'Wähle deine Verband aus',
                        child: Text('$verband'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      _currentVerband = value;

                      setState(() {
                        for (int j = 0; j < alleteamtypen.length; j++)
                          if (_currentVerband == alleteamtypen[j][0]) {
                            teamtypshilfe = new List<String>.filled(
                                alleteamtypen[j].length, 'Hallo');
                            for (int i = 0; i < alleteamtypen[j].length; i++) {
                              teamtypshilfe[i] = alleteamtypen[j][i];
                            }
                          }
                      });
                    },
                  ),

                  SizedBox(height: 10.0),

                  Text(
                    'Auswahl Teamtyp',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  //SizedBox(height: 10.0),
                  //dropdown
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: (_currentVerband == alleverbanden2[0])
                        ? teamtypshilfe2.map((teamtyp) {
                            return DropdownMenuItem(
                              value: teamtyp ?? 'Wähle deinen Teamtyp aus',
                              child: Text('$teamtyp'),
                            );
                          }).toList()
                        : teamtypshilfe3.map((teamtyp) {
                            return DropdownMenuItem(
                              value: teamtyp ?? 'Wähle deinen Teamtyp aus',
                              child: Text('$teamtyp'),
                            );
                          }).toList(),
                    onChanged: (String value) {
                      _currentTeamtyp = value;

                      setState(() {
                        int i = 0;
                        for (int j = 0; j < alleligen.length; j++) {
                          if (_currentVerband == alleligen[j][0]) {
                            if (_currentTeamtyp == alleligen[j][1]) {
                              i = i + 1;
                            }
                          }
                        }
                        spielklassehilfe = new List<String>.filled(i, 'Hallo');
                        i = 0;
                        for (int j = 0; j < alleligen.length; j++) {
                          if (_currentVerband == alleligen[j][0]) {
                            if (_currentTeamtyp == alleligen[j][1]) {
                              spielklassehilfe[i] = alleligen[j][2];
                              i = i + 1;
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
                  //SizedBox(height: 10.0),
                  //dropdown
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: spielklassehilfe2.map((spielklasse) {
                      return DropdownMenuItem(
                        value: spielklasse ?? 'Wähle deine Spielklasse aus',
                        child: Text('$spielklasse'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      _currentSpielklasse = value;
                      setState(() {
                        int helfer = 0;
                        for (int j = 0; j < alleligen.length; j++) {
                          if (_currentVerband == alleligen[j][0]) {
                            if (_currentTeamtyp == alleligen[j][1]) {
                              if (_currentSpielklasse == alleligen[j][2]) {
                                helfer = alleligen[j].length - 3;
                                ligahilfe =
                                    new List<String>.filled(helfer, 'Hallo');
                                int i = 0;
                                for (int k = 3;
                                    k < alleligen[j].length;
                                    k = k + 2) {
                                  ligahilfe[i] = alleligen[j][k];
                                  i = i + 1;
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
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: (_currentVerband == alleverbanden2[0])
                        ? ligahilfe2.map((liga) {
                            return DropdownMenuItem(
                              value: liga ?? 'Wähle deinen Liga aus',
                              child: Text('$liga'),
                            );
                          }).toList()
                        : ligahilfe3.map((liga) {
                            return DropdownMenuItem(
                              value: liga ?? 'Wähle deinen Liga aus',
                              child: Text('$liga'),
                            );
                          }).toList(),
                    onChanged: (String value) {
                      _currentLiga = value;
                      for (int j = 0; j < alleligen.length; j++) {
                        if (_currentVerband == alleligen[j][0]) {
                          if (_currentTeamtyp == alleligen[j][1]) {
                            if (_currentSpielklasse == alleligen[j][2]) {
                              for (int k = 3;
                                  k < alleligen[j].length;
                                  k = k + 2) {
                                if (_currentLiga == alleligen[j][k]) {
                                  _currentLigaLink = alleligen[j][k + 1];
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
                      style: TextButton.styleFrom(primary: Colors.orange[200]),
                      child: Text(
                        'Aktualisieren',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Liga liga = Liga(
                              verbandname: _currentVerband,
                              teamtypsname: _currentTeamtyp,
                              spielklassename: _currentSpielklasse,
                              liganame: _currentLiga,
                              ligalink: (_currentVerband == alleverbanden2[0])
                                  ? ligaLinkDJK
                                  : ligaLinkTrier);
                          await DatabaseService(uid: user.uid)
                              .addLigaToUserToLiga(
                                  liga, userData.uid, userData.benutzername);
                          Navigator.pop(context);
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
