import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_02/model/photo.dart';
import 'package:http/http.dart' as http;

class NetworkPage extends StatefulWidget {
  NetworkPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {

  Future<List<Photo>> getData() async {
    var client = http.Client();
    var url = 'https://jsonplaceholder.typicode.com/photos';
    var response = await client.get(url);



    if (response.statusCode == 200) {
      List items = json.decode(response.body);
      json.decode(utf8.decode(response.bodyBytes));

      List<Photo> photos = [];
      photos = items.map((item) => Photo.fromJson(item)).toList();

      return photos;
    } else {
      throw Exception();
    }
  }


  postData() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var headers = {"Content-type": "application/json"};

    var response = await http.post(url, headers: headers);

    print(response.statusCode);
    print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: postData, child: Text("make post"),),
            Flexible(
              child: FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    List<Photo> photos = snapshot.data;

                    return ListView.builder(
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          Photo photo = photos[index];

                          return photoItem(photo);
                        });

                  } else if (snapshot.hasError) {
                    return Container(
                      child: Text("error ${snapshot.error}"),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container photoItem(Photo photo) {
    return Container(
      width: 300,
      height: 140,
      child: Column(
        children: <Widget>[
          Text("${photo.id}"),
          Text("${photo.title}"),
          Image.network(
            photo.url,
            fit: BoxFit.contain,
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}
