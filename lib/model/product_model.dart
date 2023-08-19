import 'package:intl/intl.dart';

final oCcy = NumberFormat("#,##0", "en_US");

//class Get
class Gets {
  String id;
  String nama;
  String stok;
  String kategori;
  String deskripsi;
  String harga;
  String image;

  Gets(
      {required this.id,
      required this.nama,
      required this.stok,
      required this.kategori,
      required this.deskripsi,
      required this.harga,
      required this.image});

  factory Gets.fromJson(Map<String, dynamic> json) {
    return Gets(
        id: json['product_id'],
        nama: json['product'],
        stok: json['stok'],
        kategori: json['category'],
        deskripsi: json['descriptions'],
        harga: json['price'],
        image: json['img']);
  }
}
// end class Get
