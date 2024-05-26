import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/models/address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'package:qualquercoisavinteconto/utils/http.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = authProvider.getAccessToken();
    final userId = authProvider.getCurrentUser()?.id ?? 0;

    final response = await http.get(
      Uri.parse('$apiBaseUrl/addresses/user/$userId'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (isSuccessful(response)) {
      if (response.body.isEmpty) {
        setState(() {
          addresses = [];
        });
        return;
      } else {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          addresses = data.map((json) => Address.fromJson(json)).toList();
        });
      }
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<void> deleteAddress(int id) async {
    final response = await http.delete(Uri.parse('$apiBaseUrl/addresses/$id'));
    if (isSuccessful(response)) {
      fetchAddresses();
    } else {
      throw Exception('Failed to delete address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Endereços",
          style: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(addresses[i].street),
            subtitle: Text(addresses[i].number),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    //todo
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteAddress(addresses[i].id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
