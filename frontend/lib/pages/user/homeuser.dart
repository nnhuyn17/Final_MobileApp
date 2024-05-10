import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<Homepage> {
  // String _date = '';
  // String _timeRange = '9am-11am';
  // String _content = '';
  //
  // void _handleDateChange(String selectedDate) {
  //   final String currentDate = DateTime.now().toIso8601String().split('T')[0];
  //
  //   if (selectedDate.compareTo(currentDate) > 0) {
  //     setState(() {
  //       _date = selectedDate;
  //     });
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Invalid Date'),
  //           content: Text('Please choose a date greater than the current date.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  //
  // void _handleTimeChange(String? selectedTime) {
  //   if (selectedTime != null) {
  //     setState(() {
  //       _timeRange = selectedTime;
  //     });
  //   }
  // }
  //
  //
  // void _handleContentChange(String enteredContent) {
  //   setState(() {
  //     _content = enteredContent;
  //   });
  // }
  //
  // void _handleSubmit() async {
  //   final String fullDate = '$_date';
  //   final bool isConfirmed = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Confirmation'),
  //         content: Text('Are you sure you want to submit?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, true);
  //             },
  //             child: Text('Yes'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, false);
  //             },
  //             child: Text('No'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   if (isConfirmed != null && isConfirmed) {
  //     try {
  //       final response = await http.post(
  //         Uri.parse('https://backend-final-web.onrender.com/createMeeting'), // Replace with your actual endpoint
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode({
  //           'user_id': localStorage.getItem('accountID'), // Replace with the actual user ID
  //           'date': fullDate,
  //           'time_range': _timeRange,
  //           'content': _content,
  //           'status': 'pending',
  //         }),
  //       );
  //
  //       if (response.statusCode == 200) {
  //         Fluttertoast.showToast(msg: 'Success');
  //         print('Success');
  //       } else {
  //         Fluttertoast.showToast(msg: 'Error');
  //         print('Error');
  //       }
  //     } catch (error) {
  //       print('Error: $error');
  //       Fluttertoast.showToast(msg: 'An error occurred');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Me'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text('Date Meeting'),
        //     TextField(
        //       keyboardType: TextInputType.datetime,
        //       onChanged: _handleDateChange,
        //     ),
        //     SizedBox(height: 20.0),
        //     Text('Time'),
        //     DropdownButton<String>(
        //       value: _timeRange,
        //       onChanged: _handleTimeChange,
        //       items: <String>[
        //         '9am-11am',
        //         '1pm-3pm',
        //         '3pm-5pm',
        //         '5pm-7pm',
        //         '7pm-9pm',
        //       ].map<DropdownMenuItem<String>>((String value) {
        //         return DropdownMenuItem<String>(
        //           value: value,
        //           child: Text(value),
        //         );
        //       }).toList(),
        //     ),
        //     SizedBox(height: 20.0),
        //     Text('Message'),
        //     TextField(
        //       maxLines: 10,
        //       onChanged: _handleContentChange,
        //     ),
        //     SizedBox(height: 20.0),
        //     ElevatedButton(
        //       onPressed: _handleSubmit,
        //       child: Text('Submit'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
