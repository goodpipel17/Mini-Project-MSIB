import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/widget/bottom_bar.dart';

class splashscreens extends StatelessWidget {
  const splashscreens({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/food_logo.json'),
      backgroundColor: Colors.greenAccent.shade100,
      nextScreen: bottom_bar(),
      splashIconSize: 150,
    );
  }
}
