import 'package:flutter/widgets.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/routes/homeuser_route.dart';
import 'package:frontend/routes/homeadmin_route.dart';
import 'package:frontend/routes/view_booking_admin.dart';
import 'package:frontend/routes/view_booking_user.dart';
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  ...homeRoutesAdmin,
  ...homeRoutesUser,
  ...viewBookingRoutes,
  ...viewBookingRoutesUser,
  Login.routeName: (context) =>   const Login(),

};