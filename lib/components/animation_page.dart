import 'package:flutter/material.dart';
import 'package:flutter_auth/components/untere_leiste.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:rive/rive.dart';

class AnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'Juuuuuungs, \nLasst den Ball laufen!',
              textAlign: TextAlign.center,
            ),
            Divider(),
            //Container(width: 400,child: RiveAnimation.asset('assets/animations/lasstdenballlaufen.riv'),),
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
