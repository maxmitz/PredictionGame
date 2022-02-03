import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/tabelle.dart';
import 'package:flutter_auth/models/user.dart';

class DatabaseServiceLiga {
  final String ligaid;
  DatabaseServiceLiga({this.ligaid});

  FirebaseFirestore _instance;
  List<UserData> _userDataList = [];

  UserData newUser = new UserData(
      uid: '',
      benutzername: 'name',
      gruppen: [''],
      lieblingsverein: '',
      ligen: ['']);

  List<UserData> getUserDataFromLeague() {
    _userDataList.add(newUser);
    return _userDataList;
  }

  Future<void> getUserDataLeagueFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    CollectionReference ligaCollection =
        FirebaseFirestore.instance.collection('Ligen');

    DocumentSnapshot snapshot =
        await ligaCollection.doc('_liga_bundesliga').get();
    var data = snapshot.data();
    var tipperDaten = data['tipper'] as List<dynamic>;

    tipperDaten.forEach((element) {
      UserData user = new UserData(
          uid: '',
          benutzername: element['name'],
          gruppen: [''],
          lieblingsverein: '',
          ligen: ['']);
      _userDataList.add(user);
    });
  }

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
