import 'dart:convert';

import 'package:ecommerce_app/login/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  Future<LoginModel> login(
      {required String username, required String password}) async {
    Map data = {'username': username, 'password': password};

    try {
      var response = await http.post(
          Uri.parse('https://dummyjson.com/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        LoginModel user = LoginModel.fromJson(responseData);
        return user;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
