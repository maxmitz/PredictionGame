import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/components/gamedayCard.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class GameDayWidget extends StatefulWidget {
  @override
  _GameDayWidgetState createState() => _GameDayWidgetState();
}

class _GameDayWidgetState extends State<GameDayWidget> {
  // TODO aktueller Spieltag
  var spieltag = 1;
  var ligaNummer = 0;
  var noLeague = false;

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<List<List<Game>>>(context) ?? [[]];
    final user = Provider.of<TheUser>(context);
    final userdata = Provider.of<UserData>(context);

    List<Game> gameday = [];

    for (Game game in games[ligaNummer]) {
      if (game.spieltag == spieltag.toString()) {
        gameday.add(game);
        noLeague = false;
      }
    }
    try {
      var x = userdata.ligen[ligaNummer]['Link'];
    } catch (e) {
      noLeague = true;
    }

    if (userdata != null) {
      if (noLeague) {
        return Text(
          'Füge eine Liga hinzu. ->',
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
        );
      } else {
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 50,
                  ),
                  onPressed: () {
                    if (ligaNummer > 0) {
                      setState(() {
                        ligaNummer--;
                      });
                    }
                  }),
              Text(
                userdata.ligen[ligaNummer]['Link'] ?? 'Füge eine Liga hinzu',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 2),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    size: 50,
                  ),
                  onPressed: () {
                    if (ligaNummer < userdata.ligen.length - 1) {
                      setState(() {
                        ligaNummer++;
                      });
                    }
                  }),
            ]),
            Divider(),
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
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, height: 2),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    size: 50,
                  ),
                  onPressed: () {
                    //TODO richtiger Bereich
                    if (gameday.length != 0) {
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
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300),
                        //MediaQuery.of(context).size.height -300 -MediaQuery.of(context).padding.top), // constrain height
                        child: ListView.builder(
                            itemCount: gameday.length,
                            itemBuilder: (context, index) {
                              return GamedayCard(
                                  gameday: gameday[index],
                                  leagueCode: userdata.ligen[ligaNummer]
                                      ['Link']);
                            })))),
            Divider(),
          ],
        );
      }
    } else {
      return Loading();
    }
  }
}
