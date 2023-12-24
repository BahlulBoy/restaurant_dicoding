import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, MyPaths.home);
    });
    return Scaffold(
      body: Center(
        child: Text(
          'Dicoding\nRestaurant',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
