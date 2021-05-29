import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRegister extends StatefulWidget {
  @override
  _AdminRegisterState createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
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
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 60),
              child: Container(
                child: Text(
                  'Create a new Admin',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Container(
              width: _width / 1.5,
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _email = value.trim().toLowerCase();
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
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
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
                child: Text('SignUp'),
                onPressed: () {
                  signUp();
                  _emailController.clear();
                  _passwordController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  signUp() async {
    await auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
  }
}
