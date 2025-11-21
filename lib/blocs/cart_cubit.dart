import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

/// CartItem menyimpan product + quantity
class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}

/// State type: List<CartItem>
class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  /// Tambah product ke keranjang. Jika sudah ada -> increment qty
  void addToCart(ProductModel product) {
    final idx = state.indexWhere((it) => it.product.id == product.id);
    if (idx != -1) {
      state[idx].quantity += 1;
      emit(List.from(state));
    } else {
      final newList = List<CartItem>.from(state)
        ..add(CartItem(product: product, quantity: 1));
      emit(newList);
    }
  }

  /// Hapus product dari keranjang sepenuhnya
  void removeFromCart(ProductModel product) {
    final newList = state.where((it) => it.product.id != product.id).toList();
    emit(newList);
  }

  /// Update quantity product. Jika qty <= 0 -> hapus item.
  void updateQuantity(ProductModel product, int qty) {
    final idx = state.indexWhere((it) => it.product.id == product.id);
    if (idx == -1) return;
    if (qty <= 0) {
      removeFromCart(product);
      return;
    }
    state[idx].quantity = qty;
    emit(List.from(state));
  }

  /// Ambil total unit (sum qty)
  int getTotalItems() {
    return state.fold(0, (t, it) => t + it.quantity);
  }

  /// Ambil total harga
  int getTotalPrice() {
    return state.fold(0, (t, it) => t + (it.product.price * it.quantity));
  }

  /// Untuk keperluan debugging / testing: kosongkan keranjang
  void clearCart() {
    emit([]);
  }
}
