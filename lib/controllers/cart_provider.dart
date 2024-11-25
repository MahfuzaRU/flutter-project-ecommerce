import 'package:ecommerceapp/core/widgets/show_snackbar.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartItemsProvider =
    StateNotifierProvider<CartItems, Map<ProductModel, int>>((ref) {
  return CartItems();
});

class CartItems extends StateNotifier<Map<ProductModel, int>> {
  CartItems() : super({});

  void addToCart(BuildContext context, ProductModel cartItem) {
    final updatedState = {...state};

    if (updatedState.containsKey(cartItem)) {
      updatedState[cartItem] = updatedState[cartItem]! + 1;
    } else {
      updatedState[cartItem] = 1;
      showSnackBar(context, 'Added to cart');
    }
    state = updatedState;
  }

  void removeFromCart(BuildContext context, ProductModel cartItem) {
    final updatedState = {...state};
    if (updatedState.containsKey(cartItem)) {
      if (updatedState[cartItem] == 1) {
        updatedState.remove(cartItem);
        showSnackBar(context, 'Removed from cart');
      } else {
        updatedState[cartItem] = updatedState[cartItem]! - 1;
      }
      state = updatedState;
    }
  }

  void clearCart() => state = {};

  double getTotalPrice() {
    double totalPrice = 0;
    state.forEach((key, value) {
      totalPrice += (key.offer
              ? (key.price - key.price * (100 - key.offerPercetage) / 100)
              : key.price) *
          value;
    });
    return totalPrice;
  }
}
