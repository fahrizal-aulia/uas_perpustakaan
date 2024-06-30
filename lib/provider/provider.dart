import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _name = '';
  String _username = '';
  String _email = '';
  DateTime? _emailVerifiedAt;
  String _alamat = '';

  String get name => _name;
  String get username => _username;
  String get email => _email;
  DateTime? get emailVerifiedAt => _emailVerifiedAt;
  String get alamat => _alamat;

  bool get isLoggedIn => _email.isNotEmpty;

  Future<void> login(String email) async {
    // Simulasi pengaturan data pengguna setelah login
    _name = 'John Doe';
    _username = 'johndoe';
    _email = email;
    _alamat = 'Alamat Contoh';
    _emailVerifiedAt = DateTime.now(); // Contoh email verified

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    notifyListeners();
  }

  Future<void> logout() async {
    _name = '';
    _username = '';
    _email = '';
    _emailVerifiedAt = null;
    _alamat = '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    notifyListeners();
  }

  Future<void> loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    notifyListeners();
  }
}
