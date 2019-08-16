import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/config/routes.dart';
import 'package:flutter_app_lecture_04/database/db.dart';
import 'package:flutter_app_lecture_04/model/favorite.dart';
import 'package:flutter_app_lecture_04/model/show.dart';
import 'package:flutter_app_lecture_04/resources/textstyle.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int likes = 0;
  bool fav = false;
  Favorite favorite;

  DB db = DB();

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await db.init();
  }

  void readFavorite(Show show) async {
    favorite = await db.select(show.id);
  }

  @override
  Widget build(BuildContext context) {
    Show show = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Netflix',
          style: appBarStyle,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).maybePop();
          },
          child: Icon(Icons.arrow_back, color: Colors.red),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TvShowDetail(show),
          ],
        ),
      ),
    );
  }

  Widget TvShowDetail(Show show) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: <Widget>[
          Text("${show.name}",
              style: TextStyle(fontSize: 24.0)),
          SizedBox(height: 12.0),
          GestureDetector(
            onTap: () {

              openVideoPlayer();
            },
            child: Image.network(
              show.image,
              width: 240,
              height: 240,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            "별점 - ${show.rating}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${show.summary.substring(0, 300)}",
            style: TextStyle(
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                height: 1.5),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    likes += 1;
                  });
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      size: 36,
                      color: Colors.white,
                    ),
                    Text('${likes}'),
                  ],
                ),
              ),
              SizedBox(width: 6.0,),

              GestureDetector(
                onTap: () {

                  setState(() {
                    fav = !fav;

                    Favorite favorite = Favorite(show.id, fav ? 1 : 0);
                    db.updateFavorite(favorite);

                  });

                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 36,
                      color: fav ?  Colors.redAccent : Colors.white ,
                    ),
                    Text(''),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void openVideoPlayer() {
    Navigator.pushNamed(context, Routes.videoPlayer);
  }
}
