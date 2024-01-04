import 'dart:io';
import 'package:restaurant_dicoding/constants/api_const.dart';
import 'package:restaurant_dicoding/models/detail_restaurant_response.dart';
import 'package:restaurant_dicoding/models/list_restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_dicoding/models/post_review_response.dart';

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

  static Future<PostReviewResponse> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final result = await http.post(
        Uri.parse(ApiConst.postReview),
        body: {
          "id": id,
          "name": name,
          "review": review,
        },
      );
      return PostReviewResponse.fromRawJson(result.body);
    } on SocketException catch (_) {
      return PostReviewResponse(
        error: true,
        message: 'No Internet Connection',
      );
    } on HttpException catch (e) {
      return PostReviewResponse(
        error: true,
        message: e.message,
      );
    } catch (_) {
      return PostReviewResponse(
        error: true,
        message: 'There is unknown problem',
      );
    }
  }
}
