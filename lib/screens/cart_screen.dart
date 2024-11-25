import 'package:ecommerceapp/controllers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

final counterProvider = StateProvider<int>((ref) => 0);

class _CartScreenState extends ConsumerState<CartScreen> {
  void increment() {
    ref.read(counterProvider.notifier).update((state) => state + 1);
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(cartItemsProvider);
    final totalPrice = ref.watch(cartItemsProvider.notifier).getTotalPrice();
    if (products.isEmpty) {
      return const Center(child: Text('No products in cart'));
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products.keys.elementAt(index);
          final quantity = products.values.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.image),
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Row(
                  children: [
                    Text('Quantity: $quantity',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Text(
                      'Price: \$${product.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        ref.read(cartItemsProvider.notifier).addToCart(
                              context,
                              product,
                            );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        ref.read(cartItemsProvider.notifier).removeFromCart(
                              context,
                              product,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Total:\$ $totalPrice',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {
                  Routemaster.of(context).push('/services');
                },
                child: const Text('Place Order'))
          ],
        ),
      ),
    );
  }
}
