import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/gameday.dart';
import 'package:flutter_auth/models/tabelle.dart';
import 'package:flutter_auth/models/user.dart';

class DatabaseServiceLiga {
  final String ligaid;
  DatabaseServiceLiga({this.ligaid});

  FirebaseFirestore _instance;
  List<UserData> _userDataList = [];

  CollectionReference ligaCollection =
      FirebaseFirestore.instance.collection('Ligen');
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

  //get user stream
  Stream<List<Gameday>> get gameday {
    return ligaCollection.snapshots().map(_gamedayFromSnapshot);
  }

  // Liste Nutzer
  List<Gameday> _gamedayFromSnapshot(QuerySnapshot snapshot) {
    List<Gameday> gamedayList = [];
    QueryDocumentSnapshot doc;
    for (QueryDocumentSnapshot helper in snapshot.docs) {
      if (helper.id == '_liga_bundesliga') {
        doc = helper;
      }
    }
    List list = doc.data()['spieltage'];
    for (var i = 0; i < list.length; i++) {
      gamedayList.add(Gameday(
          home: doc.data()['spieltage'][i]['home'] ?? '',
          away: doc.data()['spieltage'][i]['away'] ?? '',
          score: doc.data()['spieltage'][i]['score'] ?? ''));
    }
    return gamedayList;
  }
}
