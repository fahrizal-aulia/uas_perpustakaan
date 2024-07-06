import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/buku_screen.dart' as BukuScreen;
import 'screens/sewa_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/cart_screen.dart';
import 'provider/auth_provider.dart';
import 'models/buku.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadEmail()),
        // Tambahkan provider lain jika diperlukan, misalnya CartProvider
      ],
      child: MaterialApp(
        title: 'Uas perpustakaan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginForm(),
          '/main': (context) => MainScreen(),
          '/buku': (context) => BukuScreen.BukuScreen(),
          '/sewa': (context) => SewaScreen(),
          '/profile': (context) => ProfileScreen(),
          '/cart': (context) => CartScreen(
              cart: []), // Inisialisasi cart dengan list kosong atau nilai awal yang sesuai
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
  List<Buku> _cart = []; // Menyimpan buku yang akan disewa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          SplashScreen(),
          BukuScreen.BukuScreen(),
          SewaScreen(),
          ProfileScreen(),
          CartScreen(cart: _cart), // Pastikan CartScreen menerima argumen _cart
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
            icon: Icon(Icons.shopping_cart),
            label: 'Cart', // Label untuk navigasi ke halaman Cart
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
          // Navigasi ke halaman sesuai dengan index bottom navigation
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/buku');
              break;
            case 2:
              Navigator.pushNamed(context, '/sewa');
              break;
            case 3:
              // Langsung tampilkan halaman CartScreen dengan _cart sebagai argumen
              setState(() {
                _currentIndex =
                    4; // Index 4 adalah CartScreen dalam IndexedStack
              });
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
