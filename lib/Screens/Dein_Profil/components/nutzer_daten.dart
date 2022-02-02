import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dein_Profil/components/nutzer_tile.dart';
import 'package:flutter_auth/models/user.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Nutzerdaten extends StatefulWidget {
  @override
  _NutzerdatenState createState() => _NutzerdatenState();
}

class _NutzerdatenState extends State<Nutzerdaten> {
  @override
  Widget build(BuildContext context) {
  
    final nutzerdaten = Provider.of<List<UserData>>(context) ?? [];


    return ListView.builder(
      itemCount: nutzerdaten.length,
      itemBuilder: (context,index) {
        return NutzerTile(nutzer: nutzerdaten[index]);

      }
    );
  }
}
