import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sewa.dart';

class ApiSewa {
  static const String apiUrl =
      'http://192.168.1.6:8000/api/sewa'; // ganti api sewa (laravel apisewaController)

  static Future<List<Sewa>> fetchRentalsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/user/$userId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((sewa) => Sewa.fromJson(sewa)).toList();
    } else {
      throw Exception('Failed to load rentals');
    }
  }

  static Future<void> createRentalFromCart(
      List<Map<String, dynamic>> sewaItems) async {
    final response = await http.post(
      Uri.parse('$apiUrl/cart'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'sewa_items': sewaItems}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create rentals');
    }
  }

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
      throw Exception('Failed to update rental');
    }
  }

  static Future<void> deleteRental(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete rental');
    }
  }
}
