import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/einzelne_liga/einzelne_liga_screen.dart';

class LigenTile extends StatelessWidget {
  final Map<String, dynamic>? liga;

  LigenTile({this.liga});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.orange[200],
          backgroundImage: AssetImage('assets/images/signup_top.png'),
        ),
        title: Text(liga!['Liga']),
        subtitle: Text(liga!['Teamtyp']),
        enabled: true,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EinzelneLigaScreen(liga: liga!)));
        },
      ),
    );
  }
}
