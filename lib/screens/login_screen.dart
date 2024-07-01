import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/auth_provider.dart'; // Sesuaikan dengan path provider Anda

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Email dan Password harus diisi.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String apiUrl = 'https://utsuwp.000webhostapp.com/api/login'; // Ganti dengan URL API Laravel Anda
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        String message = responseData['message'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', 'dummytoken');

        Provider.of<AuthProvider>(context, listen: false).login(email);

        Navigator.pushReplacementNamed(context, '/profile');
      } else {
        _showErrorDialog('Login gagal. Periksa email dan password Anda.');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('Terjadi kesalahan. Silakan coba lagi nanti.');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      body: _isLoading ? _buildLoadingIndicator() : _buildLoginForm(),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
