import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/gestures.dart';
import 'login.dart'; // Import your login screen here

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  var pathURLL = "https://backend-final-web.onrender.com";

  String _selectedGender = 'Female'; // Default gender

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  void _handleSubmit() async {
    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }

    // Construct the data to be sent to the backend
    final Map<String, dynamic> requestData = {
      'email': _emailController.text,
      'full_name': _fullNameController.text,
      'date_of_birth': _dobController.text,
      'position': _positionController.text,
      'company': _companyController.text,
      'gender': _selectedGender,
      'phonenumber': _phoneNumberController.text,
      'password': _passwordController.text,
    };

    // Continue with the HTTP request
    try {

      final response = await http.post(
        Uri.parse('$pathURLL/signUp'), // Replace with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      // Print response body
      print('Response body: ${response.body}');

      if (response.statusCode == 400) {
        print('hi1'); // Print "hi1" for any error, including email already exists
        Fluttertoast.showToast(msg: 'Signup failed');
      } else if (response.statusCode == 401) {
        print('hi'); // Print "hi" specifically for email already exists
        Fluttertoast.showToast(msg: 'Email already exists');
      } else {
        print('Signup successful');
        Fluttertoast.showToast(msg: 'Signup successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } catch (error) {
      print('Error during signup: $error');
      print('Data to be sent to the backend: $requestData');
      Fluttertoast.showToast(msg: 'An error occurred during signup');
      print('Failed to send request to the backend');
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Email'),
            TextField(controller: _emailController, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20.0),
            const Text('Full Name'),
            TextField(controller: _fullNameController),
            const SizedBox(height: 20.0),
            const Text('Date of Birth'),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextField(controller: _dobController, keyboardType: TextInputType.datetime),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Position'),
            TextField(controller: _positionController),
            const SizedBox(height: 20.0),
            const Text('Company'),
            TextField(controller: _companyController),
            const SizedBox(height: 20.0),
            const Text('Gender'),
            DropdownButton<String>(
              value: _selectedGender,
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
              items: <String>['Female', 'Male'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text('Phone Number'),
            TextField(controller: _phoneNumberController, keyboardType: TextInputType.phone),
            const SizedBox(height: 20.0),
            const Text('Password'),
            TextField(controller: _passwordController, obscureText: true),
            const SizedBox(height: 20.0),
            const Text('Confirm Password'),
            TextField(controller: _confirmPasswordController, obscureText: true),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
