import 'dart:io';
import 'package:restaurant_dicoding/constants/api_const.dart';
import 'package:restaurant_dicoding/models/detail_restaurant_response.dart';
import 'package:restaurant_dicoding/models/list_restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantRepository {
  static Future<ListRestaurantModel> getListRestaurant() async {
    try {
      final result = await http.get(
        Uri.parse(ApiConst.list),
      );
      return ListRestaurantModel.fromRawJson(result.body);
    } on SocketException catch (_) {
      return ListRestaurantModel(
        error: true,
        message: 'No Internet Connection',
      );
    } on HttpException catch (e) {
      return ListRestaurantModel(
        error: true,
        message: e.message,
      );
    } catch (_) {
      return ListRestaurantModel(
        error: true,
        message: 'There is unknown problem',
      );
    }
  }

  static Future<ListSearchRestaurantModel> getListRestaurantSearch(
      String search) async {
    try {
      final result = await http.get(
        Uri.parse(ApiConst.search(search)),
      );
      return ListSearchRestaurantModel.fromRawJson(result.body);
    } on SocketException catch (_) {
      return ListSearchRestaurantModel(
        error: true,
        message: 'No Internet Connection',
      );
    } on HttpException catch (e) {
      return ListSearchRestaurantModel(
        error: true,
        message: e.message,
      );
    } catch (_) {
      return ListSearchRestaurantModel(
        error: true,
        message: 'There is unknown problem',
      );
    }
  }

  static Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      final result = await http.get(
        Uri.parse(ApiConst.detail(id)),
      );
      return DetailRestaurantResponse.fromRawJson(result.body);
    } on SocketException catch (_) {
      return DetailRestaurantResponse(
        error: true,
        message: 'No Internet Connection',
      );
    } on HttpException catch (e) {
      return DetailRestaurantResponse(
        error: true,
        message: e.message,
      );
    } catch (_) {
      return DetailRestaurantResponse(
        error: true,
        message: 'There is unknown problem',
      );
    }
  }
}