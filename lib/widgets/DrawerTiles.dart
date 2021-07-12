import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Authentication/SignIn.dart';
import 'package:opbhallafoundation/screens/EventRegistration.dart';
import 'package:opbhallafoundation/screens/OurInitiatives.dart';
import 'package:opbhallafoundation/screens/PhotoGallery.dart';
import 'package:opbhallafoundation/screens/VideoGallery.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/SupportAsIntern.dart';
import 'package:opbhallafoundation/screens/WebViewScreens/SupportAsVolunteer.dart';
import 'package:opbhallafoundation/screens/users/Home.dart';

class DrawerTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        ListView(
            physics: BouncingScrollPhysics(),
            addRepaintBoundaries: true,
            children: [
              DrawerHeader(
                  child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UserHomePage()));
                },
                child: Image(
                  image: AssetImage("assets/FoundationLogo.png"),
                ),
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                      title: Text(
                        'Our Initiatives',
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OurInitiatives()))),
                  ListTile(
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          onChanged: (value) {
                            if (value == 'Photo Gallery') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoGallery()));
                            } else if (value == 'Video Gallery') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoGallery()));
                            }
                          },
                          hint: Text(
                            'Gallery',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          items: <String>['Photo Gallery', 'Video Gallery']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                  ListTile(
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          onChanged: (value) {
                            if (value == 'Support as Volunteer') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VolunteerSupport(),
                                ),
                              );
                            } else if (value == 'Support as Intern') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InternSupport(),
                                ),
                              );
                            }
                          },
                          hint: Text(
                            'Support Us',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          items: <String>[
                            'Support as Volunteer',
                            'Support as Intern'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        'Event Registration',
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventRegistration(),
                          ),
                        );
                      }),
                  ListTile(
                      title: Text(
                        'About Us',
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
                      ),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                        'Contact Us',
                        style: TextStyle(color: Colors.blue[900], fontSize: 18),
                      ),
                      onTap: () {}),
                ],
              ),
            ]),
        Positioned(
            left: 1,
            right: 1,
            bottom: 2,
            child: TextButton(
              child: Text(
                'Sign In as Admin',
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              ),
            )),
      ]),
    );
  }
}
