import 'package:flutter/material.dart';
import '../models/buku.dart';

class CartScreen extends StatelessWidget {
  final List<Buku> cart; // Definisikan cart sebagai list dari objek Buku

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keranjang')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  title: Text(item.judul ?? 'Nama belum tersedia'),
                  subtitle: Text(
                      'Harga: ${item.harga_buku ?? 'Harga belum tersedia'}'),
                  // Anda dapat menambahkan detail atau aksi lain terkait setiap item di keranjang
                );
              },
            ),
          ),
          // Contoh tombol untuk melanjutkan proses checkout
          ElevatedButton(
            onPressed: () {
              // Implementasikan logika untuk memproses item di keranjang (misalnya, checkout)
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
