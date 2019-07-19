import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List<String> images = [
    "https://cdn.pixabay.com/photo/2017/09/05/09/55/men-wear-2716968_1280.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/020171209_145118_Mens_winter_clothes_2017_in_Poland.jpg/864px-020171209_145118_Mens_winter_clothes_2017_in_Poland.jpg",
    "https://www.maxpixel.net/static/photo/2x/Fashion-Male-Model-Team-Jacket-Clothes-Shirt-3740349.jpg",
    "https://www.maleraffine.com/images/medium/fashion/what-type-of-shoes-are-best-for-suits/what-type-of-shoes-are-best-for-suits0.jpg",
  ];

  List<String> titles = ["셔츠", "청자켓", "양복", "구두"];
  List<bool> checked = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("쇼핑 페이지"),
      ),
      body: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${titles[index]}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    ),
                    Image.network(
                      images[index],
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Checkbox(
                        value: checked[index],
                        onChanged: (value) {
                          setState(() {
                            checked[index] = value;
                          });
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }
}
