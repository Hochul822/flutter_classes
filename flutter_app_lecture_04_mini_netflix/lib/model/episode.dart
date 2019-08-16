class Episode {
  int id;
  String url;
  String name;
  int season;
  int number;
  String airdate;
  Map image;
  String summary;

  Episode(this.id, this.url, this.name, this.season, this.number, this.airdate,
      this.image, this.summary);


  Episode.fromJson(Map map) {
    this.id = map['id'];
    this.url = map['url'];
    this.name = map['name'];
    this.season = map['season'];
    this.number = map['number'];
    this.airdate = map['airdate'];
    this.image = map['image']['medium'];
    this.summary = map['summary'];
  }
}