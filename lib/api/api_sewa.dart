import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sewa.dart';

class ApiSewa {
  static const String apiUrl = 'https://utsuwp.000webhostapp.com/api/sewa';

  static Future<List<Sewa>> fetchRentalsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/user/$userId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((sewa) => Sewa.fromJson(sewa)).toList();
    } else {
      throw Exception('Failed to load rentals');
    }
  }

  static Future<Sewa> createRental(Sewa sewa) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(sewa.toJson()),
    );

    if (response.statusCode == 201) {
      return Sewa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create rental');
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
