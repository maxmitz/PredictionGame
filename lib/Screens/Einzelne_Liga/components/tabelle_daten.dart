import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Einzelne_Liga/components/userCardLeague.dart';

class Tabelledaten extends StatefulWidget {
  @override
  final Map<String, dynamic> liga;
  Tabelledaten(this.liga);
  _TabelledatenState createState() => _TabelledatenState(liga: liga);
}

class _TabelledatenState extends State<Tabelledaten> {
  final Map<String, dynamic> liga;
  _TabelledatenState({this.liga});
  Future getUsersFromLeague() async {
    var firestore = FirebaseFirestore.instance;

    DocumentSnapshot ds =
        await firestore.collection("ligen").doc(liga['Link']).get();

    return ds.get('tipper');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getUsersFromLeague(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    var unsorted = snapshot.data;
                    var sorted = unsorted.keys.toList()
                      ..sort((a, b) => int.parse(unsorted[b]['points'])
                          .compareTo(int.parse(unsorted[a]['points'])));
                    var tipper = sorted[index];
                    return UserCardLeague(
                      name: unsorted[tipper]['name'],
                      points: unsorted[tipper]['points'],
                      position: (index + 1).toString(),
                    );
                  });
            }
          }),
    );
  }
}

class DokumentSnapshot {}
