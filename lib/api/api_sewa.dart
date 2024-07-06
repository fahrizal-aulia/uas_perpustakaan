import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sewa.dart';
import '../models/buku.dart';

class ApiSewa {
  static const String apiUrl = 'http://192.168.1.6:8000/api/sewa';

  // Fetch rentals by user ID
  static Future<List<Sewa>> fetchRentalsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/user/$userId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((sewa) => Sewa.fromJson(sewa)).toList();
    } else {
      throw Exception('Gagal memuat daftar sewa');
    }
  }

  // Checkout function
  static Future<void> checkout(List<Buku> cart,
      {String? idMember, String? email, String? alamat}) async {
    try {
      final List<Map<String, dynamic>> sewaItems = cart
          .map((buku) => {
                'id_buku': buku.id,
                // 'judul_buku': buku.judul,
                'harga_buku': buku.harga_buku,
                'tgl_kembali':
                    DateTime.now().add(Duration(days: 7)).toIso8601String(),
              })
          .toList();

      final Map<String, dynamic> body = {
        'sewa_items': sewaItems,
      };

      if (idMember != null) {
        body['id_member'] = idMember;
      } else if (email != null && alamat != null) {
        body['email'] = email;
        body['alamat'] = alamat;
      } else {
        throw Exception(
            'Informasi yang diperlukan untuk checkout tidak lengkap');
      }

      final response = await http.post(
        Uri.parse('$apiUrl/checkout'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Checkout berhasil
        print('Checkout berhasil: ${response.body}');
      } else {
        // Gagal menyelesaikan checkout
        print('Gagal menyelesaikan checkout: ${response.statusCode}');
        throw Exception('Gagal menyelesaikan checkout');
      }
    } catch (e) {
      // Exception terjadi
      print('Exception selama checkout: $e');
      throw Exception('Gagal menyelesaikan checkout: $e');
    }
  }

  // Update rental
  static Future<Sewa> updateRental(Sewa sewa) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${sewa.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(sewa.toJson()),
    );

    if (response.statusCode == 200) {
      return Sewa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memperbarui sewa');
    }
  }

  // Delete rental
  static Future<void> deleteRental(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Gagal menghapus sewa');
    }
  }
}
