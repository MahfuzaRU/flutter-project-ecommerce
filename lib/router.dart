import 'package:ecommerceapp/screens/cart_screen.dart';
import 'package:ecommerceapp/screens/home_screen.dart';
import 'package:ecommerceapp/screens/login_screen.dart';
import 'package:ecommerceapp/screens/order_screen.dart';
import 'package:ecommerceapp/screens/place_order_screen.dart';
import 'package:ecommerceapp/screens/producr_details_screen.dart';
import 'package:ecommerceapp/screens/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(child: HomeScreen()),
  '/product/:id': (route) => MaterialPage(
          child: ProductDetailScreen(
        productId: route.pathParameters['id']!,
      )),
  '/cart': (_) => const MaterialPage(child: CartScreen()),
  '/services': (_) => const MaterialPage(child: ServicesScreen()),
  '/place-order': (_) => const MaterialPage(child: PlaceNewOrderScreen()),
  '/orders': (_) => const MaterialPage(child: OrderScreen()),
});
