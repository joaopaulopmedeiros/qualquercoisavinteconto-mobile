import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/providers/catalog_provider.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      Provider.of<CatalogProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider =
        Provider.of<CatalogProvider>(context, listen: false);

    return ListView.builder(
      itemCount: catalogProvider.products.length,
      itemBuilder: (ctx, index) {
        final product = catalogProvider.products[index];
        return ListTile(
          leading: Image.network(product.imageUrl),
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
        );
      },
    );
  }
}
