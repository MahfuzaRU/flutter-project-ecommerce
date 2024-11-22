import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerceapp/screens/products_page.dart';
import 'package:ecommerceapp/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    List<Icon> items = const [
      Icon(Icons.home, size: 30),
      Icon(Icons.shopping_cart, size: 30),
      Icon(Icons.favorite, size: 30),
    ];

    int currentIndex = 0;

    List<Widget> widgetsList = [const ProductsPage()];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecommerce App"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: widgetsList[currentIndex],
      ),
      drawer: const ProfileDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          onTap: (value) => setState(() => currentIndex = value),
          backgroundColor: Colors.deepOrange,
          items: items),
    );
  }
}
