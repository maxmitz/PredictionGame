import 'package:flutter/material.dart';
import 'package:flutter_auth/models/user.dart';

class UserCardLeague extends StatelessWidget {
  final String name;
  final points;

  //final UserData userData;

  UserCardLeague({this.name, this.points});

  @override
  Widget build(BuildContext context) {
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
              title: Text(name),
              subtitle: Text('Punkte: ${points}')),
        ));
  }
}
