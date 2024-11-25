import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/core/widgets/error_text.dart';
import 'package:ecommerceapp/core/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getProductByIdProvider(productId)).when(
        data: (product) {
          return Scaffold(
            appBar: AppBar(
              title: Text("${product.name} Details"),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.network(product.image)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Price: ${product.price}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Text(
                            "Discount: ${product.offer ? product.offerPercetage : 0}%",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 19,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Offer Price: ${product.price * (100 - (product.offer ? product.offerPercetage : 0)) / 100}",
                      style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Name:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Brand:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          product.brand,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Stack(
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.shopping_cart),
                ),
                const Positioned(
                    child: Text(
                      "10",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    left: 0,
                    top: 0)
              ],
            ),
          );
        },
        error: (e, s) => ErrorText(text: e.toString()),
        loading: () => const Loader());
  }
}
