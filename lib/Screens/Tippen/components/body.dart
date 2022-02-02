import 'package:flutter/material.dart';

//import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/shared/constants.dart';

//import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'Tippen',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: SizedBox.expand(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/main_top.png'),
                        fit: BoxFit.cover)),
                child: Text('Hier kannst du tippen'))),
      ),
    );
  }
}
