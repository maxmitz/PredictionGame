import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GamedayCard extends StatelessWidget {
  final Game gameday;
  var scoreHome;
  var scoreAway;

  DatabaseServiceLiga databaseServiceLiga;
  FirebaseFirestore _instance;
  CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');

  GamedayCard(this.gameday);

  Future getPredictionFromUser(String userName) async {
    _instance = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await leagueCollection.doc('_liga_DJK').get();
    scoreHome = snapshot['spieltage'][gameday.spieltag][gameday.matchNumber]
        ['tipps'][userName]['scoreHome'];
    scoreAway = snapshot['spieltage'][gameday.spieltag][gameday.matchNumber]
        ['tipps'][userName]['scoreAway'];
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
                                ? ((scoreHome == null)
                                    ? TextField(
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionHome(
                                                  user.uid,
                                                  text,
                                                  gameday.matchNumber,
                                                  gameday.spieltag);
                                        })
                                    : TextFormField(
                                        initialValue: scoreHome,
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionHome(
                                                  user.uid,
                                                  text,
                                                  gameday.matchNumber,
                                                  gameday.spieltag);
                                        }))
                                : Text(gameday.scoreHome,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))),
                        Expanded(
                            child: (gameday.dateTime.isAfter(DateTime.now()))
                                ? ((scoreAway == null)
                                    ? TextField(
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionAway(
                                                  user.uid,
                                                  text,
                                                  gameday.matchNumber,
                                                  gameday.spieltag);
                                        })
                                    : TextFormField(
                                        initialValue: scoreAway,
                                        textAlign: TextAlign.center,
                                        onChanged: (text) {
                                          databaseServiceLiga
                                              .submitPredictionAway(
                                                  user.uid,
                                                  text,
                                                  gameday.matchNumber,
                                                  gameday.spieltag);
                                        }))
                                : Text(gameday.scoreHome,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))),
                      ],
                    ));
              }
            }));
  }
}
