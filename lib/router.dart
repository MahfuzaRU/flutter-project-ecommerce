import 'package:ecommerceapp/screens/home_screen.dart';
import 'package:ecommerceapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute =
    RouteMap(routes: {'/': (route) => const MaterialPage(child: HomeScreen())});
