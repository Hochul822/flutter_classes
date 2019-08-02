class Post {
  String title;
  String content;
  String id;
  int views;

  Post({this.title, this.content, this.views});

  Post.fromJson(Map json):
    this.title = json['title'],
    this.content = json['content'],
    this.views = json['views'];



  Map toMap() {
    Map<String, dynamic> map = Map();
    map['title'] = this.title;
    map['content'] = this.content;
    map['views'] = this.views;

    return map;
  }  
}
