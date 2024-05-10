import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/gestures.dart';
import '../pages/admin/homeadmin.dart';
import './user/homeuser.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final _storage = const FlutterSecureStorage();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSubmit() async {
    print(_emailController.text,);
    print(_passwordController.text);

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8081/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String token = data['token'];
        final String userRole = data['role'];
        final String accountId = data['id'].toString();

        await _storage.write(key: 'accountId', value: accountId);
        await _storage.write(key: 'currentRole', value: userRole);

        if (userRole == 'user') {
          // await _storage.write(key: 'token-user', value: token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else if (userRole == 'admin') {
          // await _storage.write(key: 'token-admin', value: token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomepageAd()),
          );
        }
      } else {
        // Handle login failure
        Fluttertoast.showToast(msg: 'Login failed');
      }
    } catch (error) {
      print('An error occurred during login: $error');
      Fluttertoast.showToast(msg: 'An error occurred during login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        );
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
