import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  String _email = "", _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please enter a valid email';
                      }
                    },
                    onSaved: (input) => _email = input!,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input!.length < 6) {
                        return 'Your password needs to be atleast 6 characters';
                      }
                    },
                    onSaved: (input) => _password = input!,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: Text(
                        'LOGIN',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Don\'t have an account? Sign up now!',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black26,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User? user = await _auth.signInWithEmailAndPassword(_email, _password);

        // check if user is admin
        String uid = user!.uid;
        final docRef = firestore.collection("admins").doc(uid);
        final doc = await docRef.get();
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        loginFailed(e.toString());
      }
    }
  }

  void loginFailed(String e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed to Log In'),
          content: Text(e),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}
