import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Einzelne_Liga/components/tabelle_daten.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';
import 'components/setting_form_einzelne_liga.dart';

class EinzelneLigaScreen extends StatelessWidget {
  final Map<String, dynamic>? liga;
  EinzelneLigaScreen({this.liga});

  @override
  Widget build(BuildContext context) {
    return Consumer<TheUser?>(builder: (_, user, __) {
      void _showSettingsPanel(String ligaName, String ligaID) {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsFormEinzelneLiga(ligaName, ligaID),
              );
            });
      }

      Future updatePoints() async {
        DatabaseServiceLiga databaseServiceLiga =
            new DatabaseServiceLiga(ligaid: liga!['Link']);
        await databaseServiceLiga.checkPointsForUser(user!.uid);
      }

      return FutureBuilder(
          future: updatePoints(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return StreamProvider<List<UserData>>.value(
                  value: DatabaseService().nutzerdaten,
                  initialData: [],
                  child: MaterialApp(
                    home: Scaffold(
                      appBar: AppBar(
                        backgroundColor: kPrimaryColor,
                        title: Text(
                          liga!['Liga'],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: <Widget>[
                          TextButton.icon(
                            style: TextButton.styleFrom(primary: Colors.black),
                            icon: Icon(Icons.settings),
                            label: Text('Einstellungen',
                                style: TextStyle(fontSize: 15)),
                            onPressed: () => _showSettingsPanel(
                                liga!['Liga'], liga!['Link']),
                          )
                        ],
                      ),
                      body: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/main_top.png'),
                                fit: BoxFit.cover)),
                        child: Column(children: <Widget>[
                          Text(
                            'Tabelle',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                height: 2),
                          ),
                          Expanded(child: Tabelledaten(liga))
                        ]),
                      ),
                    ),
                  ));
            }
          });
    });
  }
}
