import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/buku.dart';

class ApiBuku {
  static const baseUrl =
      'http://192.168.1.6:8000/api/'; // ganti api buku disini( laravel apibukuController)

  static Future<List<Buku>> fetchBooks() async {
    final response = await http.get(Uri.parse(baseUrl + 'buku'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      List<Buku> bukus = data.map((json) => Buku.fromJson(json)).toList();
      return bukus;
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<void> createBook(Buku buku) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'buku'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(buku.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create book');
    }
  }
}
