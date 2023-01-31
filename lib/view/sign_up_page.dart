import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                    "Sign Up",
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
                      child: Text('Sign up'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                          decoration: TextDecoration.underline,
                        ),
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

  // void _submit() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     try {
  //       User? user =
  //           await _auth.createUserWithEmailAndPassword(_email, _password);
  //       Navigator.pushReplacementNamed(context, '/home');
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User? user =
            await _auth.createUserWithEmailAndPassword(_email, _password);
        FirebaseFirestore.instance
            .collection("users")
            .doc(_email)
            .set({"isAuthorized": false});
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        SignUpFailed(e.toString());
      }
    }
  }

  void SignUpFailed(String e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed to Sign Up'),
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
