import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hello_app/Login.dart';



Future<String> createLogin(String username, String password) async {
  final response =  await http.post(
    'http://192.168.254.73:5000/login?',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password
    }),
  );

  if (response.body == "invalid") {
    throw Exception('failed to log in');
  }

  return "sucessful";
}

