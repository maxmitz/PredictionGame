import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Tippen/components/body.dart';

import 'package:flutter_auth/components/navigation_bar.dart';

class UntereLeiste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(), bottomNavigationBar: NavigationBar());
  }
}
