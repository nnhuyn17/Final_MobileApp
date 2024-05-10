import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static String routeName = "/home_user";

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<Homepage> {
  late DateTime _selectedDate = DateTime.now();
  String _timeRange = '9am-11am';
  String _content = '';
  late String accountId = ''; // Initialize with an empty string
  var pathURLL = "https://backend-final-web.onrender.com";

  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _getAccountId();
  }

  Future<void> _getAccountId() async {
    accountId = await _storage.read(key: "accountId") ?? '';
    // Update the state to rebuild the widget
    setState(() {});
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _handleTimeChange(String? selectedTime) {
    if (selectedTime != null) {
      setState(() {
        _timeRange = selectedTime;
      });
    }
  }

  void _handleContentChange(String enteredContent) {
    setState(() {
      _content = enteredContent;
    });
  }

  void _handleSubmit() async {
    final String fullDate = '${_selectedDate.toIso8601String().split('T')[0]}';
    final bool? isConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to submit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    if (isConfirmed != null && isConfirmed) {
      try {
        final response = await http.post(
          Uri.parse(
              '$pathURLL/createMeeting'), // Replace with your actual endpoint
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': accountId,
            'date': fullDate,
            'time_range': _timeRange,
            'content': _content,
            'status': 'pending',
          }),
        );

        if (response.statusCode == 201) {
          Fluttertoast.showToast(msg: 'Success');
        } else {
          print('Error response body: ${response.body}');
          print('Error response status code: ${response.statusCode}');
          Fluttertoast.showToast(msg: 'Error');
        }
      } catch (error) {
        print('Error: $error');
        Fluttertoast.showToast(msg: 'An error occurred');
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PixelPulse Coder'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date Meeting'),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      "${_selectedDate.toLocal()}".split(' ')[0],
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Time'),
            DropdownButton<String>(
              value: _timeRange,
              onChanged: _handleTimeChange,
              items: <String>[
                '9am-11am',
                '1pm-3pm',
                '3pm-5pm',
                '5pm-7pm',
                '7pm-9pm',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text('Message'),
            TextField(
              maxLines: 10,
              onChanged: _handleContentChange,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
