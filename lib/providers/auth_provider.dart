import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/dtos/signin_request.dart';
import 'package:http/http.dart' as http;
import 'package:qualquercoisavinteconto/dtos/auth_response.dart';
import 'package:qualquercoisavinteconto/dtos/signup_request.dart';
import 'package:qualquercoisavinteconto/models/user.dart';

class AuthProvider extends ChangeNotifier {
  String _accessToken = "";
  User? _currentUser;

  bool isAuthenticated() => _accessToken.isNotEmpty;
  String getAccessToken() => _accessToken;
  User? getCurrentUser() => _currentUser;

  Future<void> signIn(SignInRequestDto dto) async {
    try {
      var body = jsonEncode(dto.toJson());
      final response = await http.post(
        Uri.parse('$apiBaseUrl/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final authResponse = AuthResponseDto.fromJson(jsonResponse);
        _accessToken = authResponse.accessToken;
        _currentUser = authResponse.identity;
        notifyListeners();
      } else {
        throw Exception('Falha ao realizar Sign In (client-side)');
      }
    } catch (e) {
      throw Exception('Falha ao realizar Sign In (server-side)');
    }
  }

  Future<void> signUp(SignUpRequestDto dto) async {
    try {
      var body = jsonEncode(dto.toJson());
      final response = await http.post(
        Uri.parse('$apiBaseUrl/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final authResponse = AuthResponseDto.fromJson(jsonResponse);
        _accessToken = authResponse.accessToken;
        _currentUser = authResponse.identity;
        notifyListeners();
      } else {
        throw Exception('Falha ao realizar Sign Up (client-side)');
      }
    } catch (e) {
      throw Exception('Falha ao realizar Sign Up (server-side)');
    }
  }

  void signOut() {
    _accessToken = "";
    _currentUser = null;
    notifyListeners();
  }
}
