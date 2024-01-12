import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/page/detail_restaurant/detail_restaurant_view.dart';
import 'package:restaurant_dicoding/page/favorite_restaurant/favorite_restaurant_view.dart';
import 'package:restaurant_dicoding/page/home/home_view.dart';
import 'package:restaurant_dicoding/page/setting/setting_view.dart';
import 'package:restaurant_dicoding/page/splash_screen/splash_screen_view.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> myListRoutes(
          BuildContext context) =>
      {
        MyPaths.splash: (context) => const SplashScreenView(),
        MyPaths.home: (context) => const HomeView(),
        MyPaths.detail: (context) => const DetailRestaurantView(),
        MyPaths.favorite: (context) => const FavoriteRestaurantView(),
        MyPaths.setting: (context) => const SettingView(),
      };
}
