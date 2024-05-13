import 'package:flutter/material.dart';
import 'package:frontend/pages/user/homeuser.dart';
import 'package:frontend/pages/user/viewbook_user.dart';
import 'package:frontend/pages/user/viewprofile_user.dart';
class BottomNavigationBarWrapper extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped; // Explicitly specify the type

  const BottomNavigationBarWrapper({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

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
        return const Homepage();
      case 1:
        return const ViewBookUser();
      case 2:
        return const ViewUserProfile();
      default:
        return Container();
    }
  }
}