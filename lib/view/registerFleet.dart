import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_page/controller/home_page.dart';
import '../component/bottom_navigation_bar.dart';
import '../model/fleet.dart';
import '../database/fleetlist.dart';

class RegisterFleet extends StatefulWidget {
  RegisterFleet({Key? key}) : super(key: key);
  @override
  State<RegisterFleet> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegisterFleet> {
  int _selectedIndex = 1;

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
      if (isAdmin) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/admin_home');
        }
        if (index == 1) {
          Navigator.pushReplacementNamed(context, '/inactive');
        }
        if (index == 2) {
          Navigator.pushReplacementNamed(context, '/access');
        }
      }

      if (!isAdmin) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/user_home');
        }
        if (index == 1) {
          Navigator.pushReplacementNamed(context, '/register_fleet');
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final _formsKey = GlobalKey<FormState>();
  final fleet = Fleet('', '', '', '', 'Active');

  @override
  Widget build(BuildContext context) {
    checkAdmin();
    return Scaffold(
      appBar: AppBar(title: const Text('Register Fleet')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formsKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                      initialValue: 'F-${fleetList.length + 1}',
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Fleet Number',
                      ),
                      onSaved: (value) => fleet.fleet_no = value!),
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Fleet Name'),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Fleet name is required.';
                        }
                      }),
                      onSaved: (value) => fleet.fleet_name = value!),
                  TextFormField(
                      initialValue: DateFormat('dd/MM/yyyy')
                          .format(DateTime.now())
                          .toString(),
                      decoration:
                          const InputDecoration(labelText: 'Date Registered'),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Registered date is required.';
                        }
                      }),
                      onSaved: (value) => fleet.date_registered = value!),
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Fleet Location'),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Fleet location is required.';
                        }
                      }),
                      onSaved: (value) => fleet.fleet_location = value!),
                  const Text('*Fleet status will be active by default.'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formsKey.currentState!.validate()) {
                          _formsKey.currentState!.save();

                          // Add the new fleet object to the list
                          final newFleet = Fleet(
                              fleet.fleet_no,
                              fleet.fleet_name,
                              fleet.date_registered,
                              fleet.fleet_location,
                              fleet.fleet_status);
                          fleetList.add(newFleet);

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                    content:
                                        Text('Fleet registered successfully!'));
                              });

                          debugPrint(
                              'Fleet number: ${fleet.fleet_no} Fleet name: ${fleet.fleet_name} Date registered: ${fleet.date_registered} Location: ${fleet.fleet_location} Status: ${fleet.fleet_status}');

                          Navigator.pushReplacementNamed(
                              context, '/register_fleet');
                        }
                      },
                      child: const Text('Register'))
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        isAdmin: isAdmin,
      ),
    );
  }
}
