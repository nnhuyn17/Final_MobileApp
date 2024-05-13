import 'package:flutter/material.dart';
import 'package:frontend/pages/admin/viewbook_admin.dart';
import '../../pages/admin/homeadmin.dart';
import '../../pages/admin/viewprofile_admin.dart';
import '../../pages/admin/homeBlogadmin.dart';

class BottomNavigationBarWrapper extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped; // Explicitly specify the type

  const BottomNavigationBarWrapper({
    Key? key, // Add Key? here
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key); // Use super(key: key) here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.teal.shade200,
        unselectedItemColor: Theme.of(context).iconTheme.color, // Use default color of device
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Blog',
            icon: Icon(Icons.add_business),
          ),
          BottomNavigationBarItem(
            label: 'Booking',
            icon: Icon(Icons.date_range),
          ),
          BottomNavigationBarItem(
            label: 'Me',
            icon: Icon(Icons.manage_accounts),
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomepageAd();
      case 1:
        return const HomeBlogAd();
      case 2:
        return const ViewBookAdmin();
      case 3:
        return const viewProfileAd();
      default:
        return Container();
    }
  }
}
