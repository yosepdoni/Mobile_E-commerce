import 'package:flutter/material.dart';
import 'package:magicomputer/model/user.dart';
import 'package:magicomputer/product/dikirim.dart';
import 'package:magicomputer/product/perjalanan.dart';
// import 'package:magicomputer/user/account_setting.dart';
import 'package:magicomputer/product/cart.dart';
import 'package:magicomputer/product/dikemas.dart';
import 'package:magicomputer/auth/login.dart';

class UserAccount extends StatefulWidget {
  final User user;

  const UserAccount({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserAccountState createState() => _UserAccountState();
}

void _logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}

class _UserAccountState extends State<UserAccount> {
  void navigateToDikemas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dikemas(userId: widget.user.userId),
      ),
    );
  }

  void navigateToPerjalanan() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Perjalanan(userId: widget.user.userId),
      ),
    );
  }

  void navigateToDikirim() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dikirim(userId: widget.user.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                      Color.fromARGB(255, 19, 36, 60),
                      Color.fromARGB(255, 43, 21, 54)
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               CartPage(userId: widget.user.userId)),
                    //     );
                    //   },
                    //   icon: const Icon(Icons.shopping_cart),
                    //   color: Colors.white,
                    // ),
                    IconButton(
                      // onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AccountSetting()),
                      //   );
                      // },
                      onPressed: () {
                        _logout(context); // Panggil metode logout
                      },
                      icon: const Icon(Icons.logout_outlined),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                      Color.fromARGB(255, 19, 36, 60),
                      Color.fromARGB(255, 43, 21, 54)
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.network(
                          "https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png",
                          height: 60,
                          width: 60,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.user.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.user.email,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromARGB(217, 232, 229, 229),
                ),
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                        ),
                        Text(
                          '  Pesanan saya',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Lihat Riwayat Pesanan >",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  IconData icon;
                  String statusText;
                  if (index == 0) {
                    icon = Icons.check_circle_outline;
                    statusText = "Produk Dikirim";
                  } else if (index == 1) {
                    icon = Icons.directions_car_outlined;
                    statusText = "Dalam Perjalanan";
                  } else {
                    icon = Icons.card_giftcard;
                    statusText = "Sedang Dikemas";
                  }

                  return GestureDetector(
                    onTap: () {
                      if (index == 2) {
                        navigateToDikemas();
                      } else if (index == 1) {
                        navigateToPerjalanan();
                      } else if (index == 0) {
                        navigateToDikirim();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(217, 232, 229, 229),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            size: 40,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            statusText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
