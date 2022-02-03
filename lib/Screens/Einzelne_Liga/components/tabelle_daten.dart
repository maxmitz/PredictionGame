import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dein_Profil/components/nutzer_tile.dart';
import 'package:flutter_auth/Screens/Deine_Ligen/components/ligen_tile.dart';
import 'package:flutter_auth/Screens/Einzelne_Liga/components/tabelle_tile.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class Tabelledaten extends StatefulWidget {
  @override
  _TabelledatenState createState() => _TabelledatenState();
}

class _TabelledatenState extends State<Tabelledaten> {
  Future getUsersFromLeague() async {
    var firestore = FirebaseFirestore.instance;

    DocumentSnapshot ds =
        await firestore.collection("Ligen").doc('_liga_bundesliga').get();

    return ds.get('tipper');
  }

  @override
  Widget build(BuildContext context) {
    List tipper = [''];
/*
    DatabaseServiceLiga ligaService = new DatabaseServiceLiga();
    Future.delayed(Duration(seconds: 1), () async {
      ligaService.getUserDataLeagueFromFirebase().then((value) => null);
      List tipper = ligaService.getUserDataFromLeague();
    });
*/

    return Container(
      child: FutureBuilder(
          future: getUsersFromLeague(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    var name = snapshot.data[index];
                    return ListTile(
                      title: Text(name["name"]),
                    );
                  });
            }
          }),
    );

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
