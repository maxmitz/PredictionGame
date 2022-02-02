import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Tippgruppen/components/gruppen_tile.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class Gruppendaten extends StatefulWidget {
  @override
  _GruppendatenState createState() => _GruppendatenState();
}

class _GruppendatenState extends State<Gruppendaten> {
  @override
  Widget build(BuildContext context) {
    //final nutzerdaten = Provider.of<List<UserData>>(context) ?? [];
    //final UserData = Provider.ofStream<UserData>(context);
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userdata = snapshot.data;

            return ListView.builder(
                itemCount: userdata.gruppen.length,
                itemBuilder: (context, index) {
                  return GruppenTile(gruppe: userdata.gruppen[index]);
                });
          } else {
            return Loading();
          }
        });
  }
}
