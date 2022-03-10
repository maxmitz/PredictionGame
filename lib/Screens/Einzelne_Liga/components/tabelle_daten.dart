import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Einzelne_Liga/components/userCardLeague.dart';

class Tabelledaten extends StatefulWidget {
  @override
  _TabelledatenState createState() => _TabelledatenState();
}

class _TabelledatenState extends State<Tabelledaten> {
  Future getUsersFromLeague() async {
    var firestore = FirebaseFirestore.instance;

    DocumentSnapshot ds = await firestore
        .collection("ligen")
        .doc('karlsruhe-kreisklasse-b2')
        .get();

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
