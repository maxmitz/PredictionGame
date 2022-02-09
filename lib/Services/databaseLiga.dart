import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/gameday.dart';
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
  Stream<List<Gameday>> get gameday {
    return leagueCollection.snapshots().map(_gamedayFromSnapshot);
  }

  // Liste Nutzer
  List<Gameday> _gamedayFromSnapshot(QuerySnapshot snapshot) {
    List<Gameday> gamedayList = [];
    QueryDocumentSnapshot doc;
    for (QueryDocumentSnapshot helper in snapshot.docs) {
      if (helper.id == '_liga_DJK') {
        doc = helper;
      }
    }
    Map list = doc.data()['spieltage']["15"]['spiele'];
    var i = 1;
    try {
      while (list[i.toString()]['home'] != "") {
        gamedayList.add(Gameday(
            home: list[i.toString()]['home'] ?? '',
            away: list[i.toString()]['away'] ?? '',
            scoreHome: list[i.toString()]['scoreHome'] ?? '?',
            scoreAway: list[i.toString()]['scoreAway'] ?? '?',
            dateTime: list[i.toString()]['date'].toDate() ?? DateTime.now(),
            matchNumber: i.toString()));
        i++;
      }
    } catch (e) {}
    return gamedayList;
  }

  Future submitPredictionHome(
      String userName, String scoreHome, String matchNumber) async {
    leagueCollection.doc('_liga_DJK').set({
      'spieltage': {
        '15': {
          'spiele': {
            matchNumber: {
              'tipps': {
                userName: {'homeScore': scoreHome}
              }
            },
          }
        }
      }
    }, SetOptions(merge: true));
  }

  Future submitPredictionAway(
      String userName, String scoreAway, String matchNumber) async {
    leagueCollection.doc('_liga_DJK').set({
      'spieltage': {
        '15': {
          'spiele': {
            matchNumber: {
              'tipps': {
                userName: {'awayScore': scoreAway}
              }
            },
          }
        }
      }
    }, SetOptions(merge: true));
  }
}
