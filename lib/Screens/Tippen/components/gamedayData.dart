import 'package:flutter/material.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:provider/provider.dart';
import 'GamedayCardList.dart';

class GameDayData extends StatefulWidget {
  var whichGameday;
  GameDayData(String this.whichGameday);

  @override
  _GamedayDataState createState() => _GamedayDataState(whichGameday);
}

class _GamedayDataState extends State<GameDayData> {
  var whichGameday;
  _GamedayDataState(this.whichGameday);

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<List<Game>>(context) ?? [];

    List<Game> gameday = [];

    for (Game game in games) {
      if (game.spieltag == whichGameday) {
        gameday.add(game);
      }
    }

    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 100),
        itemCount: gameday.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GamedayCardList(gameday[index]);
        });
  }
}
