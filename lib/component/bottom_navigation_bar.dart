import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  final bool isAdmin;

  BottomNavigation({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    var items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
    ];

    if (isAdmin) {
      items.insert(
        1,
        BottomNavigationBarItem(
          icon: Icon(Icons.document_scanner_outlined),
          label: "Inactive Fleet",
        ),
      );

      items.insert(
        2,
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Access Settings",
        ),
      );
    } else {
      items.insert(
        1,
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Add New Fleet",
        ),
      );
    }

    return BottomNavigationBar(
      items: items,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red,
      onTap: onItemTapped,
    );
  }
}
