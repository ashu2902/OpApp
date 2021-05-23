import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Categories.dart';
import 'package:opbhallafoundation/screens/Admin/adminHome.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email, _password = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'Enter Email'),
            onChanged: (value) {
              _email = value.trim();
            },
          ),
          TextField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(hintText: 'Enter Password'),
            onChanged: (value) {
              _password = value.trim();
            },
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text('SignUp'),
                onPressed: () {
                  signIn();
                  _emailController.clear();
                  _passwordController.clear();
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('SignIn'),
              ),
            ],
          )
        ],
      ),
    );
  }

  signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print('User Signed In');
      return Categories();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User does not exist');
        return Container(
          child: Center(child: Text('User Does not exist \n ${e.message}')),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return Dialog(
          child: Container(
            child: Text(
              "You've entered a wrong password",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }
}
