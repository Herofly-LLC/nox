import 'dart:convert';
import 'dart:core';

import 'package:nox/core/service/notification.dart';
import 'package:nox/ui/constant/color/colors.dart';
import 'package:nox/ui/page/auth/login/sign_in.dart';
import 'package:nox/ui/page/tools/smsBomber/bomber.dart';
import 'package:client_information/client_information.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_icons/simple_icons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class _LoginState extends State<Login> {
  String _platformVersion = 'Bilinmiyor';
  String _projectVersion = '';
  String _projectCode = '';
  double iconSize = 18;
  String _projectAppID = '';
  String _projectName = '';

  void _initPlatformState() async {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    //  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await PushNotificationService().setupInteractedMessage();

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // App received a notification when it was killed
    }

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
    print("Proje Bilgileri : ⤵️");
    print("🔥\u200d " + projectCode);

    print("😎\u200d " + projectVersion);

    print("👑\u200d " + platformVersion);

    print("✨\u200d " + projectAppID);

    print("🐍\u200d " + projectName);
  }

  Future<void> _realDevice() async {
    print("Cihaz Bilgileri : ⤵️");

    ClientInformation info = await ClientInformation.fetch();

    print("✨\u200d " + info.deviceId); // EA625164-4XXX-XXXX-XXXXXXXXXXXX
    print("✨\u200d " + info.osName);
    print("✨\u200d " + info.deviceName);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("geri bas");

        return Navigator.canPop(context);
      },
      child: Scaffold(
        backgroundColor: NowUIColors.bgcolor,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, NowUIColors.bgcolor])
                      .createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                    height: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1550745165-9bc0b252726f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2940&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/img/logo.png",
                  height: 110,
                  width: 110,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "İstediğin Şekilde",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Aramıza Katıl",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sevdiğin yada istediğin",
                  style: GoogleFonts.dmSans(
                    color: NowUIColors.yaziRenk,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "giriş seçeneklerinden birisini kullanabilirsin.",
                  style: GoogleFonts.dmSans(
                    color: NowUIColors.yaziRenk,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ButtonTheme(
              height: 56.0,
              minWidth: 335,
              child: FlatButton(
                textColor: NowUIColors.beyaz,
                color: NowUIColors.mor,
                onPressed: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: SignIn()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  "E-Mail / Kullanıcı Adı",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 56.0,
              width: 335.0,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: NowUIColors.btngri,
                  primary: NowUIColors.beyaz,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                label: Text(
                  'Google ile oturum aç',
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  SimpleIcons.google,
                  size: iconSize,
                  color: NowUIColors.beyaz,
                ),
                onPressed: () async {},
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 56.0,
              width: 335.0,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: NowUIColors.btngri,
                  primary: NowUIColors.beyaz,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                label: Text(
                  'Riot Games ile oturum aç',
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  SimpleIcons.riotgames,
                  size: iconSize,
                  color: NowUIColors.beyaz,
                ),
                onPressed: () async {},
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: Bomber()));
                  },
                  child: Text(
                    "Atla",
                    style: GoogleFonts.dmSans(
                        color: NowUIColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
