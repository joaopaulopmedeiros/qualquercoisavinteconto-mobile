import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'dart:convert';

import 'package:qualquercoisavinteconto/utils/http.dart';

class ProductFormWidget extends StatefulWidget {
  final String? name;
  final int? productId;

  const ProductFormWidget({super.key, 
    this.name,
    this.productId,
  });

  @override
  _ProductFormWidgetState createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? '';
  }

  Future<void> _submitForm() async {
    final String name = _nameController.text;
    final int? productId = widget.productId;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final accessToken = authProvider.getAccessToken();

    final Map<String, dynamic> requestBody = {
      'name': name,
      'id': productId
    };

    try {
      final response = await callApi(accessToken, requestBody, productId);

      if (isSuccessful(response)) {
        Navigator.pushNamed(context, manageProductRoute);
      } else {
        throw Exception('Failed to submit product');
      }
    } catch (error) {
      throw Exception('Error submitting product: $error');
    }
  }

    
  Future<Response> callApi(String accessToken, Map<String, dynamic> requestBody, int? productId) async {
    
    if (productId != null && productId > 0) {
        return await http.put(
        Uri.parse('$apiBaseUrl/products/$productId'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );      
    }

    return await http.post(
        Uri.parse('$apiBaseUrl/products'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await _submitForm();
          },
          child: const Text('Finalizar'),
        ),
      ],
    ),
    );
  }
}
