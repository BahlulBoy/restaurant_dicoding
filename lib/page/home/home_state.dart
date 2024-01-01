import 'package:restaurant_dicoding/models/list_restaurant_model.dart';
import 'package:restaurant_dicoding/page/home/helpers/screen_state_condition.dart';
import 'package:restaurant_dicoding/utils/debouncer.dart';

class HomeState {
  ScreenStateCondition screenState = ScreenStateCondition.loading;

  bool isGrid = false;
  bool isSearchShow = false;

  List<Restaurant> listRestaurantShow = [];

  String? errorMessage;

  Debouncer debouncer = Debouncer(milliseconds: 400);
}
