import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/helpers/screen_state_condition.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/page/home/home_state.dart';
import 'package:restaurant_dicoding/repositories/restaurant_repository.dart';

class HomeProvider extends ChangeNotifier {
  final state = HomeState();

  HomeProvider(BuildContext context) {
    _init();
  }

  Future<void> _init() async {
    await getListRestaurant();
  }

  Future<void> getListRestaurant() async {
    state.screenState = ScreenStateCondition.loading;
    notifyListeners();
    final result = await RestaurantRepository.getListRestaurant();

    if (result.error == false) {
      if (result.restaurants != null) {
        state.listRestaurantShow = result.restaurants!;
        state.screenState = ScreenStateCondition.success;
        notifyListeners();
      } else {
        state.listRestaurantShow = [];
        state.screenState = ScreenStateCondition.success;
        notifyListeners();
      }
    } else {
      state.errorMessage = result.message;
      state.screenState = ScreenStateCondition.error;
      notifyListeners();
    }
  }

  Future<void> getListRestaurantSearch(String search) async {
    state.debouncer.run(() async {
      if (search.isNotEmpty) {
        state.screenState = ScreenStateCondition.loading;
        notifyListeners();
        final result =
            await RestaurantRepository.getListRestaurantSearch(search);

        if (result.error == false) {
          if (result.restaurants != null) {
            state.listRestaurantShow = result.restaurants!;
            state.screenState = ScreenStateCondition.success;
            notifyListeners();
          } else {
            state.listRestaurantShow = [];
            state.screenState = ScreenStateCondition.success;
            notifyListeners();
          }
        } else {
          state.errorMessage = result.message;
          state.screenState = ScreenStateCondition.error;
          notifyListeners();
        }
      } else {
        state.listRestaurantShow = [];
        state.screenState = ScreenStateCondition.success;
        notifyListeners();
      }
    });
  }

  void isGridChanger() {
    state.isGrid = !state.isGrid;
    notifyListeners();
  }

  void showSearch() {
    state.isSearchShow = !state.isSearchShow;
    if (state.isSearchShow) {
      state.listRestaurantShow = [];
    } else {
      getListRestaurant();
    }
    notifyListeners();
  }

  void onClickPopupMenu(BuildContext context, String value) {
    switch (value) {
      case 'Favorite':
        Navigator.pushNamed(context, MyPaths.favorite);
        break;
      case 'Setting':
        Navigator.pushNamed(context, MyPaths.setting);
        break;
      default:
    }
  }
}
