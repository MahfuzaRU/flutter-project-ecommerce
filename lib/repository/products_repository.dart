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

    return products;
  }

  Stream<List<ProductModel>> searchCommunites(String query) {
    return _products
        .where('name',
            isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
            isLessThan: query.isEmpty
                ? null
                : query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .snapshots()
        .map((events) {
      List<ProductModel> productlist = [];

      for (var doc in events.docs) {
        productlist
            .add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return productlist;
    });
  }

  Stream<ProductModel> getProductById(String id) {
    return _products.doc(id).snapshots().map(
        (event) => ProductModel.fromJson(event.data() as Map<String, dynamic>));
  }

  Stream<List<ProductModel>> getProductByCatagory(String catagory) {
    return _products.where('category', isEqualTo: catagory).snapshots().map(
        (event) => event.docs
            .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }
}
