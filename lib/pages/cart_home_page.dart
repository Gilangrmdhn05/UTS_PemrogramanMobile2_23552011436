import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'cart_summary_page.dart';
import '../blocs/cart_cubit.dart';

class CartHomePage extends StatelessWidget {
  CartHomePage({super.key});

  final List<ProductModel> products = [
    ProductModel(id: "1", name: "Sepatu Puma", price: 200000, image: "assets/images/Sapatu.png"),
    ProductModel(id: "2", name: "Sepatu Adidas", price: 30000, image: ""),
    ProductModel(id: "3", name: "Sepatu Nike", price: 25000, image: ""),
     ProductModel(id: "6", name: "Sepatu New Basket", price: 45000, image: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SPATULANG - Toko Sepatu Gilang"),
        centerTitle: true,
        actions: [
          // Icon cart dengan badge total item
          BlocBuilder<CartCubit, List<dynamic>>(
            builder: (context, state) {
              final totalItems = context.read<CartCubit>().getTotalItems();
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartSummaryPage()),
                      );
                    },
                  ),
                  if (totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                        child: Text(
                          totalItems.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}
