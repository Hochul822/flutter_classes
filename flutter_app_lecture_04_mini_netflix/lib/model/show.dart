class Show {
  int id;
  String url;
  String name;
  String image;
  String summary;
  List<String> genres;
  num rating;

  Show(this.id, this.url, this.name, this.genres, this.rating);

  Show.fromJson(Map map) {
    this.id = map['id'];
    this.url = map['url'];
    this.name = map['name'];
    this.summary = map['summary'];
    this.image = map['image']['medium'];
    this.genres = convertGenres(map['genres']);
    this.rating = map['rating']['average'];
  }

  List<String> convertGenres(List<dynamic> genres) {
    return genres.map((dynamic data) => (data).toString() ).toList();
  }

}