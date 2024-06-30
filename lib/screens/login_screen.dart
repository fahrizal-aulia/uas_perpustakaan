import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Email dan Password harus diisi.');
      return;
    }

    String apiUrl =
        'https://utsuwp.000webhostapp.com/api/login'; // Ganti dengan URL API Laravel Anda
    try {
      var response = await http.post(Uri.parse(apiUrl), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        String token = responseData['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        Navigator.pushNamed(context, '/profile');
      } else {
        _showErrorDialog('Login gagal. Periksa email dan password Anda.');
      }
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan. Silakan coba lagi nanti.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Gagal'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Masukkan email Anda',
            ),
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Masukkan password Anda',
            ),
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
