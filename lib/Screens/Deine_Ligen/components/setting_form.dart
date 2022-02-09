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
  String _currentRegion;
  String _currentBezirk;
  String _currentKategorie;
  String _currentLiga;
  String _currentLigaLink;
  //List<String> bezirkshilfe = ['Bitte zuerst Region auswählen','','','','','','','','','',''];
  List<String> bezirkshilfe =
      new List<String>.filled(1, 'Bitte zuerst Region wählen', growable: true);
  List<String> kategoriehilfe =
      new List<String>.filled(1, 'Bitte zuerst Bezirk wählen', growable: true);
  List<String> ligahilfe = new List<String>.filled(
      1, 'Bitte zuerst Kategorie wählen',
      growable: true);
  var regiongewaehlt = false;
  final List<String> alleregionen2 = ['Mittelbaden'];
  final List<String> bezirkshilfe2 = ['Karlsruhe'];
  final List<String> kategoriehilfe2 = ['Herren'];
  final List<String> ligahilfe2 = ['Kreisklasse B2'];

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
                    'Auswahl Region',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: alleregionen2.map((region) {
                      return DropdownMenuItem(
                        value: region ?? 'Wähle deine Region aus',
                        child: Text('$region'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      _currentRegion = value;

                      setState(() {
                        for (int j = 0; j < allebezirke.length; j++)
                          if (_currentRegion == allebezirke[j][0]) {
                            bezirkshilfe = new List<String>.filled(
                                allebezirke[j].length, 'Hallo');
                            for (int i = 0; i < allebezirke[j].length; i++) {
                              bezirkshilfe[i] = allebezirke[j][i];
                            }
                          }
                      });
                    },
                  ),

                  SizedBox(height: 10.0),

                  Text(
                    'Auswahl Bezirk',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  //SizedBox(height: 10.0),
                  //dropdown
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: bezirkshilfe2.map((bezirk) {
                      return DropdownMenuItem(
                        value: bezirk ?? 'Wähle deinen Bezirk aus',
                        child: Text('$bezirk'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      _currentBezirk = value;

                      setState(() {
                        int i = 0;
                        for (int j = 0; j < alleligen.length; j++) {
                          if (_currentRegion == alleligen[j][0]) {
                            if (_currentBezirk == alleligen[j][1]) {
                              i = i + 1;
                            }
                          }
                        }
                        kategoriehilfe = new List<String>.filled(i, 'Hallo');
                        i = 0;
                        for (int j = 0; j < alleligen.length; j++) {
                          if (_currentRegion == alleligen[j][0]) {
                            if (_currentBezirk == alleligen[j][1]) {
                              kategoriehilfe[i] = alleligen[j][2];
                              i = i + 1;
                            }
                          }
                        }
                      });
                    },
                  ),

                  SizedBox(height: 10.0),

                  Text(
                    'Auswahl Kategorie',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  //SizedBox(height: 10.0),
                  //dropdown
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: kategoriehilfe2.map((kategorie) {
                      return DropdownMenuItem(
                        value: kategorie ?? 'Wähle deine Kategorie aus',
                        child: Text('$kategorie'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      _currentKategorie = value;
                      setState(() {
                        int helfer = 0;
                        for (int j = 0; j < alleligen.length; j++) {
                          if (_currentRegion == alleligen[j][0]) {
                            if (_currentBezirk == alleligen[j][1]) {
                              if (_currentKategorie == alleligen[j][2]) {
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
                  //SizedBox(height: 10.0),
                  //dropdown
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'Bitte auswählen' : null,
                    items: ligahilfe2.map((liga) {
                      return DropdownMenuItem(
                        value: liga ?? 'Wähle deinen Liga aus',
                        child: Text('$liga'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      _currentLiga = value;
                      for (int j = 0; j < alleligen.length; j++) {
                        if (_currentRegion == alleligen[j][0]) {
                          if (_currentBezirk == alleligen[j][1]) {
                            if (_currentKategorie == alleligen[j][2]) {
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
                              regionname: _currentRegion,
                              bezirksname: _currentBezirk,
                              kategoriename: _currentKategorie,
                              liganame: _currentLiga,
                              ligalink: _currentLigaLink);
                          await DatabaseService(uid: user.uid)
                              .addLigaToUserToLiga(liga, userData.benutzername);

                          //Ligen ligen = DatabaseService(uid: user.uid)  userData.ligen;
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
