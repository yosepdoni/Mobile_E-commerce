import 'package:intl/intl.dart';

class Cart {
  final String cartId;
  final String userId;
  final String productId;
  final String product;
  final String category;
  final String qty;
  final String price;
  final String total;
  bool isChecked;

  Cart({
    required this.cartId,
    required this.userId,
    required this.productId,
    required this.product,
    required this.category,
    required this.qty,
    required this.price,
    required this.total,
    this.isChecked = false,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cart_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      product: json['product'],
      category: json['category'],
      qty: json['qty'],
      price: json['price'],
      total: json['total'],
    );
  }

  String getFormattedPrice() {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(int.parse(price));
  }

  String getFormattedTotal() {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(int.parse(total));
  }
}
