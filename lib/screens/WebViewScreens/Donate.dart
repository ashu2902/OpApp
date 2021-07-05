import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Donate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: WebView(
            initialUrl:
                'https://paytm.com/helpinghand/dr-o-p-bhalla-foundation',
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
