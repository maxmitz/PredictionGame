import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/gameday.dart';
import 'package:intl/intl.dart';

class GamedayCard extends StatelessWidget {
  final Gameday gameday;
  DatabaseServiceLiga databaseServiceLiga;

  GamedayCard(this.gameday);

  @override
  Widget build(BuildContext context) {
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
                          databaseServiceLiga.submitPrediction('USER');
                        })
                    : Text(gameday.scoreHome, textAlign: TextAlign.center)),
            Expanded(
                child: (gameday.dateTime.isAfter(DateTime.now()))
                    ? TextField(textAlign: TextAlign.center)
                    : Text(gameday.scoreHome, textAlign: TextAlign.center)),
          ],
        ));
  }
}
