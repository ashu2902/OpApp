import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Authentication/SignIn.dart';
import 'package:opbhallafoundation/screens/Admin/Categories.dart';

class AdminSplashScreen extends StatefulWidget {
  @override
  _AdminSplashScreenState createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (auth.currentUser == null) {
        print('please sign in');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      } else {
        print('user signed in');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Categories()),
            (route) => false);
      }
    });
    return Scaffold(
        body: Center(
            child: FlutterLogo(
      size: 40,
    )));
  }
}
