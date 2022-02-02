import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/components/einzelne_gruppe/einzelne_gruppe_screen.dart';

class GruppenTile extends StatelessWidget {

  final String gruppe;

  //final UserData userData;
  
  GruppenTile ({this.gruppe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.orange[200],
            backgroundImage: AssetImage('assets/images/signup_top.png'),
          ),
          title: Text(gruppe),
          subtitle: Text('Hier steht dein Platz'),
          enabled: true,
          onTap: (){
            Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => EinzelneGruppeScreen(gruppe : gruppe)
              )
            );
          },
        ),
        )
      );
  }
}