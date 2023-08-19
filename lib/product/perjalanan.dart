import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Perjalanan extends StatefulWidget {
  final int userId;
  const Perjalanan({Key? key, required this.userId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PerjalananState createState() => _PerjalananState();
}

class _PerjalananState extends State<Perjalanan> {
  List<dynamic> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String getFormattedTotalPrice(double payment) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(payment);
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'web/api/products/dalamperjalanan.php?user_id=${widget.userId}',
        ),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          setState(() {
            data = responseData['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          // ignore: avoid_print
          print(responseData['message']);
        }
      } else {
        // ignore: avoid_print
        print('Failed to load data');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
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
                Color.fromARGB(255, 43, 21, 54),
              ],
            ),
          ),
        ),
        title: const Text('Dalam Perjalanan'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : data.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Order dalam perjalanan:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final order = data[index];
                            final double payment =
                                double.parse(order['payment']);
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order ID: ${order['order_id']}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('Item: ${order['products']}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'Total: ${getFormattedTotalPrice(payment)}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Text(
                    'No data available.',
                    style: TextStyle(fontSize: 16),
                  ),
      ),
    );
  }
}
