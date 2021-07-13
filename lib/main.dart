import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(GpsApp());
}

class GpsApp extends StatefulWidget {
  const GpsApp({Key? key}) : super(key: key);

  @override
  _GpsAppState createState() => _GpsAppState();
}

class _GpsAppState extends State<GpsApp> {
  late WebViewController controller;
  String _initialUrl = 'http://3.142.93.126/login';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          String? url = await controller.currentUrl();
          if (url == _initialUrl) {
            return true;
          } else {
            controller.goBack();
            return false;
          }
        },
        child: Scaffold(
          body:
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2196F3),
                  Colors.white,
                ],
              ),
            ),
            child: SafeArea(
              top: true,
              bottom: true,
              left: true,
              right: true,
              child: Center(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _initialUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    controller = webViewController;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
