import '/Hasnine/products.dart';


class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// Global variable to hold the cart state simply
final List<CartItem> globalCart = [];