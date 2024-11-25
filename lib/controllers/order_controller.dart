import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/controllers/cart_provider.dart';
import 'package:ecommerceapp/core/widgets/show_snackbar.dart';
import 'package:ecommerceapp/models/order_model.dart';
import 'package:ecommerceapp/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final orderControllerProvider =
    StateNotifierProvider<OrderController, bool>((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return OrderController(orderRepository);
});

final getUserOrdersProvider = StreamProvider.family((ref, String userId) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return orderRepository.getOrdersById(userId);
});

class OrderController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  final uuid = const Uuid();
  OrderController(
    OrderRepository orderRepository,
  )   : _orderRepository = orderRepository,
        super(false);

  Future<void> createOrder(BuildContext context, WidgetRef ref, String name,
      String phone, String address, String selected) async {
    state = true;
    final user = ref.read(userProvider)!;
    final products = ref.watch(cartItemsProvider);
    final total = ref.watch(cartItemsProvider.notifier).getTotalPrice();
    OrderModel order = OrderModel(
      id: uuid.v1(),
      name: name,
      phone: phone,
      address: address,
      paymentMethod: selected,
      userId: user.uid,
      status: 'pending',
      products: products,
      total: total,
      createdAt: DateTime.now(),
    );

    final res = await _orderRepository.createOrder(order);
    state = false;

    res.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, 'Order Placed Successfully');
      ref.read(cartItemsProvider.notifier).clearCart();
      Routemaster.of(context).pop();
    });
  }

  Stream<List<OrderModel>> getUserOrders(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    return _orderRepository.getOrdersById(user.uid);
  }
}
