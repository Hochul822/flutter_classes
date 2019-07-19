import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_01/shopping_page.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void openPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingPage() ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인 페이지"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                "로그인",
                style: TextStyle(fontSize: 48, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("이메일"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '이메일을 입력해주세요.'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("비밀번호"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '비밀번호를 입력해주세요.'),
                    ),
                  )
                ],
              ),
              Container(height: 12.0,),
              RaisedButton(
                onPressed: () {
                  openPage();
                },
                child: Text("로그인하기", style: TextStyle(fontSize: 18, color: Colors.white),),
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
