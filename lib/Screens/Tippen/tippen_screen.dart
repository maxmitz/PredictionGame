import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/Tippen/components/body.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:provider/provider.dart';

class TippenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Scaffold(
            body: Body(),
          );
        });
  }
}
