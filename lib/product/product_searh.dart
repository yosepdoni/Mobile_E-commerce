import 'package:flutter/material.dart';
import 'package:magicomputer/product/product_detail.dart';
import 'package:magicomputer/model/product.dart';
import 'package:magicomputer/model/user.dart';

class ProductSearch extends StatefulWidget {
  final List<Product> products;
  final User user;

  const ProductSearch({Key? key, required this.products, required this.user})
      : super(key: key);

  final String imageUrl = 'web/assets/image/';

  @override
  // ignore: library_private_types_in_public_api
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  List<Product> searchResults = [];
  TextEditingController searchController = TextEditingController();
  String query = '';

  @override
  void initState() {
    super.initState();
    searchResults = widget.products;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(imageUrl),
        );
      },
    );
  }

  void navigateToDetailPage(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          product: product,
          userId:
              widget.user.userId, // Menggunakan widget.user.id sebagai userId
          key: UniqueKey(), // Menambahkan UniqueKey sebagai parameter key
        ),
      ),
    );
  }

  void performSearch() {
    if (query.isEmpty) {
      setState(() {
        searchResults = widget.products;
      });
    } else {
      final List<Product> results = widget.products
          .where((product) =>
              product.productName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              product.category
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      setState(() {
        searchResults = results;
      });
    }
  }

  void clearSearch() {
    searchController.clear();
    setState(() {
      query = '';
      searchResults = widget.products;
    });
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
        elevation: 5,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari Produk',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearSearch,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                    performSearch();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: searchResults.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final product = searchResults[index];
          final imageUrl = 'web/assets/image/${product.imageUrl}';

          return ListTile(
            onTap: () {
              navigateToDetailPage(product);
            },
            leading: GestureDetector(
              onTap: () {
                showImageDialog(imageUrl);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            title: Text(
              product.productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              product.category,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            trailing: Text(
              product.formattedPrice,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
