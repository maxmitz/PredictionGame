import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';

import 'package:flutter_auth/components/navigation_bar.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/screens/tippen/tippen_screen.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class UntereLeiste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TheUser?>(builder: (_, user, __) {
      if (user != null) {
        return StreamProvider<UserData?>.value(
          value: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            return Scaffold(
                body: TippenScreen(),
                bottomNavigationBar: CustomNavigationBar());
          },
          initialData: null,
        );
      } else {
        return Loading();
      }
    });
  }
}
