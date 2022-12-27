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

bool _isLoading = false;

final _advancedDrawerController = AdvancedDrawerController();

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
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
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            )));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void _hideMenu() {
    _advancedDrawerController.hideDrawer();
  }
}
