class Post {
  String title;
  String content;
  int views;
  String id;

  Post(this.title, this.content, this.views);


  Post.fromMap(Map map) {
    this.title = map['title'];
    this.content = map['content'];
    this.views = map['views'];
  }
}