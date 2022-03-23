import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
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

  // TODO die Logic vor dem 23.03.2022 war wahrscheinlich cleverer. Wichtig zu beachten vor nationaler Implementierung.
  var ligacodes_baden = [
    ['Oberliga Baden-Württemberg', 'oberliga-baden-wuerttemberg'],
    ['Verbandsliga Baden', 'verbandsliga-baden-fb-1'],
    ['Landesliga Mittelbaden', 'nordbaden-landesliga-mittelbaden-fb-1'],
    ['Landesliga Odenwald', 'nordbaden-landesliga-odenwald-fb-1'],
    ['Landesliga Rhein-Neckar', 'nordbaden-landesliga-rhein-neckar-fb-1'],
    ['Kreisliga Bruchsal', 'kreisliga-bruchsal-fb-1'],
    ['Kreisliga Buchen', 'kreisliga-buchen-fb-1'],
    ['Kreisliga Heidelberg', 'kreisliga-heidelberg-fb-1'],
    ['Kreisliga Karlsruhe', 'kreisliga-heidelberg-fb-1'],
    ['Kreisliga Mannheim', 'kreisliga-mannheim-fb-1'],
    ['Kreisliga Mosbach', 'kreisliga-mosbach-fb-1'],
    ['Kreisliga Pforzheim', 'kreisliga-pforzheim-fb-1'],
    ['Kreisliga Sinsheim', 'kreisliga-sinsheim-fb-1'],
    ['Kreisliga Tauberbischofsheim', 'kreisliga-tauberbischofsheim-fb-1'],
    ['Kreisklasse A Bruchsal', 'kreisklasse-a-bruchsal-fb-1'],
    ['Kreisklasse A Buchen', 'kreisklasse-a-buchen-fb-1'],
    ['Kreisklasse A Heidelberg', 'kreisklasse-a-heidelberg-fb-1'],
    ['Kreisklasse A Karlsruhe 1', 'kreisklasse-a-karlsruhe-1-fb-1'],
    ['Kreisklasse A Karlsruhe 2', 'kreisklasse-a-karlsruhe-2-fb-1'],
    ['Kreisklasse A Mannheim 1', 'kreisklasse-a-mannheim-1-fb-1'],
    ['Kreisklasse A Mannheim 2', 'kreisklasse-a-mannheim-2-fb-1'],
    ['Kreisklasse A Mosbach', 'kreisklasse-a-mosbach-fb-1'],
    ['Kreisklasse A Pforzheim 1', 'kreisklasse-a-pforzheim-1-fb-1'],
    ['Kreisklasse A Pforzheim 2', 'kreisklasse-a-pforzheim-2-fb-1'],
    ['Kreisklasse A Sinsheim', 'kreisklasse-a-sinsheim-fb-1'],
    [
      'Kreisklasse A Tauberbischofsheim',
      'kreisklasse-a-tauberbischofsheim-fb-1'
    ],
    ['Kreisklasse B Bruchsal Hardt', 'kreisklasse-b-bruchsal-hardt-fb-1'],
    ['Kreisklasse B Bruchsal Kraichgau', 'nordbaden-kk-b-bruchsal-fb-1'],
    ['Kreisklasse B Buchen', 'nordbaden-kk-b-buchen-1-fb-1'],
    ['Kreisklasse B Heidelberg', 'nordbaden-kk-b-heidelberg-fb-1'],
    ['Kreisklasse B Karlsruhe 1', 'nordbaden-kkb-karlsruhe-1-fb-1'],
    ['Kreisklasse B Karlsruhe 2', 'nordbaden-kkb-karlsruhe-2-fb-1'],
    ['Kreisklasse B Karlsruhe 3', 'nordbaden-kkb-karlsruhe-3-fb-1'],
    ['Kreisklasse B Mannheim 1', 'nordbaden-kk-b-mannheim-1-fb-1'],
    ['Kreisklasse B Mannheim 2', 'nordbaden-kk-b-mannheim-2-fb-1'],
    ['Kreisklasse B Mannheim 3', 'nordbaden-kk-a-mannheim-3-fb-1'],
    ['Kreisklasse B Mosbach 1', 'nordbaden-kk-b-mosbach-1-fb-1'],
    ['Kreisklasse B Mosbach 2', 'nordbaden-kk-b-mosbach-2-fb-1'],
    ['Kreisklasse B Pforzheim 1', 'nordbaden-kk-b-pforzheim-1-fb-1'],
    ['Kreisklasse B Pforzheim 2', 'nordbaden-kk-b-pforzheim-2-fb-1'],
    ['Kreisklasse B Sinsheim 1', 'nordbaden-kk-b-sinsheim-1-fb-1'],
    ['Kreisklasse B Sinsheim 2', 'nordbaden-kk-b-sinsheim-2-fb-1'],
    [
      'Kreisklasse B Tauberbischofsheim',
      'nordbaden-kk-b-tauberbischofsheim-fb-1'
    ],
    [
      'Kreisklasse C Heidelberg Ost',
      'nordbaden-kreisklasse-c-heidelberg-ost-6710'
    ],
    [
      'Kreisklasse C Heidelberg West',
      'nordbaden-kreisklasse-c-heidelberg-west-6709'
    ],
    ['Kreisklasse C Karlsruhe 1', 'nordbaden-kreisklasse-c-karlsruhe-1-6713'],
    ['Kreisklasse C Karlsruhe 2', 'nordbaden-kreisklasse-c-karlsruhe-2-6714'],
    ['Kreisklasse C Karlsruhe 3', 'nordbaden-kreisklasse-c-karlsruhe-3-6715'],
    ['Kreisklasse C Karlsruhe 4', 'nordbaden-kreisklasse-c-karlsruhe-4-6716'],
    ['Kreisklasse C Mannheim 1', 'nordbaden-kreisklasse-c-mannheim-1-6711'],
    ['Kreisklasse C Pforzheim 1', 'nordbaden-kreisklasse-c-pforzheim-1-6718'],
    ['Kreisklasse C Pforzheim 2', 'nordbaden-kreisklasse-c-pforzheim-2-6719'],
    ['Kreisklasse C Pforzheim 3', 'nordbaden-kreisklasse-c-pforzheim-3-6720'],
    [
      'Kreisklasse C Tauberbischofsheim',
      'nordbaden-kreisklasse-c-tauberbischofsheim-1-6721'
    ]
  ];
  final List klassezuliga_baden = [
    ['Oberliga', 'Oberliga Baden-Württemberg'],
    ['Verbandsliga', 'Verbandsliga Baden'],
    [
      'Landesliga',
      'Landesliga Mittelbaden',
      'Landesliga Odenwald',
      'Landesliga Rhein-Neckar'
    ],
    [
      'Kreisliga',
      'Kreisliga Bruchsal',
      'Kreisliga Buchen',
      'Kreisliga Heidelberg',
      'Kreisliga Karlsruhe',
      'Kreisliga Mannheim',
      'Kreisliga Mosbach',
      'Kreisliga Pforzheim',
      'Kreisliga Sinsheim',
      'Kreisliga Tauberbischofsheim'
    ],
    [
      'Kreisklasse A',
      'Kreisklasse A Bruchsal',
      'Kreisklasse A Buchen',
      'Kreisklasse A Heidelberg',
      'Kreisklasse A Karlsruhe 1',
      'Kreisklasse A Karlsruhe 2',
      'Kreisklasse A Mannheim 1',
      'Kreisklasse A Mannheim 2',
      'Kreisklasse A Mosbach',
      'Kreisklasse A Pforzheim 1',
      'Kreisklasse A Pforzheim 2',
      'Kreisklasse A Sinsheim',
      'Kreisklasse A Tauberbischofsheim'
    ],
    [
      'Kreisklasse B',
      'Kreisklasse B Bruchsal Hardt',
      'Kreisklasse B Bruchsal Kraichgau',
      'Kreisklasse B Buchen',
      'Kreisklasse B Heidelberg',
      'Kreisklasse B Karlsruhe 1',
      'Kreisklasse B Karlsruhe 2',
      'Kreisklasse B Karlsruhe 3',
      'Kreisklasse B Mannheim 1',
      'Kreisklasse B Mannheim 2',
      'Kreisklasse B Mannheim 3',
      'Kreisklasse B Mosbach 1',
      'Kreisklasse B Mosbach 2',
      'Kreisklasse B Pforzheim 1',
      'Kreisklasse B Pforzheim 2',
      'Kreisklasse B Sinsheim 1',
      'Kreisklasse B Sinsheim 2',
      'Kreisklasse B Tauberbischofsheim'
    ],
    [
      'Kreisklasse C',
      'Kreisklasse C Bruchsal Meisterrunde',
      'Kreisklasse C Bruchsal Platzierungsrunde',
      'Kreisklasse C Heidelberg Ost',
      'Kreisklasse C Heidelberg West',
      'Kreisklasse C Karlsruhe 1',
      'Kreisklasse C Karlsruhe 2',
      'Kreisklasse C Karlsruhe 3',
      'Kreisklasse C Karlsruhe 4',
      'Kreisklasse C Mannheim 1',
      'Kreisklasse C Pforzheim 1',
      'Kreisklasse C Pforzheim 2',
      'Kreisklasse C Pforzheim 3',
      'Kreisklasse C Tauberbischofsheim'
    ]
  ];
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
                              klassezuliga_baden.length, 'Hallo');
                          for (int j = 0; j < klassezuliga_baden.length; j++) {
                            spielklassehilfe[j] = klassezuliga_baden[j][0];
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
                        for (int i = 0; i < klassezuliga_baden.length; i++) {
                          if (_currentSpielklasse == klassezuliga_baden[i][0]) {
                            ligahilfe = new List<String>.filled(
                                klassezuliga_baden[i].length - 1, 'Hallo');
                            for (int j = 1;
                                j < klassezuliga_baden[i].length;
                                j++) {
                              ligahilfe[j - 1] = klassezuliga_baden[i][j];
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
                      for (int i = 0; i < ligacodes_baden.length; i++) {
                        if (ligacodes_baden[i][0] == _currentLiga) {
                          _currentLigaLink = ligacodes_baden[i][1];
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
          } else {
            return Loading();
          }
        });
  }
}
