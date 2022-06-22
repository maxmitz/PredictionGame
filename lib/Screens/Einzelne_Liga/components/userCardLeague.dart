import 'package:flutter/material.dart';

class UserCardLeague extends StatelessWidget {
  final String name;
  final String points;
  final String position;
  final String? meinVerein;

  //final UserData userData;

  UserCardLeague(this.name, this.points, this.position, {this.meinVerein});

  @override
  Widget build(BuildContext context) {
    String meinVereinHelper;
    meinVereinHelper = meinVerein ?? '';

    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.purple[50],
                child: Text(
                  '$position.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              title: Text(name),
              subtitle:
                  Text('Punkte: $points \nMein Verein: $meinVereinHelper')),
        ));
  }
}
