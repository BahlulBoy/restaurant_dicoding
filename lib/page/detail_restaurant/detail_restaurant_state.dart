import 'package:restaurant_dicoding/models/detail_restaurant_response.dart';
import 'package:restaurant_dicoding/helpers/screen_state_condition.dart';

class DetailRestaurantState {
  ScreenStateCondition screenState = ScreenStateCondition.loading;

  DetailRestaurant? data;
  List<CustomerReview>? review;

  String? messageError = '';
  String nameText = '';
  String reviewText = '';
}
