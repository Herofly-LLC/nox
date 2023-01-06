import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:nox/core/model/haber_model.dart';
import 'package:nox/core/service/auth.dart';
import 'package:nox/core/service/remote_config.dart';
import 'package:nox/core/service/remote_config_keys.dart';
import 'package:nox/core/utils/api.dart';
import 'package:nox/ui/constant/color/colors.dart';
import 'package:nox/ui/page/auth/login/sign_in.dart';
import 'package:nox/ui/page/dashboard/dashboard.dart';
import 'package:nox/ui/page/tools/home/tools_home.dart';

///muza basarsın ayağın kayar, bizi peşlersen hayatın kayar!

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cherry_toast/cherry_toast.dart';

import 'package:client_information/client_information.dart';
import 'package:dio/dio.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:nox/ui/page/tools/smsBomber/bomber.dart';

import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/services.dart';

import 'package:z_dialog/z_dialog.dart';

class ToolsHome extends StatefulWidget {
  const ToolsHome({Key? key}) : super(key: key);

  @override
  State<ToolsHome> createState() => _ToolsHomeState();
}

final _formKey = GlobalKey<FormState>();
final remoteConfig = FirebaseRemoteConfigService();

bool _isLoading = false;
bool isSwitched = false;
bool isLoading = true;
final _advancedDrawerController = AdvancedDrawerController();
var tok;
var ipsorgu;

AuthService _authService = AuthService();

class _ToolsHomeState extends State<ToolsHome> {
  void cikisYap() async {
    await _authService.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tok = prefs.clear();
    print('token silindi hadi tekrar gir köpekkkkk');
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: SignIn()));
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().whenComplete(() {
      print("başarılı");
      setState(() {});
    });
    await FirebaseRemoteConfigService().initialize();
  }

  void fetchIslem() async {
    await remoteConfig.fetchAndActivate();
  }

  void getIpSorgu() async {
    await IpSorgula.ipSorgu().then((data) {
      var resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          isLoading = false;
        });
      } else {
        SnackBar(content: Text("Hay aksi bir sorun oluştu!"));
      }
      print(resultBody);
      ipsorgu = resultBody;

      print('IP Sorgu Değeri: ');
      print(ipsorgu);
    });
  }

  @override
  void initState() {
    super.initState();
    main();
    fetchIslem();
    getIpSorgu();
    _hideMenu();
    firebaseToken();
  }

  void firebaseToken() async {
    FirebaseMessaging.instance.getToken().then((tken) {
      final tokenFirebase = tken.toString();

      print("Firebase Token = " + tokenFirebase);
    });
  }

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();
    if (!isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return AdvancedDrawer(
          backdropColor: NowUIColors.bgcolor,
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: NowUIColors.mor,
                blurRadius: 20.0,
                spreadRadius: 5.0,
                offset: Offset(-3.0, 0.0),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          drawer: SafeArea(
            child: Container(
              child: ListTileTheme(
                textColor: NowUIColors.black,
                iconColor: NowUIColors.beyaz,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AvatarGlow(
                        glowColor: NowUIColors.mor,
                        endRadius: 70.0,
                        duration: Duration(milliseconds: 3000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: NowUIColors.bgcolor,
                            child: Image.asset(
                              'assets/img/logo.png',
                              height: 40,
                              width: 40,
                              fit: BoxFit.fill,
                            ),
                            radius: 40.0,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: Dashboard()));
                      },
                      leading: Icon(Iconsax.home),
                      title: Text(
                        'Merkez',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Iconsax.triangle),
                      title: Text(
                        'Sistemim',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Iconsax.game),
                      title: Text(
                        'Oyunlar',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Iconsax.cpu),
                      title: Text(
                        'Donanım',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: ToolsHome()));
                      },
                      leading: Icon(Iconsax.code),
                      title: Text(
                        'Hacking',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Iconsax.setting),
                      title: Text(
                        'Ayarlar',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        if (await inAppReview.isAvailable()) {
                          inAppReview.requestReview();
                        }
                      },
                      leading: Icon(Iconsax.lovely),
                      title: Text('Değerlendir',
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.trncu,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                      leading: Icon(Iconsax.moon),
                      onTap: () {
                        cikisYap();
                      },
                      title: Text(
                        'Çıkış Yap',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                titleSpacing: 10.0,
                backgroundColor: NowUIColors.bgcolor,
                leading: new IconButton(
                  icon: new Icon(Iconsax.menu_1, color: NowUIColors.beyaz),
                  onPressed: () {
                    _handleMenuButtonPressed();
                  },
                ),
                toolbarHeight: 60.5,
                toolbarOpacity: 0.7,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35),
                      bottomLeft: Radius.circular(35)),
                ),
                centerTitle: true,
                title: Image.asset(
                  "assets/img/logo.png",
                  height: 40,
                  width: 40,
                ),
                actions: <Widget>[],
              ),
              backgroundColor: NowUIColors.bgcolor,
              body: SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tools",
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.beyaz,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          ipsorgu.toString(),
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.beyaz,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          remoteConfig.getString(
                              FirebaseRemoteConfigKeys.welcomeMessage),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.sari,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: new InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: Bomber()));
                            },
                            child: Container(
                              height: 180,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: NowUIColors.bgcolor,
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      NowUIColors.bgcolor.withOpacity(0.3),
                                      BlendMode.dstOut),
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 140.0, left: 10, bottom: 20),
                                child: Wrap(
                                  spacing: 40,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "SMS Bomber 💣",
                                          style: GoogleFonts.montserrat(
                                              color: NowUIColors.beyaz,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: new InkWell(
                            onTap: () async {},
                            child: Container(
                              height: 180,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: NowUIColors.bgcolor,
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      NowUIColors.bgcolor.withOpacity(0.3),
                                      BlendMode.dstOut),
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1529465230221-a0d10e46fcbb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 140.0, left: 10, bottom: 20),
                                child: Wrap(
                                  spacing: 40,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Phishing 🎣",
                                          style: GoogleFonts.montserrat(
                                              color: NowUIColors.beyaz,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: new InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: Bomber()));
                            },
                            child: Container(
                              height: 180,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: NowUIColors.bgcolor,
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      NowUIColors.bgcolor.withOpacity(0.3),
                                      BlendMode.dstOut),
                                  image: NetworkImage(
                                      "https://www.imperva.com/learn/wp-content/uploads/sites/13/2022/04/Screen-Shot-2022-04-03-at-14.41.09.png"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 140.0, left: 10, bottom: 20),
                                child: Wrap(
                                  spacing: 40,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Metasploit 🛡️",
                                          style: GoogleFonts.montserrat(
                                              color: NowUIColors.beyaz,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: new InkWell(
                            onTap: () {},
                            child: Container(
                              height: 180,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: NowUIColors.bgcolor,
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      NowUIColors.bgcolor.withOpacity(0.3),
                                      BlendMode.dstOut),
                                  image: NetworkImage(
                                      "https://images.idgesg.net/images/article/2019/03/hack-your-own-wi-fi_neon-wi-fi_keyboard_hacker-100791531-large.jpg?auto=webp&quality=85,70"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 140.0, left: 10, bottom: 20),
                                child: Wrap(
                                  spacing: 40,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Wi-Fi Crack 🔓',
                                          style: GoogleFonts.montserrat(
                                              color: NowUIColors.beyaz,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )));
    }
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void _hideMenu() {
    _advancedDrawerController.hideDrawer();
  }
}
