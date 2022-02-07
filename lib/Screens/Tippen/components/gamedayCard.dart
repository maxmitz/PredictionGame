import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/gameday.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GamedayCard extends StatelessWidget {
  final Gameday gameday;
  DatabaseServiceLiga databaseServiceLiga;

  GamedayCard(this.gameday);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
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
                    ? TextField(
                        textAlign: TextAlign.center,
                        onChanged: (text) {
                          databaseServiceLiga = new DatabaseServiceLiga();
                          databaseServiceLiga.submitPredictionHome(
                              user.uid, text);
                        })
                    : Text(gameday.scoreHome, textAlign: TextAlign.center)),
            Expanded(
                child: (gameday.dateTime.isAfter(DateTime.now()))
                    ? TextField(
                        textAlign: TextAlign.center,
                        onChanged: (text) {
                          databaseServiceLiga = new DatabaseServiceLiga();
                          databaseServiceLiga.submitPredictionAway(
                              user.uid, text);
                        })
                    : Text(gameday.scoreHome, textAlign: TextAlign.center)),
          ],
        ));
  }
}
