import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/ligen_tile.dart';
import 'package:flutter_auth/Screens/Einzelne_Liga/components/tabelle_tile.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/Services/database_liga.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class Tabelledaten extends StatefulWidget {
  @override
  _TabelledatenState createState() => _TabelledatenState();
}

class _TabelledatenState extends State<Tabelledaten> {
  //List tab = DatabaseServiceLiga().tabelleliste;
  //List tab = DatabaseServiceLiga().tabelleFromSnapshot(DokumentSnapshot snapshot);

  @override
  Widget build(BuildContext context) {
    return Text("HALLO");
    /*
      ListView.builder(
          itemCount: tab.length,
          itemBuilder: (context, index) {
            return TabelleTile(tab: tab[index], platz: index);
          });
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
              return Loading();
            }
          });
  
          */
  }
}

class DokumentSnapshot {}
