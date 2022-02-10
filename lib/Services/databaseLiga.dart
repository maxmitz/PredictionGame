import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';

class DatabaseServiceLiga {
  final String ligaid;
  DatabaseServiceLiga({this.ligaid});

  FirebaseFirestore _instance;
  List<UserData> _userDataList = [];

  CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('Ligen');
  UserData newUser = new UserData(uid: '', benutzername: 'name', ligen: ['']);

  List<UserData> getUserDataFromLeague() {
    _userDataList.add(newUser);
    return _userDataList;
  }

  Future<void> getUserDataLeagueFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await leagueCollection.doc('_liga_DJK').get();
    var data = snapshot.data();
    var tipperDaten = data['tipper'] as List<dynamic>;

    tipperDaten.forEach((element) {
      UserData user =
          new UserData(uid: '', benutzername: element['name'], ligen: ['']);
      _userDataList.add(user);
    });
  }

  //get user stream
  Stream<List<Game>> get gameday {
    return leagueCollection.snapshots().map(_gamedayFromSnapshot);
  }

  // Liste Nutzer
  List<Game> _gamedayFromSnapshot(QuerySnapshot snapshot) {
    List<Game> gamedayList = [];
    QueryDocumentSnapshot doc;
    for (QueryDocumentSnapshot helper in snapshot.docs) {
      if (helper.id == '_liga_DJK') {
        doc = helper;
      }
    }
    Map list = doc.data()['spieltage'];
    var j = 15;
    try {
      while (list[j.toString()]['1']['home'] != "") {
        var i = 1;
        try {
          while (list[j.toString()][i.toString()]['home'] != "") {
            gamedayList.add(Game(
                home: list[j.toString()][i.toString()]['home'] ?? '',
                away: list[j.toString()][i.toString()]['away'] ?? '',
                scoreHome: list[j.toString()][i.toString()]['scoreHome'] ?? '?',
                scoreAway: list[j.toString()][i.toString()]['scoreAway'] ?? '?',
                dateTime: list[j.toString()][i.toString()]['date'].toDate() ??
                    DateTime.now(),
                matchNumber: i.toString(),
                spieltag: j.toString()));
            i++;
          }
        } catch (e) {}
        j++;
      }
    } catch (e) {}

    return gamedayList;
  }

  Future submitPredictionHome(String userName, String scoreHome,
      String matchNumber, String spieltag) async {
    leagueCollection.doc('_liga_DJK').set({
      'spieltage': {
        spieltag: {
          matchNumber: {
            'tipps': {
              userName: {'scoreHome': scoreHome}
            }
          },
        }
      }
    }, SetOptions(merge: true));
  }

  Future submitPredictionAway(String userName, String scoreAway,
      String matchNumber, String spieltag) async {
    leagueCollection.doc('_liga_DJK').set({
      'spieltage': {
        spieltag: {
          matchNumber: {
            'tipps': {
              userName: {'scoreAway': scoreAway}
            }
          },
        }
      }
    }, SetOptions(merge: true));
  }

  Future checkPointsForUser(String userId) async {
    var points = 0;
    DocumentSnapshot snapshot = await leagueCollection.doc('_liga_DJK').get();

    Map list = snapshot.data()['spieltage'];
    var j = 15;
    try {
      while (list[j.toString()]['1']['home'] != "") {
        var i = 1;
        try {
          while (list[j.toString()][i.toString()]['home'] != "") {
            var a = list[j.toString()][i.toString()]['scoreHome'];
            var b =
                list[j.toString()][i.toString()]['tipps'][userId]['scoreHome'];
            var c = list[j.toString()][i.toString()]['scoreAway'];
            var d =
                list[j.toString()][i.toString()]['tipps'][userId]['scoreAway'];
            var x = 1;
            if ((a == b) & (c == d)) {
              points += 5;
            } else if ((int.parse(a) - int.parse(c)) ==
                (int.parse(b) - int.parse(d))) {
              points += 3;
            } else if ((((int.parse(a) - int.parse(c)) < 0) &
                    ((int.parse(b) - int.parse(d)) < 0)) ||
                (((int.parse(a) - int.parse(c)) > 0) &
                    ((int.parse(b) - int.parse(d)) > 0)) ||
                ((int.parse(a) == int.parse(c)) &
                    (int.parse(b) == int.parse(d)))) {
              points += 1;
            }

            i++;
          }
        } catch (e) {}
        j++;
      }
    } catch (e) {}
    leagueCollection.doc('_liga_DJK').set({
      'tipper': {
        userId: {"points": points.toString()}
      }
    }, SetOptions(merge: true));
  }
}
