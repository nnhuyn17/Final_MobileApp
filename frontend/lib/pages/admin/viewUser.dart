import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewUserAdmin extends StatefulWidget {
  @override
  _ViewUserAdminState createState() => _ViewUserAdminState();
}

class _ViewUserAdminState extends State<ViewUserAdmin> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://backend-final-web.onrender.com/getAllDemo'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body)['accounts'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage User'),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            var item = data[index];
            return Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name: ${item['full_name']}'),
                      Text('Email: ${item['email']}'),
                      Text('Position: ${item['position']}'),
                      Text('Company: ${item['company']}'),
                      Text('Gender: ${item['Gender']}'),
                      Text('Phone Number: ${item['PhoneNumber']}'),
                      Text('Date of Birth: ${item['date_of_birth']}'),
                    ],
                  ),
                  onTap: () {
                    // Handle tap on each item if needed
                  },
                ),
                const Divider(), // Add a Divider after each ListTile
              ],
            );
          },
        ),
      
      ),
    );
  }
}
