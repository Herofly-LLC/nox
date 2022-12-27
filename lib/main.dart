// @dart=2.9

//bu bir Doğan Oğuz projesidir.

//"Eğer beni güldürmek istiyorsan, beni react native ile tehdit edeceksin aslanım"
import 'package:askingucu/ui/page/dashboard/dashboard.dart';
import 'package:askingucu/ui/page/onboard/onboard.dart';
import 'package:askingucu/ui/page/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nox',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: <String, WidgetBuilder>{
          '/splash': (BuildContext context) => new Splash(),
          '/onboard': (BuildContext context) => new Onboard(),
          '/dashboard': (BuildContext context) => new Dashboard(),
        });
  }
}
