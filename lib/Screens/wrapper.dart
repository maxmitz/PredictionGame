import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/authenticate/authenticate.dart';
import 'package:flutter_auth/Screens/onboarding/onboarding.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:provider/provider.dart';

import '../Services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TheUser?>(
      builder: (_, user, __) {
        if (user == null) {
          return Authenticate();
        } else {
          return StreamProvider<UserData?>.value(
            value: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              return Onboarding();
            },
            initialData: null,
          );
        }
      },
    );
  }
}
