import 'dart:async';

import 'package:nox/ui/constant/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final Completer<WebViewController> _controller = Completer<WebViewController>();
bool isLoading = true;

class HaberDetay extends StatelessWidget {
  final String url;
  const HaberDetay({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NowUIColors.bgcolor,
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 10.0,
        backgroundColor: NowUIColors.bgcolor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          "assets/img/logo.png",
          height: 40,
          width: 40,
        ),
        actions: <Widget>[],
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: NowUIColors.beyaz,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onPageStarted: (String url) {
          print('Sayfa yüklendi: $url');
        },
        onPageFinished: (String url) {
          print('Sayfa yüklemesi bitti: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: NowUIColors.bgcolor,
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
