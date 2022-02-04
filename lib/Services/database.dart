import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/Screens/Tippen/components/gamedayData.dart';
import 'package:flutter_auth/Services/databaseLiga.dart';
import 'package:flutter_auth/models/liga.dart';
import 'package:flutter_auth/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('nutzerdaten');
  final CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('Ligen');

  Future updateUserData(String nutzername, List ligen, List tippgruppen,
      String lieblingsverein) async {
    return await userCollection.doc(uid).set({
      'Benutzername': nutzername,
      'Ligen': ligen,
      'Tippgruppen': tippgruppen,
      'Lieblingsverein': lieblingsverein
    });
  }

  Future addLigaToUserToLiga(Liga liga, String userName) async {
    leagueCollection.doc('_liga_bundesliga').update({
      'tipper': FieldValue.arrayUnion([
        {"name": userName, "points": "0"}
      ])
    });
    return userCollection.doc(uid).update({
      'Ligen': FieldValue.arrayUnion([
        {
          'Region': liga.regionname,
          'Bezirk': liga.bezirksname,
          'Kategorie': liga.kategoriename,
          'Liga': liga.liganame,
          'Link': liga.ligalink
        }
      ]),
    });
  }

  Future addGruppe(String neueGruppe) async {
    return userCollection.doc(uid).update({
      'Tippgruppen': FieldValue.arrayUnion([neueGruppe]),
    });
  }

  Future deleteLiga(String liga) async {
    return userCollection.doc(uid).update({
      'Ligen': FieldValue.arrayRemove([liga]),
    });
  }

  // Liste Nutzer
  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          uid: uid,
          benutzername: doc.data()['Benutzername'] ?? '',
          lieblingsverein: doc.data()['Lieblingsverein'] ?? '',
          gruppen: doc.data()['Tippgruppen'] ?? ['Mustergruppe'],
          ligen: doc.data()['Ligen'] ?? ['Musterliga']);
    }).toList();
  }

  // userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      benutzername: snapshot.data()['Benutzername'],
      lieblingsverein: snapshot.data()['Lieblingsverein'],
      gruppen: snapshot.data()['Tippgruppen'],
      ligen: snapshot.data()['Ligen'],
    );
  }

  //get user stream
  Stream<List<UserData>> get nutzerdaten {
    return userCollection.snapshots().map(_userDataListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
