import 'dart:convert';

import 'package:flutter_application_1/vista/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel> fetchUser(int id) async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users/$id"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return UserModel.fromJson(body);
    } else {
      throw Exception('Ha ocurrido un error ${response.statusCode}');
    }
  }
}

