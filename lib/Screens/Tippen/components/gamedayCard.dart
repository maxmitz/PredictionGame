import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GamedayCard extends StatelessWidget {
  final Game gameday;
  final String leagueCode;
  var scoreHome;
  var scoreAway;
  final formatDate = new DateFormat('dd.MM.yyyy');
  final formatDateWithTime = new DateFormat('dd.MM.yyyy hh:mm');

  DatabaseServiceLiga databaseServiceLiga;
  FirebaseFirestore _instance;
  CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');

  GamedayCard({this.gameday, this.leagueCode});

  Future getPredictionFromUser(String userName) async {
    _instance = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await leagueCollection.doc(leagueCode).get();
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
                  child: Text(''),
                );
              } else {
                return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 5,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(gameday.home,
                                            style: TextStyle(fontSize: 17)))),
                                Flexible(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(" vs ",
                                            style: TextStyle(fontSize: 17)))),
                                Flexible(
                                    flex: 5,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          gameday.away,
                                          style: TextStyle(fontSize: 17),
                                          textAlign: TextAlign.right,
                                        ))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(formatDate.format(gameday.dateTime).toString(),
                              style: TextStyle(fontSize: 17)),
                          Container(
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: (gameday.dateTime
                                          .isAfter(DateTime.now()))
                                      ? ((scoreHome == null)
                                          ? TextField(
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (text) {
                                                databaseServiceLiga
                                                    .submitPredictionHome(
                                                        user.uid,
                                                        text,
                                                        gameday.matchNumber,
                                                        gameday.spieltag,
                                                        leagueCode);
                                              },
                                              style: TextStyle(fontSize: 17))
                                          : TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: scoreHome,
                                              textAlign: TextAlign.center,
                                              onChanged: (text) {
                                                databaseServiceLiga
                                                    .submitPredictionHome(
                                                        user.uid,
                                                        text,
                                                        gameday.matchNumber,
                                                        gameday.spieltag,
                                                        leagueCode);
                                              },
                                              style: TextStyle(fontSize: 17)))
                                      : Text(
                                          (gameday.scoreHome == '')
                                              ? "Ergebnis noch nicht verfügbar"
                                              : gameday.scoreHome,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 17))),
                              Expanded(
                                  child: (gameday.dateTime
                                          .isAfter(DateTime.now()))
                                      ? ((scoreAway == null)
                                          ? TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              onChanged: (text) {
                                                databaseServiceLiga
                                                    .submitPredictionAway(
                                                        user.uid,
                                                        text,
                                                        gameday.matchNumber,
                                                        gameday.spieltag,
                                                        leagueCode);
                                              },
                                              style: TextStyle(fontSize: 17))
                                          : TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: scoreAway,
                                              textAlign: TextAlign.center,
                                              onChanged: (text) {
                                                databaseServiceLiga
                                                    .submitPredictionAway(
                                                        user.uid,
                                                        text,
                                                        gameday.matchNumber,
                                                        gameday.spieltag,
                                                        leagueCode);
                                              },
                                              style: TextStyle(fontSize: 17)))
                                      : Text(gameday.scoreAway,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 17))),
                            ]),
                          ),
                        ],
                      ),
                    ));
              }
            }));
  }
}
