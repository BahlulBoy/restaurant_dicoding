import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/page/home/home_view.dart';
import 'package:restaurant_dicoding/page/splash_screen/splash_screen_view.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> myListRoutes(
          BuildContext context) =>
      {
        MyPaths.splash: (context) => const SplashScreenView(),
        MyPaths.home: (context) => const HomeView(),
      };
}
