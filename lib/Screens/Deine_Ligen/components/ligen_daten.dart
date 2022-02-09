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
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userdata = snapshot.data;

            return ListView.builder(
                itemCount: userdata.ligen.length,
                itemBuilder: (context, index) {
                  return LigenTile(liga: userdata.ligen[index]);
                });
          } else {
            return Text("Füge eine Liga hinzu");
            //return Loading();
          }
        });
  }
}
