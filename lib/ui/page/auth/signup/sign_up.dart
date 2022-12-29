import 'dart:convert';
import 'dart:core';

import 'package:askingucu/core/service/auth.dart';
import 'package:askingucu/core/service/notification.dart';
import 'package:askingucu/ui/constant/color/colors.dart';
import 'package:askingucu/ui/page/auth/login/sign_in.dart';
import 'package:askingucu/ui/page/dashboard/dashboard.dart';
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
import 'package:iconsax/iconsax.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_icons/simple_icons.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class _SignUpState extends State<SignUp> {
  AuthService _authService = AuthService();

  final TextEditingController _kulAdiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordTekrarController =
      TextEditingController();

  String? _email, _password, _kuladi;

  bool otpVisibility = false;
  bool otpTekrar = false;
  String? username;
  String? password;
  String? parolatekrar;
  double iconSize = 18;

  bool _obscureText = true;
  bool _obscureTekrar = true;

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
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1560253023-3ec5d502959f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80'),
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
                  "E-Mail",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 335,
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _emailController,
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
                  "Kullanıcı Adı",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 335,
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _kulAdiController,
                validator: (value) {
                  if (value!.isEmpty) {
                    print('Please enter some text');
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _kuladi = value.trim();
                  });
                },
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.dmSans(
                    color: NowUIColors.beyaz,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
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
              height: 5,
            ),
            Container(
              width: 335,
              alignment: Alignment.centerLeft,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
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
                        color: NowUIColors.yaziRenk,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
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
                  "Parola Tekrar",
                  style: GoogleFonts.dmSans(
                      color: NowUIColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 335,
              alignment: Alignment.centerLeft,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordTekrarController,
                onSaved: (value) {
                  parolatekrar = value;
                },
                style: GoogleFonts.dmSans(
                    color: NowUIColors.beyaz,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTekrar = !_obscureTekrar;
                        });
                      },
                      child: Icon(
                        _obscureTekrar
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: NowUIColors.yaziRenk,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
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
                obscureText: _obscureTekrar,
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
            SizedBox(
              height: 25,
            ),
            ButtonTheme(
              height: 56.0,
              minWidth: 335,
              child: FlatButton(
                textColor: NowUIColors.beyaz,
                color: NowUIColors.mor,
                onPressed: () async {
                  _kaydol();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  "Kaydol",
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

  void _kaydol() async {
    if (_emailController.text == '') {
      _emailUyarisi();
    } else if (_kulAdiController.text == '') {
      _kullaniciAdiUyarisi();
    } else if (_passwordController.text == '') {
      _parolaUyarisi();
    }
    _authService
        .createPerson(_kulAdiController.text, _emailController.text,
            _passwordController.text, _passwordTekrarController.text)
        .then((value) {
      _kayitBasariliUyarisi();
      return Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight, child: SignIn()));
    }).catchError((dynamic error) {
      if (error.code.contains('success')) {
        MotionToast.success(
          position: MotionToastPosition.top,
          animationType: AnimationType.fromTop,
          title: Text(
            "Aramıza Hoşgeldin :)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          description: Text(
            "Kayıt işlemi başarılı",
            style: GoogleFonts.dmSans(
              color: NowUIColors.bgcolor,
              fontSize: 12,
            ),
          ),
          onClose: () {},
        ).show(context);
      }
      if (error.code.contains('email-already-in-use')) {
        MotionToast.warning(
          position: MotionToastPosition.top,
          animationType: AnimationType.fromTop,
          title: Text(
            "Oops!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          description: Text(
            "E-posta adresi zaten başka bir hesap tarafından kullanılıyor.",
            style: TextStyle(fontSize: 12),
          ),
          onClose: () {},
        ).show(context);
      }
    });
  }

  void _emailUyarisi() {
    MotionToast.warning(
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      title: Text(
        "Oops!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        "E-Mail / Kullanıcı Adı Boş Olamaz!",
        style: GoogleFonts.dmSans(
          color: NowUIColors.bgcolor,
          fontSize: 12,
        ),
      ),
      onClose: () {},
    ).show(context);
  }

  void _kullaniciAdiUyarisi() {
    MotionToast.warning(
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      title: Text(
        "Oops!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        "Kullanıcı Adı Alanı Boş Olamaz!",
        style: GoogleFonts.dmSans(
          color: NowUIColors.bgcolor,
          fontSize: 12,
        ),
      ),
      onClose: () {},
    ).show(context);
  }

  void _parolaUyarisi() {
    MotionToast.warning(
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      title: Text(
        "Oops!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(
        "Parola Alanı Boş Olamaz!",
        style: GoogleFonts.dmSans(
          color: NowUIColors.bgcolor,
          fontSize: 12,
        ),
      ),
      onClose: () {},
    ).show(context);
  }

  void _kayitBasariliUyarisi() {}
}
