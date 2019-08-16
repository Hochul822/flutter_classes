import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/screens/video_player_screen.dart';

import 'config/routes.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Netflix',
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
            body2: TextStyle(color: Colors.white)
          )),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        Routes.initial: (context) => SplashScreen(),
        Routes.videoPlayer: (context) => VideoPlayerScreen(),
        Routes.detail: (context) => DetailScreen(),
        Routes.home: (context) => HomeScreen(),
      },
    );
  }
}
