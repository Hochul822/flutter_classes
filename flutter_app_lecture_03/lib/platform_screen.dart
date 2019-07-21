import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatefulWidget {
  @override
  _PlatformScreenState createState() => _PlatformScreenState();
}

class _PlatformScreenState extends State<PlatformScreen> {
  static const platform = const MethodChannel('day.flutter/dev');

  void callMethod() async {
    var result = await platform.invokeMethod('open');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("플랫폼 메소드"),),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                child: Text("Good day"),
              ),
            ),
            RaisedButton(
              onPressed: callMethod,
              child: Text("플랫폼 메소드 호출"),
            ),
          ],
        ),
      ),
    );
  }
}
