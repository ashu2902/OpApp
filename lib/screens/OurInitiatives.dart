import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OurInitiatives extends StatefulWidget {
  @override
  _OurInitiativesState createState() => _OurInitiativesState();
}

class _OurInitiativesState extends State<OurInitiatives> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: _firestore.collection('Initiatives').snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasError
            ? Container(child: Text('${snapshot.error}'))
            : snapshot.hasData
                ? Container(
                    child: ListView.builder(itemBuilder: (context, index) {
                      var doc = snapshot.data.docs[index].data();
                      var img = snapshot.data.docs[index].data();
                    }),
                  )
                : CircularProgressIndicator();
      },
    );
  }
}
