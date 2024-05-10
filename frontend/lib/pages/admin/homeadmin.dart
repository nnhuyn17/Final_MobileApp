import 'package:flutter/material.dart';

class HomepageAd extends StatefulWidget {
  const HomepageAd({super.key});
  static String routeName = "/home_admin";

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageAd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Me'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
