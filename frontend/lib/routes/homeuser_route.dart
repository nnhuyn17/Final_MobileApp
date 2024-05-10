import 'package:flutter/widgets.dart';
import '../components/bottom_navigator/bottom_navigator_wrapper_user.dart';

final Map<String, WidgetBuilder> homeRoutesUser = {
  '/home_user': (context) => BottomNavigationBarWrapper(selectedIndex: 0, onItemTapped: (index) {
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