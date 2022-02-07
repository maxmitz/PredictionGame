import 'package:flutter/material.dart';
import 'package:flutter_auth/models/gameday.dart';
import 'package:intl/intl.dart';

class GamedayCard extends StatelessWidget {
  final Gameday gameday;

  //final UserData userData;

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
                  gameday.score +
                  "  " +
                  DateFormat.yMd()
                      .add_Hm()
                      .format(gameday.dateTime)
                      .toString()),
            ),
            Expanded(
                child: (gameday.dateTime.isAfter(DateTime.now()))
                    ? TextField(textAlign: TextAlign.center)
                    : Text('0', textAlign: TextAlign.center)),
            Expanded(
                child: (gameday.dateTime.isAfter(DateTime.now()))
                    ? TextField(textAlign: TextAlign.center)
                    : Text('0Resultat', textAlign: TextAlign.center)),
          ],
        ));
  }
}
