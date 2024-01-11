import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/page/favorite_restaurant/favorite_restaurant_state.dart';
import 'package:restaurant_dicoding/utils/local_db.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  final state = FavoriteRestaurantState();

  FavoriteRestaurantProvider() {
    _init();
  }

  Future<void> _init() async {
    await getFavoriteRestaurantList();
  }

  Future<void> getFavoriteRestaurantList() async {
    var result = await LocalDb().getFavoriteRestaurant();

    if (result.isNotEmpty) {
      state.data = result;
      notifyListeners();
    }
  }
}
