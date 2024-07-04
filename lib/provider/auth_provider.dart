import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String _name = '';
  String _username = '';
  String _email = '';
  DateTime? _emailVerifiedAt;
  String _alamat = '';
  int? _userId;

  String get name => _name;
  String get username => _username;
  String get email => _email;
  DateTime? get emailVerifiedAt => _emailVerifiedAt;
  String get alamat => _alamat;
  int? get userId => _userId;

  bool get isLoggedIn => _email.isNotEmpty;

  Future<void> login(String email, String password) async {
    String apiUrl = 'https://utsuwp.000webhostapp.com/api/login';
    var response = await http.post(Uri.parse(apiUrl), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      _userId = responseData['user_id'];
      _name = responseData['name'];
      _username = responseData['username'];
      _email = responseData['email'];
      _alamat = responseData['alamat'];
      _emailVerifiedAt = responseData['email_verified_at'] != null
          ? DateTime.parse(responseData['email_verified_at'])
          : null;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', _userId!);
      await prefs.setString('email', _email);
      notifyListeners();
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<void> logout() async {
    _name = '';
    _username = '';
    _email = '';
    _emailVerifiedAt = null;
    _alamat = '';
    _userId = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('email');
    notifyListeners();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('user_id');
    _email = prefs.getString('email') ?? '';
    if (_userId != null) {
      String apiUrl = 'https://utsuwp.000webhostapp.com/api/member/$_userId';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        _name = userData['name'];
        _username = userData['username'];
        _email = userData['email'];
        _alamat = userData['alamat'];
        _emailVerifiedAt = userData['email_verified_at'] != null
            ? DateTime.parse(userData['email_verified_at'])
            : null;

        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    }
  }

  Future<void> loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    notifyListeners();
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
