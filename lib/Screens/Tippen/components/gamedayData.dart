import 'package:flutter/material.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:provider/provider.dart';

import 'gamedayCard.dart';

class GameDayData extends StatefulWidget {
  @override
  _GamedayDataState createState() => _GamedayDataState();
}

class _GamedayDataState extends State<GameDayData> {
  @override
  Widget build(BuildContext context) {
    final games = Provider.of<List<Game>>(context) ?? [];

    List<Game> gameday = [];

    for (Game game in games) {}

    return ListView.builder(
        itemCount: gameday.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GamedayCard(gameday[index]);
        });
  }
}
