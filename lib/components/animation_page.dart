import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth/components/untere_leiste.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:rive/rive.dart';

class AnimationPage extends StatelessWidget {
  final List<String> animations = [
    'assets/animations/cr7sui.riv',
    'assets/animations/derhatschongelb.riv',
    'assets/animations/lasstdenballlaufen.riv',
    'assets/animations/wenndiezweiteleutebraucht.riv',
    'assets/animations/alterbezirksliga.riv'
  ];
  final List<String> sprueche = [
    'EJJJJJJ, \nDa spielen doch welche aus der Ersten mit!',
    'EJJJJJJ SCHIRI, \nDER HAT SCHON GELB!',
    'JUUUUUNGS, \nLasst den Ball laufen!',
    'Wenn noch Leute für die Zweite gefunden werden müssen.',
    'Wenn der Alte von der SG Schöndorf früher mal Landesliga gespielt hat.'
  ];

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    final _randomNumber = _random.nextInt(animations.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'Animation',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              sprueche[_randomNumber],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            Divider(),
            Container(
              width: 400,
              height: 400,
              child: RiveAnimation.asset(animations[_randomNumber]),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UntereLeiste(),
                  ),
                );
              },
              child: Text('Weiter', style: TextStyle(color: Colors.black)),
              style: TextButton.styleFrom(
                  primary: Colors.green[200],
                  backgroundColor: Colors.green[200]),
            )
          ],
        ));
  }
}
