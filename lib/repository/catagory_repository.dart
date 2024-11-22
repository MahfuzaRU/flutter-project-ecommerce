import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/core/constants/collection_constants.dart';
import 'package:ecommerceapp/models/catagory_model.dart';
import 'package:ecommerceapp/repository/constants_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catagoryRepositoryProvider = Provider<CatagoryRepository>((ref) {
  return CatagoryRepository(firestore: ref.read(firestoreProvider));
});

class CatagoryRepository {
  final FirebaseFirestore _firestore;

  CatagoryRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _catagories =>
      _firestore.collection(FirebaseConstants.catagoryCollection);

  Stream<List<CatagoryModel>> getCatagories() {
    return _catagories.snapshots().map((event) => event.docs
        .map((e) => CatagoryModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
  }
}
