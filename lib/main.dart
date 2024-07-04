import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/buku_screen.dart';
import 'screens/sewa_screen.dart';
import 'screens/profile_screen.dart';
import 'provider/auth_provider.dart'; // Sesuaikan dengan path provider Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider()..loadEmail(), // Inisialisasi AuthProvider
      child: MaterialApp(
        title: 'Uas perpustakaan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>
              SplashScreen(), // Splash screen sebagai halaman awal
          '/login': (context) => LoginForm(), // Halaman login
          '/main': (context) => MainScreen(), // Halaman utama setelah login
          '/buku': (context) => BukuScreen(), // Halaman buku
          '/sewa': (context) => SewaScreen(), // Halaman sewa
          '/profile': (context) => ProfileScreen(), // Halaman profile
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          SplashScreen(), // Placeholder untuk SplashScreen, bisa dihapus jika tidak digunakan
          BukuScreen(),
          SewaScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Buku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Sewa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
