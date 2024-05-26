import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/http.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'package:qualquercoisavinteconto/utils/http.dart';
import 'package:qualquercoisavinteconto/widgets/product_form_widget.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({super.key});

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProductes();
  }

  Future<void> fetchProductes() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final accessToken = authProvider.getAccessToken();

    final response = await http.get(
      Uri.parse('$apiBaseUrl/products'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (isSuccessful(response)) {
      if (response.body.isEmpty) {
        setState(() {
          products = [];
        });
        return;
      } else {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data.map((json) => Product.fromJson(json)).toList();
        });
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> deleteProduct(int id) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final accessToken = authProvider.getAccessToken();
    final response = await http.delete(
      Uri.parse('$apiBaseUrl/products/$id'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (isSuccessful(response)) {
      fetchProductes();
    } else {
      throw Exception('Failed to delete product');
    }
  }

  Future<void> editProduct(Product product) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ProductFormWidget(
          name: product.name,
          productId: product.id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text(
          "Produtos",
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
          itemCount: products.length + 1,
          itemBuilder: (ctx, i) {
            if (i == products.length) {
              return ListTile(
                title: const Text("Voltar para Home"),
                onTap: () {
                  Navigator.pushNamed(context, homeRoute);
                },
              );
            } else {
              return ListTile(
                title: Text(products[i].name),
                subtitle: Text(products[i].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editProduct(products[i]);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteProduct(products[i].id);
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const ProductFormWidget();
            },
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
