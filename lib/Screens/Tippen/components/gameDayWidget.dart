import 'package:flutter/material.dart';

class GameDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      IconButton(
          icon: Icon(
            Icons.arrow_left,
            size: 50,
          ),
          onPressed: () {}),
      Text(
        '15. Spieltag',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 2),
      ),
      IconButton(
          icon: Icon(
            Icons.arrow_right,
            size: 50,
          ),
          onPressed: () {}),
    ]);
  }
}
