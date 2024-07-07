import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/buku.dart';
import '../provider/auth_provider.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get necessary providers
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.items;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isLoggedIn = authProvider.isLoggedIn;
    final guestEmail =
        'guest@example.com'; // Ganti dengan email tamu yang sesuai

    final apiUrl =
        'https://utsuwp.000webhostapp.com/api/sewa/storeFromCart'; // Ganti dengan URL API yang sesuai

    // Function to perform checkout
    // Function to perform checkout
    // Function to perform checkout
    Future<void> _checkout(BuildContext context, List<Buku> cart,
        {String? idMember, String? email, String? alamat}) async {
      try {
        final List<Map<String, dynamic>> sewaItems = cart
            .map((buku) => {
                  'id_buku': buku.id,
                  'judul_buku': buku.judul,
                  'harga_buku': buku.harga_buku,
                  'tgl_kembali':
                      DateTime.now().add(Duration(days: 7)).toIso8601String(),
                })
            .toList();

        final Map<String, dynamic> body = {
          'sewa_items': sewaItems,
          'id_member': idMember,
          'email':
              email ?? '', // Make sure to send an empty string if email is null
          'alamat': alamat,
        };

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Checkout berhasil!')),
          );
          cartProvider.clearCart(); // Clear the cart after successful checkout
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal melakukan checkout!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exception selama checkout: ${e.toString()}')),
        );
      }
    }

    // Function to show login dialog
    void _showLoginDialog(BuildContext context, CartProvider cartProvider) {
      final _emailController = TextEditingController();
      final _alamatController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Masukkan Email dan Alamat'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(labelText: 'Alamat'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final alamat = _alamatController.text;

                  if (email.isNotEmpty && alamat.isNotEmpty) {
                    await _checkout(context, cart,
                        email: email, alamat: alamat);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Email dan alamat harus diisi!')),
                    );
                  }
                },
                child: Text('Checkout'),
              ),
            ],
          );
        },
      );
    }

    // Build method starts here
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
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform checkout based on user's authentication state
              if (isLoggedIn) {
                final idMember = authProvider.userId.toString();
                _checkout(context, cart,
                    idMember:
                        idMember); // Panggil fungsi checkout dengan memberId
              } else {
                // Jika tidak login, gunakan email tamu
                _showLoginDialog(context, cartProvider);
              }
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
