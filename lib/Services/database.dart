import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/liga.dart';
import 'package:flutter_auth/models/user.dart';

class DatabaseService {
  final String? uid;
  final List? ligen;
  DatabaseService({this.uid, this.ligen});
  UserData? userData2;

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('nutzerdaten');
  final CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');

  Future updateUserData(
      String? id, String nutzername, List ligen, String lieblingsverein) async {
    return await userCollection.doc(id).set({
      'Benutzername': nutzername,
      'Ligen': ligen,
      'Lieblingsverein': lieblingsverein
    }, SetOptions(merge: true));
  }

  Future addLigaToUserToLiga(Liga liga, String? userId, String? name) async {
    leagueCollection.doc(liga.ligalink).set({
      'tipper': {
        userId: {"points": "0", 'name': name, 'meinVerein': ''}
      }
    }, SetOptions(merge: true));
    return userCollection.doc(uid).update({
      'Ligen': FieldValue.arrayUnion([
        {
          'Verband': liga.verbandname,
          'Teamtyp': liga.teamtypsname,
          'Spielklasse': liga.spielklassename,
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

  Future deleteLiga(String ligaName) async {
    var userData = await userCollection.doc(uid).get();
    var ligen = userData['Ligen'];
    var neueLigaliste = [];
    for (var liga in ligen) {
      if (liga['Liga'] != ligaName) {
        neueLigaliste.add(liga);
      }
    }
    return userCollection.doc(uid).set({
      'Ligen': neueLigaliste,
    }, SetOptions(merge: true));
  }

  // Liste Nutzer
  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          uid: uid,
          benutzername: doc.get('Benutzername') ?? '',
          ligen: doc.get('Ligen') ?? ['Musterliga']);
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
        benutzername: snapshot.get('Benutzername') ?? "Fehler",
        ligen: snapshot.get('Ligen') ?? ['Musterliga'],
        lieblingsteam:
            snapshot.get('Lieblingsverein') ?? ['DJK Karlsruhe-Ost']);
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<List<Game>>> get gameday {
    return leagueCollection.snapshots().map(_gamedayFromSnapshot);
  }

  List<List<Game>> _gamedayFromSnapshot(QuerySnapshot snapshot) {
    List<List<Game>> gamedayList = [[], [], [], [], [], [], [], [], [], []];
    List<QueryDocumentSnapshot?> docs = [
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
      if (ligen != null) {
        for (Map liga in ligen!) {
          if (liga['Link'].contains(helper.id)) {
            docs[i] = helper;
            i++;
          }
        }
      }
    }

    var k = 0;

    for (QueryDocumentSnapshot? doc in docs) {
      if (docs[k] != null) {
        Map? list = doc!.get('spieltage');
        var j = 1;
        try {
          while (j < 40) {
            var i = 1;
            try {
              while (list![j.toString()][i.toString()]['home'] != "") {
                gamedayList[k].add(Game(
                    home: list[j.toString()][i.toString()]['home'] ?? '',
                    away: list[j.toString()][i.toString()]['away'] ?? '',
                    scoreHome:
                        list[j.toString()][i.toString()]['scoreHome'] ?? '?',
                    scoreAway:
                        list[j.toString()][i.toString()]['scoreAway'] ?? '?',
                    dateTime: DateTime.parse(list[j.toString()][i.toString()]
                            ['date'] ??
                        DateTime.now()),
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
