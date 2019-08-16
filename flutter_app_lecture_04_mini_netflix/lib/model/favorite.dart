class Favorite {
  int id;
  int favorite;

  Favorite(this.id, this.favorite);

  Favorite.fromMap(Map map) {
    this.id = map['id'];
    this.favorite = map['favorite'];
  }
}

List<Favorite> listToFavorite(List<dynamic> list) {
  List<Favorite> favorites = [];

  list.forEach((map) {
    Favorite favor = Favorite.fromMap(map);
    favorites.add(favor);
  });

  return favorites;
}