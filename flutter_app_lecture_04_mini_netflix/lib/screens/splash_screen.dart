import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/config/routes.dart';
import 'package:flutter_app_lecture_04/resources/textstyle.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    openHomePage();
  }

  void openHomePage() async {
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacementNamed(context, Routes.home );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Netflix',
          style: appBarStyle,
        ),
      ),
      body: Center(
        child: Text('Mini Netflix', style: TextStyle(fontSize: 48.0, color: Colors.red, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
