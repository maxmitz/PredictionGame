import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/game.dart';
import 'package:flutter_auth/models/user.dart';

import '../models/liga.dart';

class DatabaseServiceLiga {
  final String ligaid;
  DatabaseServiceLiga({this.ligaid});

  FirebaseFirestore _instance;
  List<UserData> _userDataList = [];

  CollectionReference leagueCollection =
      FirebaseFirestore.instance.collection('ligen');
  UserData newUser = new UserData(uid: '', benutzername: 'name', ligen: ['']);

  List<UserData> getUserDataFromLeague() {
    _userDataList.add(newUser);
    return _userDataList;
  }

  Future<UserData> getUserDataLeagueFromFirebase(String userID) async {
    _instance = FirebaseFirestore.instance;
    UserData user;

    DocumentSnapshot snapshot = await leagueCollection.doc(ligaid).get();
    var data = snapshot.data();
    var tipperDaten = data['tipper'] as Map;

    tipperDaten.forEach((key, value) {
      if (key == userID) {
        user = new UserData(
            uid: '',
            benutzername: value['name'],
            ligen: [''],
            lieblingsteam: value['meinVerein']);
      }
    });
    return user;
  }

  Future<void> updateUserDataLeagueFromFirebase(
      String userID, String meinVerein) async {
    leagueCollection.doc(ligaid).set({
      'tipper': {
        userID: {'meinVerein': meinVerein}
      }
    }, SetOptions(merge: true));
  }

  Future submitPredictionHome(String userName, String scoreHome,
      String matchNumber, String spieltag, String leagueCode) async {
    leagueCollection.doc(leagueCode).set({
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
      String matchNumber, String spieltag, String leagueCode) async {
    leagueCollection.doc(leagueCode).set({
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
    DocumentSnapshot snapshot = await leagueCollection.doc(ligaid).get();

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
    leagueCollection.doc(ligaid).set({
      'tipper': {
        userId: {"points": points.toString()}
      }
    }, SetOptions(merge: true));
  }
}
