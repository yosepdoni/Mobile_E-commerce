import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:magicomputer/model/cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  final List<Cart> checkedItems;
  final VoidCallback onPaymentConfirmed;

  const PaymentPage({
    Key? key,
    required this.checkedItems,
    required this.onPaymentConfirmed,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _pickedImageFileName;
  Uint8List? _pickedImageBytes;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  bool _isLoading = false;
  bool _isImageSelected() {
    return _pickedImageBytes != null;
  }

  int calculateTotalPayment() {
    int totalPayment = 0;
    for (var item in widget.checkedItems) {
      totalPayment += int.parse(item.total);
    }
    return totalPayment;
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  Future<String> uploadImageToServer(
      Uint8List imageBytes, String fileName) async {
    String apiUrl = 'web/api/products/upload.php';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: fileName, // Use the provided fileName as the filename
      ),
    );

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // The image was uploaded successfully, and the server returned a response.
        // You can parse the response and get any message from the server if needed.
        String responseString = await response.stream.bytesToString();
        // Assuming the server returns a message in the response
        Map<String, dynamic> responseData = json.decode(responseString);
        String message = responseData['message'];
        // ignore: avoid_print
        print(message);

        // Assuming the server returns the image URL in the response
        String imageUrl = responseData['url'];
        return imageUrl;
      } else {
        // Something went wrong with the image upload.
        // You can handle the error here as needed.

        // ignore: avoid_print
        print('Image upload failed with status code ${response.statusCode}');
        return '';
      }
    } catch (e) {
      // An error occurred during the image upload.
      // handle the error here as needed.
      // ignore: avoid_print
      print('Image upload failed: $e');
      return '';
    }
  }

  void _copyAccountNumberToClipboard(String accountNumber) {
    Clipboard.setData(ClipboardData(text: accountNumber));
    // Tambahkan pemberitahuan jika ingin memberi tahu pengguna bahwa nomor rekening telah disalin.
    // ignore: prefer_const_constructors
    final snackBar = SnackBar(content: Text('Nomor rekening telah disalin.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> confirmPayment() async {
    setState(() {
      _isLoading = true;
    });
    int totalPayment = calculateTotalPayment();

    String selectedProductsString = widget.checkedItems
        .map((cart) =>
            '${cart.product}, ${cart.qty}x ${cart.getFormattedPrice()}')
        .join(', ');

    // ignore: unused_local_variable
    String imageUrl = '';
    if (_pickedImageBytes != null) {
      imageUrl = await uploadImageToServer(
        _pickedImageBytes!,
        _pickedImageFileName!,
        // Pass the generated imageName to the uploadImageToServer function
      );
    }

    Map<String, dynamic> paymentData = {
      'user_id': widget.checkedItems.first.userId,
      'products': selectedProductsString,
      'payment': totalPayment.toString(),
      'bukti_pay':
          _pickedImageFileName, // Set the image name or URL here based on the condition.
      'tgl': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'status_kirim': 'dikemas',
    };

    // Convert paymentData to JSON string
    String jsonData = json.encode(paymentData);

    const url = 'web/api/products/add_orders.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // ignore: avoid_print
      print('Payment response: $data');

      if (data['success']) {
        // Checkout success
        // ignore: avoid_print
        print('Checkout success');
        // ignore: avoid_print
        print('Image Filename: $_pickedImageFileName');

        setState(() {
          // Remove checked items from the cart
        });

        // Show the success popup
      } else {
        // Checkout failed
        // ignore: avoid_print
        print('Failed to checkout');
        // ignore: avoid_print
        print('Image Filename: $_pickedImageFileName');
      }
      widget.onPaymentConfirmed();
    } else {
      // Failed to send checkout request
      // ignore: avoid_print
      print('Failed to send checkout request');
    }
  }

  Future<void> _pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (!kIsWeb) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        var imageBytes = await image.readAsBytes();
        setState(() {
          webImage = imageBytes;
          _pickedImage = null; // Set _pickedImage to null for web
          _pickedImageBytes = imageBytes;
          _pickedImageFileName = image.name; // Store the file name from XFile
        });
      }
    } else {
      // ignore: avoid_print
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPayment = calculateTotalPayment();

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
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'Payment Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('Nama: Magicomputer'),
                  const Text('Bank: BCA'),
                  const Text('Nomor Rekening: 78578347'),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _copyAccountNumberToClipboard('78578347');
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.content_copy,
                                size: 18,
                                color: Colors
                                    .blue, // Warna ikon "Copy to Clipboard"
                              ),
                              SizedBox(width: 5), // Jarak antara ikon dan teks
                              Text(
                                'Copy to Clipboard',
                                style: TextStyle(
                                  color: Colors
                                      .blue, // Warna teks "Copy to Clipboard"
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Total Payment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatCurrency(totalPayment),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Items:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.checkedItems.map((cart) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Product: ${cart.product}'),
                            Text('Quantity: ${cart.qty}'),
                            Text('Price: ${cart.getFormattedPrice()}'),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: _pickedImageBytes != null
                        ? kIsWeb
                            ? Image.memory(
                                _pickedImageBytes!,
                                fit: BoxFit.contain,
                                height: 250,
                              )
                            : FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  height: 250,
                                  child: Image.file(_pickedImage!),
                                ),
                              )
                        : SizedBox(
                            height:
                                50, // Set the desired height for the TextButton
                          ),
                  ),
                  Text(_pickedImageFileName ?? 'No image selected'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text('Choose from Gallery'),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        // ... (existing code)

                        // Wrap the "Confirm Payment" button with a Stack
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _isImageSelected() && !_isLoading
                                  ? confirmPayment
                                  : null,
                              // Tombol akan diaktifkan jika gambar sudah dipilih (_isImageSelected() == true)
                              // dan tidak dalam keadaan loading (_isLoading == false)
                              child: const Text('Confirm Payment'),
                            ),

                            // Show the loading indicator when isLoading is true
                            Visibility(
                              visible: _isLoading,
                              child: const CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
