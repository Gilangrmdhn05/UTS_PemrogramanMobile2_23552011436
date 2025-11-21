import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class CartGridPage extends StatelessWidget {
  final List<ProductModel> products;

  const CartGridPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grid Produk")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, i) {
            return ProductCard(product: products[i]);
          },
        ),
      ),
    );
  }
}
