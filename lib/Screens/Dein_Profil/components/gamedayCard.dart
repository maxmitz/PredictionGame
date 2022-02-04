import 'package:flutter/material.dart';
import 'package:flutter_auth/models/user.dart';

class GamedayCard extends StatelessWidget {
  final String hometeam;
  final String awayteam;
  final String score;

  //final UserData userData;

  GamedayCard({this.hometeam, this.awayteam, this.score});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Text(hometeam + " vs " + awayteam + "  " + score)));
  }
}
