import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';

class CartSummaryPage extends StatelessWidget {
  const CartSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Belanja"),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text("Keranjang masih kosong"));
          }

          final cubit = context.read<CartCubit>();

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, i) {
                    final item = cartItems[i];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0,2))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Placeholder image / initial
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                item.product.name.isNotEmpty ? item.product.name[0].toUpperCase() : '',
                                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black54),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text("Rp ${item.product.price}"),
                          const Spacer(),
                          Text("Subtotal: Rp ${item.product.price * item.quantity}", style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // minus
                              IconButton(
                                onPressed: () {
                                  cubit.updateQuantity(item.product, item.quantity - 1);
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),

                              Text(item.quantity.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                              // plus
                              IconButton(
                                onPressed: () {
                                  cubit.updateQuantity(item.product, item.quantity + 1);
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => cubit.removeFromCart(item.product),
                              child: const Text("Hapus", style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // total area
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Item:", style: TextStyle(fontSize: 16)),
                        Text("${cubit.getTotalItems()} item", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Harga:", style: TextStyle(fontSize: 16)),
                        Text("Rp ${cubit.getTotalPrice()}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // contoh aksi checkout
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Proses checkout (contoh)")));
                        },
                        child: const Text("Checkout"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
