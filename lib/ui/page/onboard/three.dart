import 'dart:convert';
import 'dart:core';

import 'package:askingucu/core/service/notification.dart';
import 'package:askingucu/ui/constant/color/colors.dart';
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

class OnboardThree extends StatefulWidget {
  @override
  _OnboardThreeState createState() => _OnboardThreeState();
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class _OnboardThreeState extends State<OnboardThree> {
  String _platformVersion = 'Bilinmiyor';
  String _projectVersion = '';
  String _projectCode = '';

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
    Firebase.initializeApp().whenComplete(() {
      print("başarılı");
      setState(() {});
    });

    firebaseToken();
    super.initState();
  }

  void firebaseToken() async {
    FirebaseMessaging.instance.getToken().then((tken) {
      final tokenFirebase = tken.toString();

      print("Firebase Token = " + tokenFirebase);
    });
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
                blendMode: BlendMode.darken,
                child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1626240130051-68871c71de47?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2832&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ))),
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "En Sevdiğin Oyunlar",
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
                  "Tüm sevdiğin oyunları senin için hazırladık",
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
                  "100-250 oyun arasında sende performans testlerini yap ",
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
                  "sana iyi gelen oyunu bul. ",
                  style: GoogleFonts.dmSans(
                    color: NowUIColors.yaziRenk,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            ButtonTheme(
              height: 56.0,
              minWidth: 56,
              child: FlatButton(
                textColor: NowUIColors.beyaz,
                color: NowUIColors.btngri,
                onPressed: () async {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  ">",
                  style: GoogleFonts.montserrat(
                      color: NowUIColors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
