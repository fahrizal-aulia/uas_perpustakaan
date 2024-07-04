import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sewa.dart';
import '../provider/auth_provider.dart';
import '../api/api_sewa.dart';

class SewaScreen extends StatefulWidget {
  @override
  _SewaScreenState createState() => _SewaScreenState();
}

class _SewaScreenState extends State<SewaScreen> {
  late Future<List<Sewa>> futureSewas;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isLoggedIn) {
      loadSewas(authProvider.userId!);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void loadSewas(int userId) {
    setState(() {
      futureSewas = ApiSewa.fetchRentalsByUserId(userId);
      _isLoading = false;
    });
  }

  void _deleteSewa(int id) async {
    try {
      await ApiSewa.deleteRental(id);
      loadSewas(Provider.of<AuthProvider>(context, listen: false).userId!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sewa berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus sewa: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Sewa')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!authProvider.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: Text('Sewa')),
        body: Center(
          child: Text('Silakan login untuk melihat sewa.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sewa')),
      body: FutureBuilder<List<Sewa>>(
        future: futureSewas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load rentals: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada sewa yang ditampilkan.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text('Judul Buku: ${snapshot.data![index].judul_buku}'),
                  subtitle:
                      Text('Harga Buku: ${snapshot.data![index].harga_buku}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Tanggal Kembali: ${snapshot.data![index].tgl_kembali}'),
                      IconButton(
                        onPressed: () {
                          _deleteSewa(snapshot.data![index].id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
