import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/authenticate/register.dart';
import 'package:flutter_auth/Screens/authenticate/sign_in.dart';
import 'package:new_version/new_version.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  /*
  @override
  void initState() {
    super.initState();
    NewVersion(
      context: context,
      //TODO if app is available for iOS change this

      iOSId: 'com.google.Vespa',
      androidId: 'com.futipp',
    ).showAlertIfNecessary();
  }
  */
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == false) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
