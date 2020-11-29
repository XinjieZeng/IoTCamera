import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



Future<String> createLogin(String username, String password) async {
  final http.Response response = await http.post(
    'http://192.168.254.73:5000/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  return response.body;
}

