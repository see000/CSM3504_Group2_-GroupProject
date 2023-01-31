import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../view/admin_home_page.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../component/bottom_navigation_bar.dart';
import '../model/fleet.dart';
import 'package:intl/intl.dart';
import '../view/registerFleet.dart';
import '../database/fleetlist.dart';
import '../view/user_home_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin = false;

  bool _isAuthorized = false;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkAdmin();
    print("Is this the admin in home page : ${isAdmin}");
  }

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

  void checkStaffAuthorization() async {
    String? email = FirebaseAuth.instance.currentUser!.email;
    final docRef = firestore.collection("users").doc(email);
    final doc = await docRef.get();
    if (doc.exists &&
        doc.data()!.containsKey("isAuthorized") &&
        doc.data()!["isAdmin"] == true) {
      setState(() {
        _isAuthorized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAdmin ? const AdminHomePage() : const UserHomePage(),
    );
  }
}
