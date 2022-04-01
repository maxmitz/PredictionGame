import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/onboarding/helpOnboarding.dart';
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HelpOnboarding()));
                          }),
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
