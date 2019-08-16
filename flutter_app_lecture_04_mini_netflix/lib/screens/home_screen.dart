import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/page/favorite_page.dart';
import 'package:flutter_app_lecture_04/page/tvshow_page.dart';
import 'package:flutter_app_lecture_04/resources/textstyle.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> pages = [TVShowPage(), FavoritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Netflix',
          style: appBarStyle,
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BarItem(Icons.home, 'Home', Colors.white),
          BarItem(Icons.favorite, 'Favorite', Colors.white),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            this.selectedIndex = index;
          });
        },

        backgroundColor: Colors.black,
      ),
    );
  }

  BottomNavigationBarItem BarItem(
      IconData iconData, String title, Color backgroundColor) {
    return BottomNavigationBarItem(
        icon: Icon(iconData, color: backgroundColor,),
        title: Text(title, style: TextStyle(color: Colors.white),));
  }
}
