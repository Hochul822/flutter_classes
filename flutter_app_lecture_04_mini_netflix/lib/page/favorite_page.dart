import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/database/db.dart';
import 'package:flutter_app_lecture_04/model/favorite.dart';
import 'package:flutter_app_lecture_04/model/show.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  DB db = DB();
  List<Favorite> favorites = [];
  Map<int, bool> favoriteIds = Map();
  List<Show> shows = [];

  @override
  void initState() {
    super.initState();

    initDatabase();
  }

  void initDatabase() async {
    await db.init();

    List<Favorite> favor = await db.selectList();

    favor.forEach((Favorite favorite) {
      favoriteIds[favorite.id] = true;
    });

    List<Show> shows = await loadShows();

    shows = shows.where((Show show) {
      if (favoriteIds.containsKey(show.id)) return true;

      return false;
    }).toList();

    setState(() {
      this.shows = shows;
    });
  }

  Future<List<Show>> loadShows() async {
    String assetBundle =
        await DefaultAssetBundle.of(context).loadString("assets/shows.json");

    List tvShowData = json.decode(assetBundle);

    List<Show> showList = [];

    showList =
        tvShowData.map((dynamic tvShow) => (Show.fromJson(tvShow))).toList();

    return showList;
  }

  Widget ShowItem(Show show, index) {
    var width = MediaQuery.of(context).size.width * 0.8;
    var height = MediaQuery.of(context).size.height * 0.40;

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "${index + 1}. ${show.name}",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 4.0,),
          Image.network(
            show.image,
            width: width * 0.9,
            height: height * 0.9,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        child: ListView.builder(
            itemCount: shows.length,
            itemBuilder: (context, index) {

              Show show = shows[index];

              return ShowItem(show, index);
            }),
      ),
    );
  }
}
