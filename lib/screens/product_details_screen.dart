import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          product.name,
          style: const TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: Container(
        color: backgroundGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Price: \$${product.price}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Image.network(
                product.imageUrl,
                height: 400,
                width: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
