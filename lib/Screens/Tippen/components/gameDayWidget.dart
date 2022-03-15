import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/components/gamedayCard.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:provider/provider.dart';

class GameDayWidget extends StatefulWidget {
  @override
  _GameDayWidgetState createState() => _GameDayWidgetState();
}

class _GameDayWidgetState extends State<GameDayWidget> {
  // TODO aktueller Spieltag
  var spieltag = 1;

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<List<Game>>(context) ?? [];

    List<Game> gameday = [];

    for (Game game in games) {
      if (game.spieltag == spieltag.toString()) {
        gameday.add(game);
      }
    }
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(
                Icons.arrow_left,
                size: 50,
              ),
              onPressed: () {
                if (spieltag > 1) {
                  setState(() {
                    spieltag--;
                  });
                }
              }),
          Text(
            '$spieltag' + '. Spieltag',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 2),
          ),
          IconButton(
              icon: Icon(
                Icons.arrow_right,
                size: 50,
              ),
              onPressed: () {
                //TODO richtiger Bereich
                if (spieltag < 30) {
                  setState(() {
                    spieltag++;
                  });
                }
              }),
        ]),
        Divider(),
        SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity > 0) {
                    // User swiped Left
                    if (spieltag > 1) {
                      setState(() {
                        spieltag--;
                      });
                    }
                  } else if (details.primaryVelocity < 0) {
                    // User swiped Right
                    if (spieltag < 30) {
                      setState(() {
                        spieltag++;
                      });
                    }
                  }
                },
                child: SizedBox(
                    height: 293, // constrain height
                    child: ListView.builder(
                        itemCount: gameday.length,
                        itemBuilder: (context, index) {
                          return GamedayCard(gameday[index]);
                        }))))
      ],
    );
  }
}
