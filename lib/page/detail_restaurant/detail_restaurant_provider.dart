import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/page/detail_restaurant/detail_restaurant_state.dart';
import 'package:restaurant_dicoding/helpers/screen_state_condition.dart';
import 'package:restaurant_dicoding/repositories/restaurant_repository.dart';
import 'package:restaurant_dicoding/utils/local_db.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final state = DetailRestaurantState();

  DetailRestaurantProvider(String? id) {
    _init(id);
  }

  Future<void> _init(String? id) async {
    if (id != null) {
      await getDetailRestaurant(id);
      await _isFavoriteRestaurant(id);
    } else {
      state.screenState = ScreenStateCondition.error;
    }
  }

  Future<void> _isFavoriteRestaurant(String id) async {
    final bool db = await LocalDb().getIsRestaurantFavorite(id);
    state.isFavorite = db;
    notifyListeners();
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
        state.review = result.restaurant?.customerReviews ?? [];
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

  Future<Map<String, dynamic>> postReview(
    String name,
    String review,
  ) async {
    if (state.data?.id != null) {
      final result = await RestaurantRepository.postReview(
        id: state.data!.id!,
        name: name,
        review: review,
      );

      if (result.error == false) {
        if (result.customerReviews != null) {
          state.review = result.customerReviews;
          notifyListeners();
          return {
            'value': false,
            'message': 'post comment success',
          };
        } else {
          return {
            'value': true,
            'message': 'unknown problem. try again later',
          };
        }
      } else {
        return {
          'value': true,
          'message': result.message ?? 'unknown problem. try again later',
        };
      }
    } else {
      return {
        'value': true,
        'message': 'id restaurant are not found',
      };
    }
  }

  void changeFavoriteState() {
    if (state.data != null) {
      if (state.isFavorite) {
        _deleteFromFavoriteRestaurant();
      } else {
        _insertFavoriteRestaurant();
      }
    }
  }

  Future<void> _insertFavoriteRestaurant() async {
    await LocalDb().insertRestaurant(state.data!);
    state.isFavorite = true;
    notifyListeners();
  }

  Future<void> _deleteFromFavoriteRestaurant() async {
    await LocalDb().deleteRestaurantFromFavorite(state.data!.id!);
    state.isFavorite = false;
    notifyListeners();
  }

  void showSnackbar({
    required String text,
    required BuildContext context,
    required bool isError,
  }) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: isError ? Colors.red[400] : Colors.green[600],
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void changeTextReview({String? name, String? review}) {
    if (name != null) {
      state.nameText = name;
      notifyListeners();
    }
    if (review != null) {
      state.reviewText = review;
      notifyListeners();
    }
  }

  void resetText() {
    state.nameText = '';
    state.reviewText = '';
    notifyListeners();
  }
}
