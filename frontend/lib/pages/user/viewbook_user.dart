import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ViewBookUser extends StatefulWidget {
  const ViewBookUser({Key? key}) : super(key: key);
  static String routeName = "/view_booking_user";

  @override
  _ViewBookingUserState createState() => _ViewBookingUserState();
}

class _ViewBookingUserState extends State<ViewBookUser> {
  final _storage = FlutterSecureStorage();
  List<dynamic> _meetingData = [];
  String _selectedStatus = 'all'; // Add a variable to store the selected status

  @override
  void initState() {
    super.initState();
    _getMeetingData();
  }

  Future<void> _getMeetingData() async {
    try {
      final accountId = await _storage.read(key: "accountId") ?? '';
      final response = await http.get(Uri.parse(
          'https://backend-final-web.onrender.com/getAllBookingByUserID/$accountId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _meetingData = data['Data'];
          _meetingData.sort((a, b) =>
              b['id'].compareTo(a['id'])); // Sort by ID from high to low
        });
      } else {
        throw Exception('Failed to load meeting data');
      }
    } catch (error) {
      print('Error fetching meeting data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchApprovedMeetingDetails(
      int meetingId) async {
    final response = await http.get(Uri.parse(
        'https://backend-final-web.onrender.com/getAllMeetingApprovebyID/$meetingId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['Data']);
    } else {
      throw Exception('Failed to load approved meeting details');
    }
  }



  Future<void> _handleDeleteMeeting(int id) async {
    try {
      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Confirmation'),
              content: Text('Are you sure you want to delete?'),
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
                  child: Text('Delete'),
                ),
              ],
            ),
      );

      if (isConfirmed != null && isConfirmed) {
        final response = await http.delete(Uri.parse(
            'https://backend-final-web.onrender.com/deleteMeeting/$id'));
        if (response.statusCode == 200) {
          setState(() {
            _meetingData.removeWhere((meeting) => meeting['id'] == id);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Meeting deleted successfully')),
          );
        } else {
          throw Exception('Failed to delete meeting');
        }
      }
    } catch (error) {
      print('Error deleting meeting: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete meeting')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeetings = _selectedStatus == 'all'
        ? _meetingData
        : _meetingData.where((meeting) => meeting['status'] == _selectedStatus)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booking Requirement'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
            child: DropdownButton<String>(
              value: _selectedStatus,
              items: <String>['all', 'pending', 'approved', 'rejected']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value[0].toUpperCase() + value.substring(1)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue ?? 'all';
                });
              },
              isExpanded: true,
            ),
          ),
          Expanded(
            child: filteredMeetings.isEmpty
                ? Center(
              child: Text('No meetings found'),
            )
                : ListView.builder(
              itemCount: filteredMeetings.length,
              itemBuilder: (context, index) {
                final meeting = filteredMeetings[index];
                Color tileColor;
                switch (meeting['status']) {
                  case 'pending':
                    tileColor = Colors.yellow.shade100;
                    break;
                  case 'approved':
                    tileColor = Colors.green.shade100;
                    break;
                  case 'rejected':
                    tileColor = Colors.red.shade100;
                    break;
                  default:
                    tileColor = Colors.grey.shade100;
                    break;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    color: tileColor,
                    child: ListTile(
                      title: Text(meeting['content']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time range: ${meeting['time_range']}'),
                          Text('Date Meeting: ${meeting['date']}'),
                          Text('Status: ${meeting['status']}'),
                          if (meeting['status'] == 'approved')
                            FutureBuilder<List<Map<String, dynamic>>>(
                              future: _fetchApprovedMeetingDetails(
                                  meeting['id']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading details...');
                                }
                                if (snapshot.hasError) {
                                  return Text('Error loading details');
                                }

                                final approvedMeetings = snapshot.data ?? [];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: approvedMeetings.map((
                                      meetingDetail) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Type: ${meetingDetail['type']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        if (meetingDetail['type'] == 'online')
                                          Text(
                                            'Note: ${meetingDetail['note']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        if (meetingDetail['type'] ==
                                            'offline' &&
                                            meetingDetail['address'] != null)
                                          Text(
                                            'Note: ${meetingDetail['address']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                      ],
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                        ],
                      ),
                      trailing: meeting['status'] == 'pending'
                          ? IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _handleDeleteMeeting(meeting['id']),
                      )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
