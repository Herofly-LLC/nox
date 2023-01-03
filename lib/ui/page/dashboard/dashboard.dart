import 'dart:async';
import 'dart:convert';

import 'package:askingucu/core/model/haber_model.dart';
import 'package:askingucu/core/service/auth.dart';
import 'package:askingucu/core/utils/api.dart';
import 'package:askingucu/ui/constant/color/colors.dart';
import 'package:askingucu/ui/page/auth/login/sign_in.dart';
import 'package:askingucu/ui/page/newsDetails/news_details.dart';

import 'package:askingucu/ui/page/tools/home/tools_home.dart';

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
import 'package:in_app_review/in_app_review.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/services.dart';

import 'package:z_dialog/z_dialog.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

final _formKey = GlobalKey<FormState>();

bool _isLoading = false;
bool isSwitched = false;
final _advancedDrawerController = AdvancedDrawerController();
var tok;

AuthService _authService = AuthService();
final InAppReview inAppReview = InAppReview.instance;

class _DashboardState extends State<Dashboard> {
  List<HaberModel> newsList = [];

  void getTech(tag) async {
    NewsService.getTech(tag).then((data) {
      Map resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          Iterable result = resultBody['result'];
          newsList = result.map((newsList) => HaberModel(newsList)).toList();
        });
      } else {
        SnackBar(content: Text("Hay aksi bir sorun oluştu!"));
      }
      print('Haber Buradaaaa babaaaaaaaaaaaa: ' + resultBody.toString());
    });
  }

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

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("başarılı");
      setState(() {});
    });
    _hideMenu();

    firebaseToken();
    getTech(tag);
  }

  void firebaseToken() async {
    FirebaseMessaging.instance.getToken().then((tken) {
      final tokenFirebase = tken.toString();

      print("Firebase Token = " + tokenFirebase);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                getTech(tag);
              });
              return await Future.delayed(Duration(seconds: 1));
            },
            edgeOffset: 25,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                //category picker slider

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return GestureDetector(
                        //tile ontap
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HaberDetay(
                                      url: newsList[index].url,
                                    )),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NewsTileStyle(
                                name: newsList[index].name,
                                url: newsList[index].url,
                                description: newsList[index].description,
                                image: newsList[index].urlToImage),
                          ],
                        ),
                      );
                    },
                    childCount: newsList.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void _hideMenu() {
    _advancedDrawerController.hideDrawer();
  }
}

class NewsTileStyle extends StatelessWidget {
  final String name, url, description, image;
  const NewsTileStyle(
      {Key? key,
      required this.name,
      required this.url,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0, left: 20, right: 20),
      decoration: BoxDecoration(
          color: NowUIColors.bgcolor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: []),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: new InkWell(
              onTap: () {},
              child: Container(
                height: 165,
                width: 490,
                decoration: BoxDecoration(
                  color: NowUIColors.mor,
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 110, left: 5),
                  child: Wrap(
                    spacing: 30,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          color: NowUIColors.card,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          name,
                          style: GoogleFonts.dmSans(
                              color: NowUIColors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: NowUIColors.mor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              description,
              style: GoogleFonts.dmSans(
                color: NowUIColors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
