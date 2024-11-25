import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/core/type_def.dart';
import 'package:ecommerceapp/core/widgets/failure.dart';
import 'package:ecommerceapp/models/order_model.dart';
import 'package:ecommerceapp/repository/constants_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final orderRepositoryProvider =
    Provider((ref) => OrderRepository(firestore: ref.read(firestoreProvider)));

class OrderRepository {
  final FirebaseFirestore _firestore;
  OrderRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _orders => _firestore.collection('orders');

  FutureVoid createOrder(OrderModel order) async {
    try {
      final res = await _orders.add(order.toMap());
      // ignore: void_checks
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<OrderModel>> getOrdersById(String userId) {
    return _orders
        .where(
          'userId',
          isEqualTo: userId,
        )
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
