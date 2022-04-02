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
  TextEditingController scoreHome;
  TextEditingController scoreAway;
  final formatDate = new DateFormat('dd.MM.yyyy');
  final formatDateWithTime = new DateFormat('dd.MM.yyyy hh:mm');

  DatabaseServiceLiga databaseServiceLiga;
  CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');

  GamedayCard({this.gameday, this.leagueCode, this.scoreAway, this.scoreHome});

  Future getPredictionFromUser(String userName) async {
    DocumentSnapshot snapshot = await leagueCollection.doc(leagueCode).get();
    scoreHome.text = snapshot['spieltage'][gameday.spieltag]
        [gameday.matchNumber]['tipps'][userName]['scoreHome'];
    scoreAway.text = snapshot['spieltage'][gameday.spieltag]
        [gameday.matchNumber]['tipps'][userName]['scoreAway'];
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
                                      ? (TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: scoreHome.text ?? '',
                                          textAlign: TextAlign.center,
                                          maxLength: 2,
                                          decoration: InputDecoration(
                                            counterText: "",
                                          ),
                                          onChanged: (text) {
                                            scoreHome.text = text;
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
                              Text(" : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Expanded(
                                  child: (gameday.dateTime
                                          .isAfter(DateTime.now()))
                                      ? TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: scoreAway.text ?? '',
                                          textAlign: TextAlign.center,
                                          maxLength: 2,
                                          decoration: InputDecoration(
                                            counterText: "",
                                          ),
                                          onChanged: (text) {
                                            scoreAway.text = text;
                                          },
                                          style: TextStyle(fontSize: 17))
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
