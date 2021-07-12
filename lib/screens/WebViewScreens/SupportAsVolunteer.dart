import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VolunteerSupport extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffff6b5c),
        title: Text(
          'Support as Volunteer',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: SafeArea(
          child: WebView(
            initialUrl:
                'https://docs.google.com/forms/d/19axjfvH9g_vX9sgmYO9woedrCQjxHMOGH13D2LBtvhE/viewform?edit_requested=true',
            onProgress: (progress) => CircularProgressIndicator(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }
}
