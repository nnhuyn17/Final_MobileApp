import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
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

  Future<void> _handleDeleteMeeting(int id) async {
    try {
      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booking Requirement'),
      ),
      body: _meetingData.isEmpty
          ? Center(
              child: Text('No meetings found'),
            )
          : ListView.builder(
              itemCount: _meetingData.length,
              itemBuilder: (context, index) {
                final meeting = _meetingData[index];
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

                return Container(
                  color: tileColor,
                  child: ListTile(
                    title: Text(meeting['content']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Time range: ${meeting['time_range']}'),
                        Text('Date Meeting: ${meeting['date']}'),
                        Text('Status: ${meeting['status']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red, // Set color to red
                      onPressed: () => _handleDeleteMeeting(meeting['id']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
