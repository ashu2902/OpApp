import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        },
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Something Went Wrong',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Loading',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
