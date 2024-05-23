import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/constants/colors.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
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
    if (picked != null && picked.isAfter(DateTime.now())) {
      // Update the state when a valid date is selected
      setState(() {
        _selectedDate = picked;
      });
    } else {
      // Show a toast message if the selected date is not valid
      Fluttertoast.showToast(msg: 'Please select a date in the future.');
    }
  }

  void _handleTimeChange(String? selectedTime) {
    if (selectedTime != null) {
      // Update the selected time range
      setState(() {
        _timeRange = selectedTime;
      });
    }
  }

  void _handleContentChange(String enteredContent) {
    // Update the content of the message
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
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to submit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (isConfirmed != null && isConfirmed) {
      try {
        final response = await http.post(
          Uri.parse('$pathURLL/createMeeting'), // Replace with your actual endpoint
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Contact Me",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text('Date Meeting'),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const Text('Time'),
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
          const SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                maxLines: 10,
                onChanged: _handleContentChange,
                decoration: const InputDecoration(
                  hintText: 'Enter your message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(CustomColor.bluePrimary),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Submit'),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: const Divider(),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                Image.asset("assets/images/github.png", width: 28),
                Image.asset("assets/images/linkedin.png", width: 28),
                Image.asset("assets/images/facebook.png", width: 28),
                Image.asset("assets/images/instagram.png", width: 28),
                Image.asset("assets/images/telegram.png", width: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
