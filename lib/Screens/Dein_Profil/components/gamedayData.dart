import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dein_Profil/components/nutzer_tile.dart';
import 'package:flutter_auth/Screens/Tippen/components/gameDayWidget.dart';
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
    final gamedayData = ['Bayern', 'Schalke', '1:2'];
    //final nutzerdaten = Provider.of<List<UserData>>(context) ?? [];

    return ListView.builder(
        itemCount: gamedayData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GamedayCard(
              hometeam: gamedayData[0],
              awayteam: gamedayData[1],
              score: gamedayData[2]);
        });
  }
}
