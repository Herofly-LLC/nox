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

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
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
        backgroundColor: NowUIColors.anarenk,
        body: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://images.unsplash.com/photo-1458312631043-b3ee472ec089?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Positioned(
              bottom: 10,
              top: 290,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Start Your Mind",
                            style: GoogleFonts.bebasNeue(
                                color: NowUIColors.beyaz,
                                fontSize: 48,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "in one App",
                            style: GoogleFonts.bebasNeue(
                                color: NowUIColors.beyaz,
                                fontSize: 48,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Text(
                            "Reach your goal at app ",
                            style: GoogleFonts.mulish(
                                color: NowUIColors.beyaz,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "with over 100+ mind programs designed for",
                            style: GoogleFonts.mulish(
                                color: NowUIColors.beyaz,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "results",
                            style: GoogleFonts.mulish(
                                color: NowUIColors.beyaz,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 77,
                          ),
                          ButtonTheme(
                            minWidth: 335.0,
                            height: 50.0,
                            child: FlatButton(
                              textColor: NowUIColors.beyaz,
                              color: NowUIColors.btn,
                              onPressed: () {
                                //
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Text(
                                "Başla 🔥\u200d",
                                style: GoogleFonts.mulish(
                                  color: NowUIColors.beyaz,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new GestureDetector(
                            onTap: () {},
                            child: new Text(
                              'Create Account',
                              style: GoogleFonts.mulish(
                                color: NowUIColors.beyaz,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
