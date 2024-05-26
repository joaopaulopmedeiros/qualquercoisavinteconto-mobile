import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/models/product.dart';
import 'package:qualquercoisavinteconto/providers/catalog_provider.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
    catalogProvider.fetchProducts();
    
    return Consumer<CatalogProvider>(
      builder: (ctx, catalogProvider, _) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3/2,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: catalogProvider.products.length,
          itemBuilder: (ctx, index) {
            final product = catalogProvider.products[index];
            return ProductItem(product: product);
          },
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              product.imageUrl,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
