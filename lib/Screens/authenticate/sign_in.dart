import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/auth.dart';
import 'package:flutter_auth/shared/constants.dart';
import 'package:flutter_auth/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: kPrimaryLightColor,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0.0,
              title: Text('Bei FuTipp anmelden'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'E-Mail'),
                      validator: (val) =>
                          val!.isEmpty ? 'Gib eine E-Mail-Adresse ein.' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Passwort'),
                      validator: (val) =>
                          val!.length < 6 ? 'Dein Passwort ist zu kurz' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      text: 'Du hast noch keinen Account?',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Registrieren.',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 14.0),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => widget.toggleView!()),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      style: TextButton.styleFrom(primary: kPrimaryColor),
                      child: Text(
                        'Anmelden',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Nutzername und Passwort stimmen nicht ??berein.';
                              loading = false;
                            });
                          }
                        }
                      }),
                  SizedBox(height: 20.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ]),
              ),
            ),
          );
  }
}
