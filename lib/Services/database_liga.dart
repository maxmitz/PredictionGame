import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/tabelle.dart';

class DatabaseServiceLiga {
  final String ligaid;
  DatabaseServiceLiga({this.ligaid});

  //collection reference
  final CollectionReference ligaCollection =
      FirebaseFirestore.instance.collection('Ligen');

  // userData from Snapshot
  /*List tabelleFromSnapshot(DocumentSnapshot snapshot, snapshot) {
    List help =
        snapshot.data()['Tabelle'] ?? ['kein Zugriff', 'wirklich kein Zugriff'];
    List tab;
    tab[0] = help[0]['Name'];
    tab[1] = help[1]['Name'];

    return tab;
  }*/

  /*get user stream
  Stream<Tabelle> get tabelle {
    return ligaCollection
        .doc('_liga_bundesliga')
        .snapshots()
        .map(_tabelleFromSnapshot);
  }
*/
  List get tabelleliste {
    return ['Schalke', 'Bayern', 'Dortmund'];
  }

  /* get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
*/
}
