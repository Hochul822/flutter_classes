import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password) async {
    FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    print(user);

    return user.uid != null;
  }

  Future signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("인증 페이지"),
          RaisedButton(onPressed: () { signUp("2@abc.com", "12345678");  }, )
        ],
      ),
    );
  }
}
