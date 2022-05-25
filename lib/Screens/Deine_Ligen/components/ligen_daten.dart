import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/ligen_tile.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class Ligendaten extends StatefulWidget {
  @override
  _LigendatenState createState() => _LigendatenState();
}

class _LigendatenState extends State<Ligendaten> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData?>(builder: (_, user, __) {
      if (user != null) {
        return StreamBuilder<UserData?>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData userdata = snapshot.data!;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userdata.ligen!.length,
                          itemBuilder: (context, index) {
                            return LigenTile(liga: userdata.ligen![index]);
                          }),
                    ),
                    SizedBox(height: 20.0),
                    Text('Hier könnte deine Werbung stehen!'),
                    SizedBox(height: 20.0),
                    Expanded(
                        child: Text(
                      'Du kennst dich aus mit Python, Flutter, Marketing oder App-Design und hast Lust auf ein cooles Projekt? Melde dich!',
                      textAlign: TextAlign.center,
                    ))
                  ],
                );
              } else {
                return Loading();
              }
            });
      } else {
        return Loading();
      }
    });
  }
}
