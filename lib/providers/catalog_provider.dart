import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/models/product.dart';
import 'package:qualquercoisavinteconto/utils/http.dart';
import 'auth_provider.dart';

class CatalogProvider with ChangeNotifier {
  final AuthProvider authProvider;

  CatalogProvider(this.authProvider);

  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final url = Uri.parse('$apiBaseUrl/products');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authProvider.getAccessToken()}',
      },
    );

    if (isSuccessful(response)) {
      if (response.body.isEmpty) {
        _products = [];
      } else {
        final List<dynamic> data = json.decode(response.body);
        _products = data.map((product) => Product.fromJson(product)).toList();
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
