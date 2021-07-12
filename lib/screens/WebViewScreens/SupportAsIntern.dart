import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InternSupport extends StatelessWidget {
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
          'Support as Intern',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: SafeArea(
          child: WebView(
            initialUrl:
                'https://docs.google.com/forms/d/1fx7ovySl3IKorzq1Zv8L1yzbE6ZsWLUZSXZt2jpTSzE/viewform?edit_requested=true',
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
