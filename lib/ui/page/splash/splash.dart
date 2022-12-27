import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:askingucu/ui/constant/color/colors.dart';
import 'package:askingucu/ui/page/dashboard/dashboard.dart';
import 'package:askingucu/ui/page/onboard/one.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: "assets/img/logo.png",
            splashIconSize: 60,
            nextScreen: OnboardOne(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.rightToLeft,
            backgroundColor: NowUIColors.bgcolor));
  }
}
