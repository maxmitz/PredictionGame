import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/components/gamedayData.dart';
import 'package:flutter_auth/Screens/Tippen/components/gameDayWidget.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/gameday.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Gameday>>.value(
        value: DatabaseServiceLiga().gameday,
        child: MaterialApp(
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  title: Text(
                    'Tippen',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                body: SizedBox.expand(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/main_top.png'),
                            fit: BoxFit.cover)),
                    child: Column(children: <Widget>[
                      Text(
                        'B-Klasse Karlsruhe Staffel 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 2),
                      ),
                      GameDayWidget(),
                      SingleChildScrollView(child: GameDayData())
                    ]),
                  ),
                ))));
  }
}
