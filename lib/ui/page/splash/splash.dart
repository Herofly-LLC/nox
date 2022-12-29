import 'package:askingucu/core/service/notification.dart';
import 'package:askingucu/ui/constant/color/colors.dart';
import 'package:askingucu/ui/page/dashboard/dashboard.dart';
import 'package:askingucu/ui/page/onboard/one.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

// @dart=2.9
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  SpinKitSquareCircle? spinkit;
  String _platformVersion = 'Bilinmiyor';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  var tok;

  void _initPlatformState() async {
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    //  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await PushNotificationService().setupInteractedMessage();

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // App received a notification when it was killed
    }
  }

  void firebaseToken() async {
    FirebaseMessaging.instance.getToken().then((tken) {
      final tokenFirebase = tken.toString();

      print("Firebase Token = " + tokenFirebase);
    });
  }

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Firebase.initializeApp();
    tok = prefs.getString("token");

    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: tok == null ? OnboardOne() : Dashboard()));
  }

  @override
  void initState() {
    super.initState();
    //_initPlatformState();
    firebaseToken();
    main();
    spinkit = SpinKitSquareCircle(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000)),
    );

    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardOne()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NowUIColors.bgcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(' assets/img/logo.png',
                height: 90, width: 90, color: NowUIColors.beyaz),
            const SizedBox(
              height: 25,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(NowUIColors.beyaz),
            ),
          ],
        ),
      ),
    );
  }
}
