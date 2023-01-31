import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../auth.dart';
import '../component/bottom_navigation_bar.dart';
import '../database/fleetlist.dart';
import '../model/fleet.dart';
import 'registerFleet.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<Fleet> fleetList3 = fleetList;

  final activeFleets =
      fleetList.where((fleet) => fleet.fleet_status == "Active").toList();

  List<bool> showQty = [];
  int _selectedIndex = 0;
  bool isAuthorizedStaff = false;
  final firestore = FirebaseFirestore.instance;

  void checkStaffAuthorization() async {
    String? email = FirebaseAuth.instance.currentUser!.email;
    final docRef = firestore.collection("users").doc(email);
    final doc = await docRef.get();
    if (doc.exists &&
        doc.data()!.containsKey("isAuthorized") &&
        doc.data()!["isAuthorized"] == true) {
      setState(() {
        isAuthorizedStaff = true;
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
    });
  }

  void initState() {
    super.initState();
    for (int i = 0; i < fleetList.length; i++) {
      showQty.add(false);
    }
  }

  void showHide(int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Action'),
          content: Text(
              'Are you sure you want to change the status of this fleet to "Inactive"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Inactive'),
              onPressed: () {
                setState(() {
                  if (activeFleets[i].fleet_status == "Active") {
                    activeFleets[i].fleet_status = "Inactive";
                    showQty.removeAt(i);
                    activeFleets.removeAt(i);
                  } else {
                    activeFleets[i].fleet_status = "Active";
                    showQty.removeAt(i);
                    activeFleets.removeAt(i);
                  }
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  void showAccessDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Access Denied'),
          content: Text(
              'You have No Authorization for this action! Please Advice Your Manager.'),
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
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkStaffAuthorization();
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Staff'),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  Auth _auth = Auth();
                  await _auth.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Icon(
                  Icons.logout,
                ),
              ),
            )
          ],
        ),
        body: Container(
            child: ListView.builder(
                itemCount: activeFleets.length,
                itemBuilder: (BuildContext context, int index) {
                  final fleet = activeFleets[index];
                  return Container(
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Text("No: ${fleet.fleet_no.toString()}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Name: ${fleet.fleet_name}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Date Registered: ${fleet.date_registered}"),
                              Spacer(),
                              InkWell(
                                child: Icon(Icons.delete),
                                onTap: () {
                                  if (isAuthorizedStaff) {
                                    showHide(index);
                                  } else {
                                    showAccessDeniedDialog();
                                  }
                                },
                              ),
                              showQty[index] ? Text('Active') : Text('Inactive')
                            ],
                          ),
                          Row(
                            children: [
                              Text("Location: ${fleet.fleet_location}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Status: ${fleet.fleet_status}"),
                            ],
                          )
                        ],
                      ),
                    )),
                  );
                })),
        bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          isAdmin: false,
        ));
  }
}
