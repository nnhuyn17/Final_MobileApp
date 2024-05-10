import 'package:flutter/widgets.dart';
import '../components/bottom_navigator/bottom_navigator_wrapper.dart';

final Map<String, WidgetBuilder> homeRoutesAdmin = {
  '/home_admin': (context) => BottomNavigationBarWrapper(selectedIndex: 0, onItemTapped: (index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home_admin');
        break;
      case 1:
        Navigator.pushNamed(context, '/view_booking');
        break;
    }
  }),
};