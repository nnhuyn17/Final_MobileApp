import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomepageAd extends StatefulWidget {
  const HomepageAd({Key? key}) : super(key: key);
  static String routeName = "/home_admin";
  @override
  _HomepageAdState createState() => _HomepageAdState();
}

class _HomepageAdState extends State<HomepageAd> {
  late DateTime _selectedDate;
  late List<Map<String, dynamic>> _meetings;
  late String _pathBackEnd;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _meetings = [];
    _pathBackEnd = "https://backend-final-web.onrender.com";
    fetchMeetings();
  }

  Future<void> fetchMeetings() async {
    try {
      final response = await http.get(Uri.parse(
          '$_pathBackEnd/getByDate/${_selectedDate.toString().split(' ')[0]}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Status'] == 'Success') {
          setState(() {
            _meetings = List<Map<String, dynamic>>.from(data['Data']);
          });
        } else {
          print('Failed to fetch meetings: $data');
        }
      } else {
        print('Failed to fetch meetings. HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching meetings: $error');
    }
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Homepage'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hi Huyen',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to your blog
                  },
                  child: Text('View your blog'),
                ),
                SizedBox(width: 10.0),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Text('Select Date: ' , style: TextStyle(fontSize: 18)),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2050),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                      fetchMeetings();
                    }
                  },
                  child:
                  Container(
                    color: Colors.blueAccent, // Set your desired background color here
                    padding: EdgeInsets.all(8.0), // Optional: Add padding if needed
                    child: Text(
                      formatDate(_selectedDate),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white, // Set text color to contrast with background
                      ),
                    ),
                  ),                  ),
              ],
            ),
            SizedBox(height: 20.0),
            _meetings.isEmpty
                ? Text(
                    _selectedDate == DateTime.now()
                        ? 'Today, ${formatDate(_selectedDate)}'
                        : 'On ${formatDate(_selectedDate)}, You did not have a meeting.',
                    style: TextStyle(fontSize: 18.0),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          _selectedDate == DateTime.now()
                              ? 'Today, ${formatDate(_selectedDate)}'
                              : 'On ${formatDate(_selectedDate)}, You have',
                          style: TextStyle(fontSize: 18.0)),
                      SizedBox(height: 10.0),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _meetings.length,
                        itemBuilder: (context, index) {
                          final meeting = _meetings[index];
                          return ListTile(
                            title: Text(
                                '${meeting['time_range']}: ${meeting['content']} (${meeting['status']})'),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
