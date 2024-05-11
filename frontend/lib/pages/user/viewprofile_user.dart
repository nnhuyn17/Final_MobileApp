import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ViewUserProfile extends StatefulWidget {
  const ViewUserProfile({Key? key}) : super(key: key);
  static String routeName = "/view_profile_user";

  @override
  _ViewUserProfileState createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    try {
      final accountId = await _storage.read(key: "accountId") ?? '';
      final response = await http.get(Uri.parse(
          'https://backend-final-web.onrender.com/getUserByID/$accountId'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final accountData = responseData['Account']; // Extract 'Account' data
        setState(() {
          _userData = accountData.isNotEmpty
              ? accountData[0]
              : {}; // Assuming single user data
        });
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (error) {
      print('Error fetching user profile: $error');
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Log Out'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        // Delete all data stored in secure storage
        await _storage.deleteAll();
        // Navigate to login screen
        Navigator.pushReplacementNamed(
            context, '/login'); // Replace current route with login screen
      } catch (error) {
        print('Error logging out: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _userData.isNotEmpty
          ? ListView(
              children: [
                ListTile(
                  title: Text('Full Name: ${_userData['full_name']}'),
                ),
                ListTile(
                  title: Text('Email: ${_userData['email']}'),
                ),
                ListTile(
                  title: Text('Position: ${_userData['position']}'),
                ),
                ListTile(
                  title: Text('Company: ${_userData['company']}'),
                ),
                ListTile(
                  title: Text('Gender: ${_userData['Gender']}'),
                ),
                ListTile(
                  title: Text('Phone Number: ${_userData['PhoneNumber']}'),
                ),
                ListTile(
                  title: Text('Date of Birth: ${_userData['date_of_birth']}'),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
    );
  }
}
