import 'dart:async';
import 'dart:convert';

import 'package:askingucu/ui/constant/color/colors.dart';

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

final List<String> imageList = [
  "https://upperapp.app/cdn/images/1.jpg",
  "https://upperapp.app/cdn/images/2.jpg",
  "https://upperapp.app/cdn/images/3.jpg",
  "https://upperapp.app/cdn/images/4.jpg",
  "https://upperapp.app/cdn/images/5.jpg",
  "https://upperapp.app/cdn/images/6.jpg",
];

bool _isLoading = false;

TextEditingController email = TextEditingController();
TextEditingController parola = TextEditingController();
final _advancedDrawerController = AdvancedDrawerController();
String? _email, _password;

bool otpVisibility = false;

String verificationID = "";

String? totalCast, pricejs, discountedprice;

String userEmail = "";
const double iconSize = 18;
String? msgcount;
String? username;
String? password;
var coinLists;
var _listChannel = [];
// final formatter = intl.NumberFormat.decimalPattern();
final formatter = intl.NumberFormat("#,##0.0######"); // for price change
final percentageFormat = intl.NumberFormat("##0.0#"); // for price change
Timer? _timer;
int _itemPerPage = 1, _currentMax = 10;

ScrollController _scrollController = ScrollController();

bool _obscureText = true;
bool isSubscribed = false;
var theTest;

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();

    _hideMenu();
  }

  var user = "";
  var buy = "Buy Now";

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
            color: NowUIColors.anasite,
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
            iconColor: NowUIColors.anasite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvatarGlow(
                    glowColor: NowUIColors.anasite,
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
                        backgroundColor: NowUIColors.appbar,
                        child: Image.asset(
                          'assets/images/lg.png',
                          fit: BoxFit.fill,
                        ),
                        radius: 40.0,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.user_add),
                  title: Text(
                    "Register",
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Divider(
                  color: Colors.white70,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.setting),
                  title: Text(
                    "Settings",
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  leading: Icon(Iconsax.notification),
                  title: Text(
                    'Signals',
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.mirroring_screen),
                  title: Text(
                    'Channels',
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.medal_star),
                  title: Text(
                    'Privacy',
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.creative_commons),
                  title: Text(
                    'Terms',
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  onTap: () async {},
                  leading: Icon(Iconsax.lovely),
                  title: Text('Review',
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.trncu,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                ExpansionTile(
                  title: Text(
                    'Support',
                    style: GoogleFonts.montserrat(
                        color: NowUIColors.trncu,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: NowUIColors.trncu,
                  ),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Iconsax.support),
                      onTap: () {},
                      title: Text(
                        'info@upperapp.app',
                        style: GoogleFonts.montserrat(
                            color: NowUIColors.trncu,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
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
          backgroundColor: NowUIColors.appbar,
          leading: new IconButton(
            icon: new Icon(Iconsax.menu_1, color: NowUIColors.trncu),
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
            "assets/images/lg.png",
            height: 110,
            width: 110,
          ),
          actions: <Widget>[],
        ),
        backgroundColor: NowUIColors.bgcolor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: NowUIColors.trncu,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: new InkWell(
                    onTap: () {},
                    child: Container(
                      height: 135,
                      width: 397,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 12),
                        child: Wrap(
                          spacing: 40,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "10+",
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.appbar,
                                      fontSize: 91,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "PREMIUM \nTelegram and \nDiscord channel \ncrypto signals in \nUPPER.",
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.appbar,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You dont need to subscribe to numerous \nTelegram and Discord Channels for \npremium signals anymore.",
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.beyaz,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Upper automatically follows more than 10\n channels and instantly sends hundreds of\n premium signals to your mobile phone.",
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.beyaz,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/usda.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Access the most popular and rewarding \nchannels signals for 69 only.",
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.beyaz,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 372,
                  height: 74,
                  // Inkwell
                  child: InkWell(
                    // display a snackbar on tap
                    onTap: () async {},
                    // implement the image with Ink.image
                    child: Ink.image(
                      fit: BoxFit.fill,
                      image: const AssetImage('assets/images/price.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/smsk.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'UPPER',
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.trncu,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      " members take signals.\n instantly that's why they always \nwin",
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.beyaz,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/krl.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Premium signals only members.",
                      style: GoogleFonts.montserrat(
                          color: NowUIColors.beyaz,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GFCarousel(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  initialPage: 0,
                  enlargeMainPage: true,
                  viewportFraction: 1.0,
                  autoPlayAnimationDuration: Duration(milliseconds: 700),
                  items: imageList.map(
                    (url) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            url,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onPageChanged: (index) {
                    setState(() {
                      index;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/bell.png',
                          height: 55,
                          width: 59,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "No unnecessary messages\n Premium signals only",
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.beyaz,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/cogs.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "You can manage your signals. \nDND mode available! Turn alerts \noff easily when you sleep or \nwork.",
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.beyaz,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/chk.png',
                          height: 51,
                          width: 51,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Less time more transaction \nYou don't need unnecessary \nnotifications. Be informed only \nwhen you need signal.",
                          style: GoogleFonts.montserrat(
                              color: NowUIColors.beyaz,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: NowUIColors.black,
                      boxShadow: [
                        new BoxShadow(
                          color: NowUIColors.black,
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: new BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "PREMIUM PLAN",
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.beyaz,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              height: 23,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Get signals from',
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.beyaz,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' \$1500',
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.trncu,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'worth',
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.beyaz,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'of channels for -96% off.',
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.beyaz,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: const Divider(
                                      color: NowUIColors.white,
                                      height: 30,
                                    )),
                              ),
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '\$69',
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.trncu,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ButtonTheme(
                              height: 50.0,
                              minWidth: 280,
                              child: FlatButton(
                                textColor: NowUIColors.black,
                                color: NowUIColors.trncu,
                                onPressed: () async {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Text(
                                  "SUBSCRIPTION",
                                  style: GoogleFonts.montserrat(
                                      color: NowUIColors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void _hideMenu() {
    _advancedDrawerController.hideDrawer();
  }
}
