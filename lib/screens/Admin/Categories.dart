import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/EditCategories/Highlights.dart';
import 'package:opbhallafoundation/screens/Admin/EditCategories/RecentActivities.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Admin Panel',
        )),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Highlights
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: _height / 10,
                        width: _width / 2,
                        decoration: BoxDecoration(color: Colors.red),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditHighlights()));
                          },
                          child: Text('Highlights'),
                        ),
                      ),
                    ),
                    //Recent Activities
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: _height / 10,
                        width: _width / 2,
                        decoration: BoxDecoration(color: Colors.red),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditRecentActivities(),
                              ),
                            );
                          },
                          child: Text('Recent Activities'),
                        ),
                      ),
                    ),
                    //OnGoing Events
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: _height / 10,
                        width: _width / 2,
                        decoration: BoxDecoration(color: Colors.red),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditOnGoingEvents(),
                              ),
                            );
                          },
                          child: Text('OnGoing Events'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: _height / 10,
                          width: _width / 2,
                          decoration: BoxDecoration(color: Colors.red),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditGallery()));
                              },
                              child: Text('Gallery'))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditOnGoingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Edit OnGoing Activities'),
    );
  }
}

class EditGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Edit Gallery'),
    );
  }
}
