import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<http.Response> createPost(String cod, String nombre) async {
    final url = Uri.parse("$baseUrl/posts");

    final body = jsonEncode({
      "cod": cod,
      "nombre": nombre,
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    return response;
  }
}
