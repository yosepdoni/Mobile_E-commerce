import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class Product {
  final String productId;
  final String productName;
  final int stock;
  final String category;
  final String description;
  final int price;
  final String imageUrl;

  Product({
    required this.productId,
    required this.productName,
    required this.stock,
    required this.category,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product'],
      stock: int.parse(json['stok']),
      category: json['category'],
      description: json['descriptions'],
      price: int.parse(json['price']),
      imageUrl: json['img'],
    );
  }

  String get formattedPrice {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  String getImageUrl() {
    return 'web/assets/image/$imageUrl';
  }
}
