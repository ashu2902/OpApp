import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotlightWebView extends StatelessWidget {
  // final String title;
  final String selectedUrl;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  SpotlightWebView({
    // @required this.title,
    @required this.selectedUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Spotlights',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.chevron_left_sharp),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: selectedUrl,
          onProgress: (progress) => CircularProgressIndicator(),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
