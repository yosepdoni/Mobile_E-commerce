import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magicomputer/model/cart.dart';
import 'package:magicomputer/product/payment.dart';

class CartPage extends StatefulWidget {
  final int userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    final url = 'website/api/products/cart.php?user_id=${widget.userId}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Cart> loadedItems = [];
      for (var item in data['data']) {
        loadedItems.add(Cart.fromJson(item));
      }
      setState(() {
        cartItems = loadedItems;
      });
    }
  }

  void toggleCheckbox(int index) {
    setState(() {
      cartItems[index].isChecked = !cartItems[index].isChecked;
    });
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in cartItems) {
      if (item.isChecked) {
        totalPrice += int.parse(item.total);
      }
    }
    return totalPrice;
  }

  String getFormattedTotalPrice() {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(calculateTotalPrice());
  }

  Future<void> deleteCartItem(String cartId) async {
    final url = 'web/api/products/delete_cart.php?cart_id=$cartId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        cartItems.removeWhere((cart) => cart.cartId == cartId);
      });
    } else {
      // ignore: avoid_print
      print('Failed to delete cart item');
    }
  }

  void clearCart() async {
    List<Cart> itemsToDelete =
        cartItems.where((cart) => cart.isChecked).toList();

    for (var item in itemsToDelete) {
      await deleteCartItem(item.cartId);
    }
  }

  void goToPaymentPage(BuildContext context) {
    List<Cart> checkedItems =
        cartItems.where((cart) => cart.isChecked).toList();

    if (checkedItems.isEmpty) {
      // ignore: avoid_print
      print('No items selected for checkout');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          checkedItems: checkedItems,
          onPaymentConfirmed: () {
            clearCart();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromARGB(255, 19, 36, 60),
                Color.fromARGB(255, 43, 21, 54)
              ],
            ),
          ),
        ),
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed:
                cartItems.any((cart) => cart.isChecked) ? clearCart : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text('No items in cart'),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item.product),
                        subtitle: Row(
                          children: [
                            Text('Qty: ${item.qty}'),
                            const SizedBox(width: 5),
                            Text('Price: ${item.getFormattedPrice()}'),
                          ],
                        ),
                        trailing: Checkbox(
                          value: item.isChecked,
                          onChanged: (value) => toggleCheckbox(index),
                        ),
                        onTap: () => toggleCheckbox(index),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  getFormattedTotalPrice(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(),
              // ignore: sized_box_for_whitespace
              Container(
                width: 120,
                child: ElevatedButton(
                  onPressed: cartItems.any((cart) => cart.isChecked)
                      ? () => goToPaymentPage(context)
                      : null,
                  child: const Text('Checkout'),
                ),
              ),
              const SizedBox(width: 10),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
