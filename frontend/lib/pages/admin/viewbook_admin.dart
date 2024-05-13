import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'viewUser.dart';

class ViewBookAdmin extends StatefulWidget {
  const ViewBookAdmin({Key? key}) : super(key: key);
  static String routeName = "/view_booking_admin";

  @override
  _ViewBookingAdminState createState() => _ViewBookingAdminState();
}

class _ViewBookingAdminState extends State<ViewBookAdmin> {
  late List<Map<String, dynamic>> _data;
  late String _selectedStatus;
  late String _filterByName;
  bool _isAscending = true; // Track sorting order

  @override
  void initState() {
    super.initState();
    _data = [];
    _selectedStatus = '';
    _filterByName = ''; // Initialize filter name

    fetchData();
  }

  Future<void> fetchData() async {
    final url = _selectedStatus.isNotEmpty
        ? 'https://backend-final-web.onrender.com/getDatafromUserAndMeetingFillter/$_selectedStatus'
        : 'https://backend-final-web.onrender.com/getDatafromUserAndMeeting';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _data = List<Map<String, dynamic>>.from(data['Data']);
        });
      } else {
        print('Failed to fetch data. HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> handleRejectMeeting(int id) async {
    try {
      final response = await http.put(
        Uri.parse(
            'https://backend-final-web.onrender.com/UpdateMeetingByID/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': 'rejected'}),
      );
      final data = json.decode(response.body);
      print('Meeting rejected: $data');
      fetchData();
    } catch (error) {
      print('Error rejecting meeting: $error');
    }
  }

  Future<void> handleApproveMeeting(int id) async {
    try {
      final response = await http.put(
        Uri.parse(
            'https://backend-final-web.onrender.com/UpdateMeetingByID/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': 'approved'}),
      );
      final data = json.decode(response.body);
      print('Meeting approved: $data');
      fetchData();
    } catch (error) {
      print('Error approving meeting: $error');
    }
  }

  Color getStatusTileColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.yellow.shade100;
      case 'approved':
        return Colors.green.shade100;
      case 'rejected':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  void _navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ViewUserAdmin()), // Replace ViewUserScreen() with your actual viewuser screen
    );
  }

  void sortDataById(bool isAscending) {
    setState(() {
      _isAscending = isAscending;
      _data.sort((a, b) => isAscending
          ? a['id'].compareTo(b['id'])
          : b['id'].compareTo(a['id']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('View Booking - Admin'), actions: [
          IconButton(
            icon: Icon(Icons.groups),
            onPressed: () => _navigate(context),
          ),
        ]),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Status: '),
                            DropdownButton<String>(
                              value: _selectedStatus,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedStatus = newValue!;
                                  fetchData();
                                });
                              },
                              items: <String>[
                                '',
                                'approved',
                                'pending',
                                'rejected'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.isNotEmpty
                                      ? value.capitalizeFirstLetter()
                                      : 'All'),
                                );
                              }).toList(),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_upward),
                              onPressed: () => sortDataById(true), // Sort ascending
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_downward),
                              onPressed: () => sortDataById(false), // Sort descending
                            ),
                          ],
                        ),
                      ],
                    ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Filter by Name: '),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _filterByName = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter name to filter',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      final item = _data[index];
                      final status = item['status'] ?? '';
                      final tileColor = getStatusTileColor(status);

                      // Filtering logic
                      if (_filterByName.isNotEmpty &&
                          !item['full_name']
                              .toLowerCase()
                              .contains(_filterByName.toLowerCase())) {
                        return SizedBox
                            .shrink(); // Hide item if not matching the filter
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: tileColor,
                          child: ListTile(
                            title: Text('ID: ${item['id']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Full name: ${item['full_name']}'),
                                Text('Email: ${item['email']}'),
                                Text('Position: ${item['position']}'),
                                Text('Company: ${item['company']}'),
                                Text('Content: ${item['content']}'),
                                Text('Time range: ${item['time_range']}'),
                                Text('Date Meeting: ${item['date']}'),
                                Text('Status: ${item['status']}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          handleApproveMeeting(item['id']),
                                      child: Text('Approve'),
                                    ),
                                    SizedBox(width: 8.0),
                                    ElevatedButton(
                                      onPressed: () =>
                                          handleRejectMeeting(item['id']),
                                      child: Text('Reject'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
