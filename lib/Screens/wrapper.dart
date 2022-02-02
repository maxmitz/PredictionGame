import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/authenticate/authenticate.dart';
import 'package:flutter_auth/components/untere_leiste.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    //return either UntereLeiste or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return UntereLeiste();
    }
  }
}
