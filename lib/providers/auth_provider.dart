import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/dtos/signin_request.dart';
import 'package:http/http.dart' as http;
import 'package:qualquercoisavinteconto/dtos/signin_response.dart';

class AuthProvider extends ChangeNotifier {
  String _accessToken = "";

  bool isAuthenticated() {
    return _accessToken != "";
  }

  Future<void> signIn(SignInRequestDto dto) async {
    try {
      var body = jsonEncode(dto.toJson());
      final response = await http.post(
        Uri.parse(apiBaseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final signInResponse = SignInResponseDto.fromJson(jsonResponse);
        _accessToken = signInResponse.accessToken;
        notifyListeners();
      } else {
        throw Exception('Falha ao realizar Sign In (client-side)');
      }
    } catch (e) {
      throw Exception('Falha ao realizar Sign In (server-side)');
    }
  }
}
