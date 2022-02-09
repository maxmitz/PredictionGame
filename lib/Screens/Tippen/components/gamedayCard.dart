import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/gameday.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GamedayCard extends StatelessWidget {
  final Gameday gameday;
  var homeScore;
  var awayScore;

  DatabaseServiceLiga databaseServiceLiga;
  FirebaseFirestore _instance;
  CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('Ligen');

  GamedayCard(this.gameday);

  Future getPredictionFromUser(String userName) async {
    _instance = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await leagueCollection.doc('_liga_DJK').get();
    homeScore = snapshot['spieltage']['15'][gameday.matchNumber]['tipps']
        [userName]['homeScore'];
    awayScore = snapshot['spieltage']['15'][gameday.matchNumber]['tipps']
        [userName]['awayScore'];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    databaseServiceLiga = new DatabaseServiceLiga();

    return Container(
        child: FutureBuilder(
            future: getPredictionFromUser(user.uid),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading"),
                );
              } else {
                return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(gameday.home +
                              " vs " +
                              gameday.away +
                              "  " +
                              DateFormat.yMd()
                                  .add_Hm()
                                  .format(gameday.dateTime)
                                  .toString()),
                        ),
                        Expanded(
                            child: (gameday.dateTime.isAfter(DateTime.now()))
                                ? ((homeScore == null)
                                    ? TextField(
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionHome(user.uid,
                                                  text, gameday.matchNumber);
                                        })
                                    : TextFormField(
                                        initialValue: homeScore,
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionHome(user.uid,
                                                  text, gameday.matchNumber);
                                        }))
                                : Text(gameday.scoreHome,
                                    textAlign: TextAlign.center)),
                        Expanded(
                            child: (gameday.dateTime.isAfter(DateTime.now()))
                                ? ((awayScore == null)
                                    ? TextField(
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionAway(user.uid,
                                                  text, gameday.matchNumber);
                                        })
                                    : TextFormField(
                                        initialValue: awayScore,
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionAway(user.uid,
                                                  text, gameday.matchNumber);
                                        }))
                                : Text(gameday.scoreHome,
                                    textAlign: TextAlign.center)),
                      ],
                    ));
              }
            }));
  }
}
