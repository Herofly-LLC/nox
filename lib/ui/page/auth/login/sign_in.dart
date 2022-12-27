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

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController parola = TextEditingController();

  String? _email, _password;

  bool otpVisibility = false;
  String? username;
  String? password;
  double iconSize = 18;

  bool _obscureText = true;
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
  }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("başarılı");
      setState(() {});
    });

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
                            'https://wallpaperaccess.com/full/3037928.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/img/logo.png",
                  height: 91,
                  width: 81,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Text(
                  "E-Mail / Kul.Adı",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: 335,
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    print('Please enter some text');
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.dmSans(
                    color: NowUIColors.beyaz,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: NowUIColors.beyaz,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: NowUIColors.beyaz),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    filled: true,
                    hintStyle: GoogleFonts.dmSans(
                      color: NowUIColors.beyaz.withOpacity(0.5),
                      fontSize: 14,
                    ),
                    fillColor: NowUIColors.btngri),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Parola",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: 335,
              alignment: Alignment.centerLeft,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: parola,
                onSaved: (value) {
                  password = value;
                },
                style: GoogleFonts.dmSans(
                    color: NowUIColors.beyaz,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: NowUIColors.beyaz,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: NowUIColors.beyaz,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: NowUIColors.beyaz),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    filled: true,
                    hintStyle: GoogleFonts.dmSans(
                      color: NowUIColors.beyaz.withOpacity(0.5),
                      fontSize: 14,
                    ),
                    fillColor: NowUIColors.btngri),
                obscureText: _obscureText,
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    print('bişeyler gir');
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 27,
                ),
                Text(
                  "Şifre mi Unuttum?",
                  style: GoogleFonts.dmSans(
                      color: Colors.white24,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            ButtonTheme(
              height: 56.0,
              minWidth: 335,
              child: FlatButton(
                textColor: NowUIColors.beyaz,
                color: NowUIColors.mor,
                onPressed: () async {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  "Giriş Yap",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
