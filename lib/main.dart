import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/navigation/my_routes.dart';
import 'package:restaurant_dicoding/styles/my_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyStyles.primaryColor),
        textTheme: MyStyles.myTextTheme,
        useMaterial3: true,
      ),
      initialRoute: MyPaths.splash,
      routes: MyRoutes.myListRoutes(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
