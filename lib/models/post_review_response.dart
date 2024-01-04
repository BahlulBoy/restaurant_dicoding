import 'dart:convert';

import 'package:restaurant_dicoding/models/detail_restaurant_response.dart';

class PostReviewResponse {
  bool? error;
  String? message;
  List<CustomerReview>? customerReviews;

  PostReviewResponse({
    this.error,
    this.message,
    this.customerReviews,
  });

  factory PostReviewResponse.fromRawJson(String str) =>
      PostReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostReviewResponse.fromJson(Map<String, dynamic> json) =>
      PostReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
