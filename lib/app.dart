import 'package:flutter/material.dart';
import 'package:magicomputer/model/user.dart';
import 'package:magicomputer/dashboard.dart';
import 'package:magicomputer/product/cart.dart';
import 'package:magicomputer/user/account.dart';

class App extends StatefulWidget {
  final User user;

  const App({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 1;

  late List<Widget> _body;

  @override
  void initState() {
    super.initState();
    _body = [
      CartPage(userId: widget.user.userId),
      Dashboard(user: widget.user),
      UserAccount(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color.fromARGB(255, 84, 91, 115),
                Color.fromARGB(255, 34, 34, 34)
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Tooltip(
                message: 'Favorite',
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout),
                  color: _currentIndex == 0
                      ? Colors.blue
                      : const Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
              ),
              Tooltip(
                message: 'Account',
                child: IconButton(
                  icon: const Icon(Icons.account_circle),
                  color: _currentIndex == 2
                      ? Colors.blue
                      : const Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 42, 26, 58),
        mini: true,
        child: const Icon(Icons.home),
        onPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
    );
  }
}
