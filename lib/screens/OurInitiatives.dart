import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/Initiatives.dart';
import 'package:opbhallafoundation/widgets/DrawerTiles.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Our Initiatives',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: DrawerTiles(),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('OurInitiatives').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? Container(child: Text('${snapshot.error}'))
              : snapshot.hasData
                  ? Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.only(top: 30),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: _height / 47,
                                  mainAxisExtent: _height / 4.1,
                                  crossAxisSpacing: 2,
                                  crossAxisCount: 2),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var doc = snapshot.data.docs[index].data();
                            var img = snapshot.data.docs[index].data();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: GestureDetector(
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: _height / 5,
                                          width: _width,
                                          child: ClipRect(
                                            clipBehavior: Clip.hardEdge,
                                            child: Image.network(
                                              img['url'],
                                              filterQuality: FilterQuality.low,
                                              fit: BoxFit.fill,
                                              height: _height,
                                              width: _width,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: Center(
                                          child: Text(
                                            doc['heading'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
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
