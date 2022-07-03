import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/components/gamedayCard.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:flutter_auth/shared/tpnStyle.dart';
import 'package:provider/provider.dart';

import '../../../Services/databaseLiga.dart';

class GameDayWidget extends StatefulWidget {
  final List<String> leagueCodes;
  GameDayWidget({required this.leagueCodes});

  @override
  _GameDayWidgetState createState() => _GameDayWidgetState(leagueCodes);
}

class _GameDayWidgetState extends State<GameDayWidget> {
  var spieltag = 1;
  var ligaNummer = 0;
  var noLeague = false;
  DatabaseServiceLiga databaseServiceLiga = new DatabaseServiceLiga();
  bool updatedOnce = false;
  late final Future? gamedayInfos;
  final List<String> leagueCodes;

  _GameDayWidgetState(this.leagueCodes);

  @override
  void initState() {
    super.initState();

    if (leagueCodes.isNotEmpty) {
      gamedayInfos = databaseServiceLiga
          .getCurrentandTotalGamedaysFromLeagues(leagueCodes);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Game> gameday = [];
    List<TextEditingController> textEditingControllersHome = [];
    List<TextEditingController> textEditingControllersAway = [];
    List<String?> currentGamedays = [];
    List<String?> totalGamedays = [];

    return Consumer<UserData?>(builder: (_, userdata, __) {
      if (userdata != null) {
        try {
          // ignore: unused_local_variable
          var x = userdata.ligen![ligaNummer]['Link'];
        } catch (e) {
          noLeague = true;
        }
        if (noLeague) {
          return Text(
            '(Bitte warten oder) Füge eine Liga hinzu. ->',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
          );
        } else {
          for (int i = 0; i < userdata.ligen!.length; i++) {
            leagueCodes.add(userdata.ligen![i]['Link']);
          }

          return FutureBuilder(
              future: gamedayInfos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var snapshotMap = snapshot.data as List<Tupel>;
                  for (int i = 0; i < snapshotMap.length; i++) {
                    Tupel tupel = snapshotMap[i];
                    currentGamedays.add(tupel.currentGameday);
                    totalGamedays.add(tupel.totalGamedays);
                  }
                  if (!updatedOnce) {
                    updatedOnce = true;
                    spieltag = int.parse(currentGamedays[0]!);
                  }
                  return Consumer<List<List<Game>>?>(builder: (_, games, __) {
                    if (games != null) {
                      for (Game game in games[ligaNummer]) {
                        if (game.spieltag == spieltag.toString() &&
                            !gameday.contains(game)) {
                          gameday.add(game);
                          noLeague = false;
                          textEditingControllersHome
                              .add(new TextEditingController());
                          textEditingControllersAway
                              .add(new TextEditingController());
                        }
                      }
                    }
                    return Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_left,
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    if (ligaNummer > 0) {
                                      setState(() {
                                        ligaNummer--;
                                        spieltag = int.parse(
                                            currentGamedays[ligaNummer]!);
                                      });
                                    }
                                  }),
                              Text(
                                userdata.ligen![ligaNummer]['Liga'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 2),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    if (ligaNummer <
                                        userdata.ligen!.length - 1) {
                                      setState(() {
                                        ligaNummer++;
                                        spieltag = int.parse(
                                            currentGamedays[ligaNummer]!);
                                      });
                                    }
                                  }),
                            ]),
                        Divider(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
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
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    height: 2),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    if (spieltag <
                                        int.parse(totalGamedays[ligaNummer] ??
                                            '50')) {
                                      setState(() {
                                        spieltag++;
                                      });
                                    }
                                  }),
                            ]),
                        Divider(),
                        Expanded(
                          child: GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.primaryVelocity! > 0) {
                                // User swiped Left
                                if (spieltag > 1) {
                                  setState(() {
                                    spieltag--;
                                  });
                                }
                              } else if (details.primaryVelocity! < 0) {
                                // User swiped Right
                                if (spieltag < 30) {
                                  setState(() {
                                    spieltag++;
                                  });
                                }
                              }
                            },
                            child: ListView.builder(
                                itemCount: gameday.length,
                                itemBuilder: (context, index) {
                                  return GamedayCard(
                                    gameday: gameday[index],
                                    leagueCode: userdata.ligen![ligaNummer]
                                        ['Link'],
                                    scoreHome:
                                        textEditingControllersHome[index],
                                    scoreAway:
                                        textEditingControllersAway[index],
                                  );
                                }),
                          ),
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: TPNColors.buttonGreen),
                          child: Text(
                            'Tipps speichern',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            List<String> scoreHome = [];
                            List<String> scoreAway = [];
                            for (int i = 0;
                                i < textEditingControllersAway.length;
                                i++) {
                              scoreHome.add(textEditingControllersHome[i].text);
                              scoreAway.add(textEditingControllersAway[i].text);
                            }
                            await databaseServiceLiga.submitPredictions(
                                userdata.uid,
                                scoreHome,
                                scoreAway,
                                spieltag.toString(),
                                userdata.ligen![ligaNummer]['Link']);
                          },
                        ),
                      ],
                    );
                  });
                } else {
                  return Loading();
                }
              });
        }
      } else {
        return Loading();
      }
    });
  }
}
