import 'package:flutter/material.dart';
// import 'package:uas_perpustakaan/models/sewa.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/buku_screen.dart';
import 'screens/sewa_screen.dart';
import 'screens/profile_screen.dart';
import 'widget/navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uas perpustakaan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    SplashScreen(),
    LoginScreen(),
    BukuScreen(),
    SewaScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar:
          NavBar(currentIndex: _currentIndex, onTap: onTabTapped),
    );
  }
}
