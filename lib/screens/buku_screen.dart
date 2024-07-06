import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/buku.dart';
import '../api/api_buku.dart';
import '../screens/cart_screen.dart';
import '../provider/cart_provider.dart';

class BukuScreen extends StatefulWidget {
  @override
  _BukuScreenState createState() => _BukuScreenState();
}

class _BukuScreenState extends State<BukuScreen> {
  late Future<List<Buku>> futureBuku;

  @override
  void initState() {
    super.initState();
    futureBuku = ApiBuku.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Buku')),
      body: Center(
        child: FutureBuilder<List<Buku>>(
          future: futureBuku,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final buku = snapshot.data![index];
                  return ListTile(
                    title: Text(buku.judul ?? 'Judul tidak tersedia'),
                    subtitle: Text('Harga: ${buku.harga_buku}'),
                    onTap: () {
                      cartProvider.addToCart(buku);
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
