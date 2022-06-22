import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../shared/loading.dart';

class GamedayCard extends StatelessWidget {
  final Game? gameday;
  final String? leagueCode;
  final TextEditingController? scoreHome;
  final TextEditingController? scoreAway;
  final formatDate = new DateFormat('dd.MM.yyyy');
  final formatDateWithTime = new DateFormat('dd.MM.yyyy hh:mm');

  final CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');

  GamedayCard({this.gameday, this.leagueCode, this.scoreAway, this.scoreHome});

  Future getPredictionFromUser(String? userName) async {
    DocumentSnapshot snapshot = await leagueCollection.doc(leagueCode).get();
    try {
      scoreHome!.text = snapshot['spieltage'][gameday!.spieltag]
          [gameday!.matchNumber]['tipps'][userName]['scoreHome'];
    } catch (e) {
      scoreHome!.text = "0";
    }

    try {
      scoreAway!.text = snapshot['spieltage'][gameday!.spieltag]
          [gameday!.matchNumber]['tipps'][userName]['scoreAway'];
    } catch (e) {
      scoreAway!.text = "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TheUser?>(builder: (_, user, __) {
      if (user != null) {
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
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 200),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    Flexible(
                                        flex: 5,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(gameday!.home!,
                                                style:
                                                    TextStyle(fontSize: 17)))),
                                    Flexible(
                                        flex: 1,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(" vs ",
                                                style:
                                                    TextStyle(fontSize: 17)))),
                                    Flexible(
                                        flex: 5,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              gameday!.away!,
                                              style: TextStyle(fontSize: 17),
                                              textAlign: TextAlign.right,
                                            ))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  formatDate
                                      .format(gameday!.dateTime!)
                                      .toString(),
                                  style: TextStyle(fontSize: 17)),
                              Container(
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: (gameday!.dateTime!
                                              .isAfter(DateTime.now()))
                                          ? (TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: scoreHome!.text,
                                              textAlign: TextAlign.center,
                                              maxLength: 2,
                                              decoration: InputDecoration(
                                                counterText: "",
                                              ),
                                              onChanged: (text) {
                                                scoreHome!.text = text;
                                              },
                                              style: TextStyle(fontSize: 17)))
                                          : Text(
                                              (gameday!.scoreHome == '')
                                                  ? "Ergebnis noch nicht verfügbar"
                                                  : gameday!.scoreHome!,
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
                                      child: (gameday!.dateTime!
                                              .isAfter(DateTime.now()))
                                          ? TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: scoreAway!.text,
                                              textAlign: TextAlign.center,
                                              maxLength: 2,
                                              decoration: InputDecoration(
                                                counterText: "",
                                              ),
                                              onChanged: (text) {
                                                scoreAway!.text = text;
                                              },
                                              style: TextStyle(fontSize: 17))
                                          : Text(gameday!.scoreAway!,
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
      } else {
        return Loading();
      }
    });
  }
}
