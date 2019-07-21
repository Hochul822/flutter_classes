import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("인증 페이지"),
      ),
      body: Container(
        child: SignUpScreen(),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  BuildContext buildContext;

  Future signUp(String email, String password) async {
    try {
      FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);     
      Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text("가입 되었습니다."),));
      return true;
    } on PlatformException catch(e) {
      Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text("가입 실패하였습니다 - ${e.message}"),));
      return false;
    }
  }

  Future signIn(String email, String password) async {
    try {
      FirebaseUser user = await auth.signInWithEmailAndPassword(email: email, password: password);
      Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text("로그인 되었습니다."),));
      return true;
    } on PlatformException catch(e) {
      
      Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text("로그인 실패 하였습니다 - ${e.code}"),));
      return false;
    }
  }

  Future googleSignUp() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseUser user = await auth.signInWithCredential(credential);

    return user.uid != null;
  }

  void googleSignOut() {
    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Text(
              "가입 화면",
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: emailCtrl,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  size: 32,
                  color: Colors.deepPurple,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "이메일을 입력해주세요.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  size: 32,
                  color: Colors.deepPurple,
                ),
                hintText: '비밀번호를 입력해주세요 (6자 이상, 특수문자 포함입니다.)',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return "비밀번호를 입력해주세요";
                }
                if (value.length < 6) {
                  return "비밀 번호를 6자 이상 입력해주세요";
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    googleSignUp();
                  },
                  child: Text(
                    "구글 아이디 사용하기",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepOrange,
                ),
                RaisedButton(
                  onPressed: () {
                    String email = emailCtrl.text;
                    String password = passwordCtrl.text;
                    signUp(email, password);
                  },
                  child: Text(
                    "가입하기",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepOrange,
                ),
                RaisedButton(
                  onPressed: () {
                    String email = emailCtrl.text;
                    String password = passwordCtrl.text;
                    signIn(email, password);
                  },
                  child: Text(
                    "로그인하기",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepOrange,
                ),
              ],
            ),
            Builder(
              builder: (BuildContext buildContext) {
                this.buildContext = buildContext;
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
