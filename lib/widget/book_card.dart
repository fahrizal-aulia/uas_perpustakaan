import 'package:flutter/material.dart';
import '../models/buku.dart';

class BookCard extends StatelessWidget {
  final Buku buku;

  BookCard({required this.buku});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(buku.judul),
        subtitle: Text('Harga: ${buku.harga_buku}'),
        onTap: () {
          // Implementasi tambahan: tambahkan buku ke keranjang atau tindakan lainnya
        },
      ),
    );
  }
}
