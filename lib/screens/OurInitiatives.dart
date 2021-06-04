import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OurInitiatives extends StatefulWidget {
  @override
  _OurInitiativesState createState() => _OurInitiativesState();
}

class _OurInitiativesState extends State<OurInitiatives> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection('OurInitiatives').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? Container(child: Text('${snapshot.error}'))
              : snapshot.hasData
                  ? Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 2, crossAxisCount: 3),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var doc = snapshot.data.docs[index].data();
                            var img = snapshot.data.docs[index].data();
                            return Container(
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        img['url'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      doc['heading'],
                                      style: TextStyle(fontSize: 18),
                                    ))
                                  ],
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Initiatives(selectedUrl: doc['desc']),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
        },
      ),
    );
  }
}

class Initiatives extends StatelessWidget {
  // final String title;
  final String selectedUrl;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  Initiatives({
    // @required this.title,
    @required this.selectedUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: selectedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
