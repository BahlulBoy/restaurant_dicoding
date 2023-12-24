class Restaurant {
  String? id, name, description, pictureId, city;
  double? rating;
  Menu? menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: json["menus"] == null ? null : Menu.fromJson(json["menus"]),
      );
}

class Menu {
  List<ItemMenu>? foods;
  List<ItemMenu>? drinks;

  Menu({this.foods, this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: json["foods"] == null
            ? []
            : List<ItemMenu>.from(
                (json["foods"] as List<dynamic>).map(
                  (e) => ItemMenu.fromJson(e),
                ),
              ),
        drinks: json["drinks"] == null
            ? []
            : List<ItemMenu>.from(
                (json["drinks"] as List<dynamic>).map(
                  (e) => ItemMenu.fromJson(e),
                ),
              ),
      );
}

class ItemMenu {
  String? name;

  ItemMenu({this.name});

  factory ItemMenu.fromJson(Map<String, dynamic> json) => ItemMenu(
        name: json["name"],
      );
}
