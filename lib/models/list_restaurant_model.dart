import 'dart:convert';

class ListRestaurantModel {
  bool? error;
  String? message;
  int? count;
  List<Restaurant>? restaurants;

  ListRestaurantModel({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory ListRestaurantModel.fromRawJson(String str) =>
      ListRestaurantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListRestaurantModel.fromJson(Map<String, dynamic> json) =>
      ListRestaurantModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class ListSearchRestaurantModel {
  bool? error;
  int? founded;
  String? message;
  List<Restaurant>? restaurants;

  ListSearchRestaurantModel({
    this.error,
    this.founded,
    this.message,
    this.restaurants,
  });

  factory ListSearchRestaurantModel.fromRawJson(String str) =>
      ListSearchRestaurantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListSearchRestaurantModel.fromJson(Map<String, dynamic> json) =>
      ListSearchRestaurantModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating.toString(),
      };
}
