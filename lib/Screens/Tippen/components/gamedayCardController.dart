import 'package:flutter/material.dart';
import 'gamedayCard.dart';

// !!!!!!!!!! NO USED SO FAR !!!!!!!!!!!!!

class GamedayCardController extends StatelessWidget {
  final GamedayCard gamedaycard;
  List<TextEditingController> textEditingControllers;

  GamedayCardController({this.gamedaycard});

  @override
  Widget build(BuildContext context) {
    textEditingControllers = []
      ..add(new TextEditingController())
      ..add(new TextEditingController());
    return gamedaycard;
  }
}
