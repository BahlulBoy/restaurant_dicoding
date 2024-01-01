import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/page/detail_restaurant/detail_restaurant_state.dart';
import 'package:restaurant_dicoding/page/home/helpers/screen_state_condition.dart';
import 'package:restaurant_dicoding/repositories/restaurant_repository.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final state = DetailRestaurantState();

  DetailRestaurantProvider(String? id) {
    _init(id);
  }

  Future<void> _init(String? id) async {
    if (id != null) {
      await getDetailRestaurant(id);
    } else {
      state.screenState = ScreenStateCondition.error;
    }
  }

  Future<void> getDetailRestaurant(String id) async {
    state.screenState = ScreenStateCondition.loading;
    notifyListeners();
    final result = await RestaurantRepository.getDetailRestaurant(id);
    if (result.error ?? false) {
      state.messageError = result.message;
      state.screenState = ScreenStateCondition.error;
      notifyListeners();
      return;
    } else {
      if (result.restaurant != null) {
        state.data = result.restaurant;
        state.screenState = ScreenStateCondition.success;
        notifyListeners();
        return;
      } else {
        state.messageError = result.message;
        state.screenState = ScreenStateCondition.error;
        notifyListeners();
        return;
      }
    }
  }
}
