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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Support as Intern',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.chevron_left_sharp),
            iconSize: 30,
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
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
