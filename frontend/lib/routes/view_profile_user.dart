import 'package:flutter/widgets.dart';
import '../components/bottom_navigator/bottom_navigator_wrapper_user.dart';

final Map<String, WidgetBuilder> viewProfileRoutesUser = {
  '/view_profile_user': (context) => BottomNavigationBarWrapper(selectedIndex: 2, onItemTapped: (index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home_user');
        break;
      case 1:
        Navigator.pushNamed(context, '/view_booking_user');
        break;
      case 2:
        Navigator.pushNamed(context, '/view_profile_user');
        break;
    }
  }),
};
