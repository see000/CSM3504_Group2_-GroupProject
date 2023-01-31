import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/controller/home_page.dart';
import '../component/bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccessPage extends StatefulWidget {
  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  int _selectedIndex = 2;
  String _email = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isAdmin = false;
  final firestore = FirebaseFirestore.instance;
  void checkAdmin() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = firestore.collection("admins").doc(uid);
    final doc = await docRef.get();
    if (doc.exists &&
        doc.data()!.containsKey("isAdmin") &&
        doc.data()!["isAdmin"] == true) {
      setState(() {
        isAdmin = true;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/admin_home');
      }
      if (index == 1) {
        Navigator.pushReplacementNamed(context, '/register_fleet');
      }
      if (index == 2) {
        Navigator.pushReplacementNamed(context, '/access');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkAdmin();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Access Setting : ", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
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
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _submitGrantAccess();
                  },
                  child: Text("Grant Access"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _submitRemoveAccess();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Remove Access"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        isAdmin: isAdmin,
      ),
    );
  }

  void grantAccess(String email) {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .update({"isAuthorized": true});
    } catch (e) {}
  }

  void removeAccess(String email) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .update({"isAuthorized": false});
  }

  void _submitGrantAccess() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        grantAccess(_email);
        final snackBar = SnackBar(
          content: Text("Access Granted Successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        final snackBar = SnackBar(
          content: Text(e.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _submitRemoveAccess() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        removeAccess(_email);
        final snackBar = SnackBar(
          content: Text("Access Removed Successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        final snackBar = SnackBar(
          content: Text(e.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
