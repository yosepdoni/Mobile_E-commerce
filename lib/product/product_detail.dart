import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:magicomputer/model/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final String imageUrl = 'web/assets/image/';
  final int userId;

  const ProductDetailPage(
      {required this.product, required this.userId, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isFavorite = false;
  bool isExpanded = false;
  ValueNotifier<int> quantityNotifier = ValueNotifier<int>(1);

  void showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(widget.imageUrl),
        );
      },
    );
  }

  Future<void> _addToCart() async {
    try {
      final url = Uri.parse('web/api/products/add_cart.php');

      final response = await http.post(
        url,
        body: json.encode({
          'user_id': widget.userId,
          'product_id': widget.product.productId,
          'product': widget.product.productName,
          'category': widget.product.category,
          'qty': quantityNotifier.value,
          'price': widget.product.price,
          'total': widget.product.price * quantityNotifier.value,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          // Cart added successfully
          // ignore: avoid_print
          print('Cart added successfully. Cart ID: ${responseData['cart_id']}');

          // Close the bottom sheet
          // ignore: use_build_context_synchronously
          Navigator.pop(context);

          // Show success message
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Berhasil ditambahkan ke keranjang'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          // Failed to add cart
          if (responseData['message'] == 'Failed to add cart.') {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // Show product already exists in cart message
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Produk sudah ada dalam keranjang'),
                duration: Duration(seconds: 1),
              ),
            );
          } else {
            // ignore: avoid_print
            print('Failed to add cart. Message: ${responseData['message']}');
            // Show error message
          }
        }
      } else {
        // API request failed
        // ignore: avoid_print
        print('Failed to send request. StatusCode: ${response.statusCode}');
        // Show error message
      }
    } catch (error) {
      // Exception occurred
      // ignore: avoid_print
      print('Error: $error');
      // Show error message
    }
  }

  void showProductBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Image.network(
                              widget.imageUrl + widget.product.imageUrl,
                              height: 100,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.product.productName,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.product.category,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.product.formattedPrice,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Jumlah: ',
                                  style: TextStyle(fontSize: 15),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (quantityNotifier.value > 1) {
                                        quantityNotifier.value--;
                                      }
                                    });
                                  },
                                ),
                                ValueListenableBuilder<int>(
                                  valueListenable: quantityNotifier,
                                  builder: (context, value, _) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 15),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      quantityNotifier.value++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _addToCart,
                              child: const Text('Tambahkan ke Keranjang'),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total: ${NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(widget.product.price * quantityNotifier.value)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
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
        title: const Text('Detail Product'),
        // actions: [
        //   // Text('User ID: ${widget.userId.toString()}'),
        //   IconButton(
        //     icon: const Icon(Icons.shopping_cart),
        //     onPressed: () {
        //       showProductBottomSheet(context);
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.imageUrl + widget.product.imageUrl,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${widget.product.category}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.formattedPrice,
                    style: const TextStyle(fontSize: 18),
                  ),
                  // const SizedBox(height: 8),
                  // Container(
                  //   color: const Color.fromARGB(29, 20, 16, 4),
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //         icon: Icon(
                  //           isFavorite ? Icons.favorite : Icons.favorite_border,
                  //           color: isFavorite ? Colors.red : null,
                  //         ),
                  //         onPressed: () {
                  //           setState(() {
                  //             isFavorite = !isFavorite;
                  //           });
                  //         },
                  //       ),
                  //       const SizedBox(width: 4),
                  //       const Text(
                  //         'Favorite',
                  //         style: TextStyle(fontSize: 16),
                  //       ),
                  //       const Spacer(),
                  //       IconButton(
                  //         icon: const Icon(Icons.share),
                  //         onPressed: () {
                  //           // Perform action when the share icon is pressed
                  //           // For example, share the product link via other platforms
                  //         },
                  //       ),
                  //       IconButton(
                  //         icon: const Icon(Icons.forward_to_inbox),
                  //         onPressed: () {
                  //           // Perform action when the forward icon is pressed
                  //           // For example, navigate to another page or display related content
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const Divider(
                    color: Colors.black, // Warna garis
                    thickness: 1.0, // Ketebalan garis
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  AnimatedCrossFade(
                    firstChild: Text(
                      widget.product.description,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    secondChild: Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'Less' : 'Read More',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  showProductBottomSheet(context);
                  // Aksi yang ingin kamu lakukan ketika tombol "Masukan Keranjang" ditekan
                  // Misalnya, menambahkan produk ke keranjang
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  size: 15,
                ),
                label: const Text(
                  'Masukan Keranjang',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
                ),
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.green,
                ),
              ),
            ),
            // const SizedBox(width: 2),
            // Expanded(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Aksi yang ingin kamu lakukan ketika tombol "Beli Sekarang" ditekan
            //       // Misalnya, menambahkan produk ke keranjang belanja atau menampilkan dialog pembayaran
            //     },
            //     style: ElevatedButton.styleFrom(
            //       // ignore: deprecated_member_use
            //       primary: Colors.orange,
            //     ),
            //     child: const Text(
            //       'Beli Sekarang',
            //       style: TextStyle(fontSize: 12),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
