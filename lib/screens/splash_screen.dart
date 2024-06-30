import 'package:flutter/material.dart';
import 'home_screen.dart'; // Sesuaikan dengan halaman home yang sebenarnya

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay untuk mengarahkan pengguna ke halaman selanjutnya setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeScreen()), // Ganti dengan halaman home yang sesuai
      );
    });

    return Scaffold(
      backgroundColor: Colors.blue, // Warna pendidikan, misalnya biru
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Uas Perpustakaan',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Indikator loading atau animasi lainnya
          ],
        ),
      ),
    );
  }
}
