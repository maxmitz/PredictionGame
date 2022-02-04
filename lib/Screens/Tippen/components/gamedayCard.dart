import 'package:flutter/material.dart';
import 'package:flutter_auth/models/gameday.dart';

class GamedayCard extends StatelessWidget {
  final Gameday gameday;

  //final UserData userData;

  GamedayCard(this.gameday);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Text(
                gameday.home + " vs " + gameday.away + "  " + gameday.score)));
  }
}
