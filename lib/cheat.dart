import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/wrapper.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:provider/provider.dart';

import 'Services/database.dart';

class Cheat extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          return MaterialApp(
            home: Wrapper(),
          );
        });
  }
}
