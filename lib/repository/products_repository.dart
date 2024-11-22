import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/core/constants/collection_constants.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/repository/constants_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(firestore: ref.read(firestoreProvider));
});

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productsCollection);

  Stream<List<ProductModel>> getAllProducts() {
    final products = _products.snapshots().map((event) => event.docs
        .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
    log('Products: $products');
    return products;
  }
}
