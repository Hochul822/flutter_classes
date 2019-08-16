import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_04/config/routes.dart';
import 'package:flutter_app_lecture_04/model/show.dart';

class TVShowPage extends StatefulWidget {
  @override
  _TVShowPageState createState() => _TVShowPageState();
}

class _TVShowPageState extends State<TVShowPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = [
    Tab(text: 'ALL'),
    Tab(text: 'DRAMA'),
    Tab(text: 'Crime'),
    Tab(text: 'Horror'),
  ];

  List<Show> shows = [];

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    loadShows();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<List<Show>> loadShows() async {
    String assetBundle = await DefaultAssetBundle.of(context).loadString("assets/shows.json");

    List tvShowData = json.decode(assetBundle);

    List<Show> showList = [];

    showList = tvShowData.map((dynamic tvShow) => (Show.fromJson(tvShow))).toList();

    setState(() {
      this.shows = showList;
    });

    return showList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: tabs,
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ShowList(
              shows: shows,
            ),
            ShowList(
              shows: showByGenres('Drama'),
            ),
            ShowList(
              shows: showByGenres('Crime'),
            ),
            ShowList(
              shows: showByGenres('Horror'),
            ),
          ],
        ));
  }

  List<Show> showByGenres(String genreSelected) {
    return shows.where((Show show) {

      bool match = false;

      show.genres.forEach((String genre) {
        if (genreSelected == genre) {
          match = true;
        }
      });

      return match;
    }).toList();
  }
}

class ShowList extends StatefulWidget {
  List<Show> shows;

  ShowList({this.shows});

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 400,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.shows.length,
        itemBuilder: (context, index) {
          Show show = widget.shows[index];

          return ShowItem(show);
        },
      ),
    );
  }

  void openDetailPage(Show show) {
    Navigator.pushNamed(context, Routes.detail, arguments: show);
  }

  Widget ShowItem(Show show) {
    String imageUrl = show.image;

    return GestureDetector(
      onTap: () {
        openDetailPage(show);
      },
      child: Container(
        height: 400,
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: <Widget>[

            Text("${show.name}", style: TextStyle(color: Colors.white, fontSize: 21.0)),

            SizedBox(height: 12.0),

            Image.network(
              imageUrl,
              width: 240,
              height: 240,
              fit: BoxFit.fitWidth,
            ),

            SizedBox(height: 12.0),

            Text(
              "평점 - ${show.rating}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
