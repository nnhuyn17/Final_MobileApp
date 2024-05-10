import 'package:flutter/widgets.dart';
import '../components/bottom_navigator/bottom_navigator_wrapper_user.dart';

final Map<String, WidgetBuilder> viewBookingRoutesUser = {
  '/view_booking_user': (context) => BottomNavigationBarWrapper(selectedIndex: 1, onItemTapped: (index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home_user');
        break;
      case 1:
        Navigator.pushNamed(context, '/view_booking_user');
        break;
    }
  }),
};