import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/users/Home.dart';
import 'package:opbhallafoundation/widgets/NewAppBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OP Bhalla Foundation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(child: NewAppBar()),
    );
  }
}
