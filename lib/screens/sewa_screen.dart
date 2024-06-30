import 'package:flutter/material.dart';
import '../models/sewa.dart';
import '../api/api_sewa.dart';

class SewaScreen extends StatefulWidget {
  @override
  _SewaScreenState createState() => _SewaScreenState();
}

class _SewaScreenState extends State<SewaScreen> {
  late Future<List<Sewa>> futureSewas;

  @override
  void initState() {
    super.initState();
    futureSewas =
        ApiSewa.fetchRentals(); // Menggunakan ApiSewa untuk fetch sewa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sewas')),
      body: Center(
        child: FutureBuilder<List<Sewa>>(
          future: futureSewas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title:
                        Text('harga_buku: ${snapshot.data![index].harga_buku}'),
                    subtitle: Text(
                        'Tanggal Kembali: ${snapshot.data![index].tgl_kembali}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
