import '../database/fleetlist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/view/registerFleet.dart';
import '../../model/fleet.dart';
import '../component/bottom_navigation_bar.dart';

class InactivePage extends StatefulWidget {
  InactivePage({Key? key}) : super(key: key);

  @override
  State<InactivePage> createState() => _InactivePageState();
}

class _InactivePageState extends State<InactivePage> {
  List<bool> showQty = [];
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/admin_home');
      }
      if (index == 1) {
        Navigator.pushReplacementNamed(context, '/inactive');
      }
      if (index == 2) {
        Navigator.pushReplacementNamed(context, '/access');
      }
    });
  }

  final inactiveFleets =
      fleetList.where((fleet) => fleet.fleet_status == "Inactive").toList();
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
              'Are you sure you want to change the status of this fleet to "Active"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Active'),
              onPressed: () {
                setState(() {
                  if (inactiveFleets[i].fleet_status == "Active") {
                    inactiveFleets[i].fleet_status = "Inactive";
                    showQty.removeAt(i);
                    inactiveFleets.removeAt(i);
                  } else {
                    inactiveFleets[i].fleet_status = "Active";
                    showQty.removeAt(i);
                    inactiveFleets.removeAt(i);
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

  // void showHide(int i) {
  //   setState(() {
  //     showQty[i] = !showQty[i];
  //   });
  // }

  final List<Fleet> fleetList2 = fleetList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Inactive Fleets'),
          ],
        ),
        actions: <Widget>[],
      ),
      body: Container(
          child: ListView.builder(
              itemCount: inactiveFleets.length,
              itemBuilder: (BuildContext context, int index) {
                final fleet = inactiveFleets[index];

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
                              child: Icon(Icons.refresh),
                              onTap: () {
                                showHide(index);
                              },
                            ),
                            showQty[index] ? Text('Inactive') : Text('Active')
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterFleet())),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        isAdmin: true,
      ),
    );
  }
}
