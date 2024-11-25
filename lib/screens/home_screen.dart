import 'package:badges/badges.dart' as badges;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerceapp/controllers/cart_provider.dart';
import 'package:ecommerceapp/screens/cart_screen.dart';
import 'package:ecommerceapp/screens/order_screen.dart';
import 'package:ecommerceapp/screens/products_page.dart';
import 'package:ecommerceapp/widgets/navigation_drawer.dart';
import 'package:ecommerceapp/widgets/search_product_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> titles = const ["Ecommerce", "Cart", "Orders"];

  int currentIndex = 0;
  List<Widget> widgetsList = [
    const ProductsPage(),
    const CartScreen(),
    const OrderScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartItemsProvider).length;

    List<Widget> items = [
      const Icon(Icons.home, size: 30),
      badges.Badge(
        badgeContent: Text(
          cartItems.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
        showBadge: cartItems > 0,
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.red,
          elevation: 0,
        ),
        child: const Icon(Icons.shopping_cart, size: 30),
      ),
      const Icon(Icons.shopping_bag, size: 30),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchProductDelegate(ref));
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
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
