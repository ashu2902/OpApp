import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String _email, _password = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
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
                  signUp();
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

  signUp() async {
    await auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
  }
}
