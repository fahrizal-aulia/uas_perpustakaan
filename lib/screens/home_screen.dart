import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/sample.jpg', // Ganti dengan path gambar logo perpustakaan Anda
              width: 200, // Sesuaikan ukuran logo sesuai kebutuhan
              height: 200,
              fit: BoxFit.contain, // Sesuaikan jenis tata letak gambar
            ),
            SizedBox(height: 20),
            Text(
              'Uas Perpustakaan',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
