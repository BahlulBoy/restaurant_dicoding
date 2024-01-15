import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/navigation/my_routes.dart';
import 'package:restaurant_dicoding/styles/my_styles.dart';
import 'package:restaurant_dicoding/utils/background_service.dart';
import 'package:restaurant_dicoding/utils/navigation_helper.dart';
import 'package:restaurant_dicoding/utils/notification_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BackgroundService().initializeIsolation();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await NotificationHelper().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
