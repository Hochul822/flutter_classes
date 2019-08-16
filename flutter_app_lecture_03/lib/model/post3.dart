class Post {
  String title;
  String content;
  String docId;
  int views;

  Post.fromMap(Map map) {
    this.title = map['title'];
    this.content = map['content'];
    this.views = map['views'];
  }

}