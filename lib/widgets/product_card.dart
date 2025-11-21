import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../blocs/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Card height arranged so it fits well in GridView childAspectRatio ~0.68/0.75
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Bisa ditambahkan navigasi ke detail nanti
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  image: product.image.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: product.image.isEmpty
                    ? Center(
                        child: Text(
                          product.name.isNotEmpty ? product.name[0].toUpperCase() : '',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : null,
              ),

              const SizedBox(height: 10),

              // Nama
              Text(
                product.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              // Harga
              Text(
                "Rp ${product.price}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),

              const Spacer(),

              // Tombol add to cart
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<CartCubit>().addToCart(product);

                    // SnackBar kecil konfirmasi
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} ditambahkan ke keranjang'),
                        duration: const Duration(milliseconds: 900),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  label: const Text("Tambah"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
