import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productControllerProvider = StateNotifierProvider((ref) {
  return ProductController(
      productRepository: ref.watch(productRepositoryProvider));
});

final getAllProductsProvider = StreamProvider<List<ProductModel>>((ref) {
  return ref.watch(productControllerProvider.notifier).getCatagories();
});

class ProductController extends StateNotifier<bool> {
  final ProductRepository _productRepository;

  ProductController({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(false);

  Stream<List<ProductModel>> getCatagories() {
    return _productRepository.getAllProducts();
  }
}
