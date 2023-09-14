import 'package:ecommerce_app/cart/ui/cart_screen.dart';
import 'package:ecommerce_app/drawer/drawer.dart';
import 'package:ecommerce_app/products/ui/products_page.dart';
import 'package:ecommerce_app/search/ui/search_screen.dart';
import 'package:ecommerce_app/order/ui/order_history_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> _pages = [ProductsPage(), CartScreen(), OrderScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ));
        }),
      ),
      drawer: DrawerScreen(),
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_edu), label: 'Order History'),
        ],
      ),
    );
  }
}
