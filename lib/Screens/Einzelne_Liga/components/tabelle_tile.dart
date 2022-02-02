import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/einzelne_liga/einzelne_liga_screen.dart';

class TabelleTile extends StatelessWidget {
  final String tab;
  int platz;

  //final UserData userData;

  TabelleTile({this.tab, this.platz});

  @override
  Widget build(BuildContext context) {
    platz = platz + 1;
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.orange[200],
              backgroundImage: AssetImage('assets/images/signup_top.png'),
            ),
            title: Text('$platz. $tab'),
            subtitle: Text('Es funktioniert'),
            enabled: true,
          ),
        ));
  }
}
