import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/liga.dart';
import 'package:flutter_auth/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('nutzerdaten');
  final CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');

  Future updateUserData(
      String id, String nutzername, List ligen, String lieblingsverein) async {
    return await userCollection.doc(id).set({
      'Benutzername': nutzername,
      'Ligen': ligen,
      'Lieblingsverein': lieblingsverein
    }, SetOptions(merge: true));
  }

  Future addLigaToUserToLiga(Liga liga, String userId, String name) async {
    leagueCollection.doc(liga.ligalink).set({
      'tipper': {
        userId: {"points": "0", 'name': name}
      }
    }, SetOptions(merge: true));
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

  // !!! delteLiga deletes now all Leagues
  Future deleteLiga(String liga) async {
    return userCollection.doc(uid).set({
      'Ligen': [],
    }, SetOptions(merge: true));
  }

  // Liste Nutzer
  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          uid: uid,
          benutzername: doc.data()['Benutzername'] ?? '',
          ligen: doc.data()['Ligen'] ?? ['Musterliga']);
    }).toList();
  }

  //get user stream
  Stream<List<UserData>> get nutzerdaten {
    return userCollection.snapshots().map(_userDataListFromSnapshot);
  }

  // userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid ?? "",
      benutzername: snapshot.data()['Benutzername'] ?? "Fehler",
      ligen: snapshot.data()['Ligen'] ?? ['Musterliga'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //get games stream
  Stream<List<List<Game>>> get gameday {
    return leagueCollection.snapshots().map(_gamedayFromSnapshot);
  }

  // Liste Games
  List<List<Game>> _gamedayFromSnapshot(QuerySnapshot snapshot) {
    List<List<Game>> gamedayList = [[], [], [], [], [], [], [], [], [], []];
    List<QueryDocumentSnapshot> docs = [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null
    ];
    var i = 0;
    for (QueryDocumentSnapshot helper in snapshot.docs) {
      if (helper.id == 'karlsruhe-kreisklasse-b2' ||
          helper.id == 'kreisliga-b-triersaarburg') {
        docs[i] = helper;
        i++;
      }
    }

    var k = 0;

    for (QueryDocumentSnapshot doc in docs) {
      if (docs[k] != null) {
        Map list = doc.data()['spieltage'];
        var j = 1;
        try {
          while (j < 40) {
            var i = 1;
            try {
              while (list[j.toString()][i.toString()]['home'] != "") {
                gamedayList[k].add(Game(
                    home: list[j.toString()][i.toString()]['home'] ?? '',
                    away: list[j.toString()][i.toString()]['away'] ?? '',
                    scoreHome:
                        list[j.toString()][i.toString()]['scoreHome'] ?? '?',
                    scoreAway:
                        list[j.toString()][i.toString()]['scoreAway'] ?? '?',
                    dateTime: DateTime.parse(
                            list[j.toString()][i.toString()]['date']) ??
                        DateTime.now(),
                    matchNumber: i.toString(),
                    spieltag: j.toString()));
                i++;
              }
            } catch (e) {}
            j++;
          }
          k++;
        } catch (e) {}
      }
    }
    return gamedayList;
  }
}
