import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/Authentication/SplashScreen.dart';
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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 150, top: 100),
                child: Container(
                  child: Text(
                    'Sign In as Admin',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Container(
                width: _width / 1.5,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Enter Email', border: OutlineInputBorder()),
                  onChanged: (value) {
                    _email = value.trim();
                  },
                ),
              ),
              SizedBox(
                height: _height / 69,
              ),
              Container(
                width: _width / 1.5,
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: 'Enter Password', border: OutlineInputBorder()),
                  onChanged: (value) {
                    _password = value.trim();
                  },
                ),
              ),
              SizedBox(
                height: _height / 69,
              ),
              Container(
                height: _height / 20,
                width: _width / 2.5,
                child: ElevatedButton(
                  child: Text('Sign In '),
                  onPressed: () {
                    signIn();
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminSplashScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print('User Signed In');
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
