import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                increment();
              },
              child: const Icon(Icons.add)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Column(
          children: [Text(count.toString()), const Icon(Icons.shopping_cart)],
        ),
      ),
    );
  }
}
