import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/components/gameDayWidget.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserData>(context);
    var ligen;
    try {
      ligen = userdata.ligen;
    } catch (e) {}

    void _showHelpPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Column(
                children: [
                  Text(
                      'Unter Ligen kannst du deine Ligen hinzufügen. Unter Tippen kannst du tippen. Unter Tippen kannst du deine Liga und den Spieltag aussuchen und dann die Ergebnisse eintragen. Vergangene Ergebnisse können nicht mehr getippt werden. Wenn du getippt hast und das Spiel eingetragen ist (das kann evtl. dauern) bekommst du 5 Punkte, wenn das Ergebnis genau stimmt, 3 Punkte, wenn die Tendenz stimmt (z.B. gewonnen mit einem Tor Vorsprung) und einen Punkte wenn die Richtung stimmt (gewonnen/ verloren). Viel Spaß!'),
                ],
              ),
            );
          });
    }

    return StreamProvider<List<List<Game>>>.value(
        value: DatabaseService(ligen: ligen).gameday,
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
                    actions: <Widget>[
                      TextButton.icon(
                        style: TextButton.styleFrom(primary: Colors.black),
                        icon: Icon(Icons.help_outline),
                        label: Text('Hilfe'),
                        onPressed: () {
                          _showHelpPanel();
                        },
                      ),
                    ]),
                body: SizedBox.expand(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/main_top.png'),
                            fit: BoxFit.cover)),
                    child: GameDayWidget(),
                  ),
                ))));
  }
}
