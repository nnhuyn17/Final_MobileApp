import 'package:flutter/material.dart';

class ViewBookAdmin extends StatefulWidget {
  const ViewBookAdmin({super.key});
  static String routeName = "/view_booking";

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<ViewBookAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Booking Admin'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
