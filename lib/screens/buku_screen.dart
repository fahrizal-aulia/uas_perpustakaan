import 'package:flutter/material.dart';
import '../models/buku.dart';
import '../api/api_buku.dart';
import '../screens/cart_screen.dart';

class BukuScreen extends StatefulWidget {
  @override
  _BukuScreenState createState() => _BukuScreenState();
}

class _BukuScreenState extends State<BukuScreen> {
  List<Buku> _cart = []; // State untuk menyimpan buku yang akan disewa

  late Future<List<Buku>> futureBuku;

  @override
  void initState() {
    super.initState();
    futureBuku = ApiBuku.fetchBooks();
  }

  void addToCart(Buku buku) {
    setState(() {
      _cart.add(buku);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  return ListTile(
                    title: Text(snapshot.data![index].judul.toString()),
                    subtitle: Text(
                        'harga: ${snapshot.data![index].harga_buku.toString()}'),
                    onTap: () {
                      addToCart(snapshot.data![index]);
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
              builder: (context) => CartScreen(cart: _cart),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
