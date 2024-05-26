import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'dart:convert';

import 'package:qualquercoisavinteconto/utils/http.dart';

class AddressFormWidget extends StatefulWidget {
  final String? street;
  final String? number;
  final String? city;
  final String? state;
  final String? userId;

  const AddressFormWidget({super.key, 
    this.street,
    this.number,
    this.city,
    this.state,
    this.userId,
  });

  @override
  _AddressFormWidgetState createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends State<AddressFormWidget> {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _streetController.text = widget.street ?? '';
    _numberController.text = widget.number ?? '';
    _cityController.text = widget.city ?? '';
    _stateController.text = widget.state ?? '';
  }

  Future<void> _submitForm() async {
    final String street = _streetController.text;
    final String number = _numberController.text;
    final String city = _cityController.text;
    final String state = _stateController.text;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.getCurrentUser()?.id ?? 0;
    final accessToken = authProvider.getAccessToken();

    final Map<String, dynamic> requestBody = {
      'street': street,
      'number': number,
      'city': city,
      'state': state,
      'user_id': userId,
    };

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/addresses'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (isSuccessful(response)) {
        Navigator.pushNamed(context, manageAddressRoute);
      } else {
        throw Exception('Failed to submit address');
      }
    } catch (error) {
      throw Exception('Error submitting address: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _streetController,
          decoration: const InputDecoration(labelText: 'Street'),
        ),
        TextFormField(
          controller: _numberController,
          decoration: const InputDecoration(labelText: 'Number'),
        ),
        TextFormField(
          controller: _cityController,
          decoration: const InputDecoration(labelText: 'City'),
        ),
        TextFormField(
          controller: _stateController,
          decoration: const InputDecoration(labelText: 'State'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Finalizar'),
        ),
      ],
    ),
    );
  }
}
