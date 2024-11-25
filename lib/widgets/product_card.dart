import 'package:ecommerceapp/controllers/cart_provider.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ProductCard extends ConsumerWidget {
  ProductModel product;

  ProductCard({super.key, required this.product});
  void navigateToProductDetails(BuildContext context, String id) {
    Routemaster.of(context).push('/product/$id');
  }

  void addToCart(BuildContext context, WidgetRef ref) {
    ref.read(cartItemsProvider.notifier).addToCart(context, product);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => navigateToProductDetails(context, product.id),
              child: SizedBox(
                height: 110,
                child: Image.network(product.image),
              ),
            ),
            Text(
              product.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Price: ${product.price} TK.',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Offer: ${product.price * (100 - (product.offer ? product.offerPercetage : 0)) / 100} TK.',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () => addToCart(context, ref),
                    icon: const Icon(Icons.shopping_cart))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
