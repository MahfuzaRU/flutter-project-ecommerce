import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/repository/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productControllerProvider = StateNotifierProvider((ref) {
  return ProductController(
      productRepository: ref.watch(productRepositoryProvider));
});

final getAllProductsProvider = StreamProvider<List<ProductModel>>((ref) {
  return ref.watch(productControllerProvider.notifier).getAllProducts();
});

final searchProductsProvider = StreamProvider.family((ref, String query) {
  return ref.watch(productControllerProvider.notifier).searchProducts(query);
});

final getProductByIdProvider = StreamProvider.family((ref, String id) {
  return ref.watch(productControllerProvider.notifier).getProductById(id);
});

final getProductByCatagoryProvider =
    StreamProvider.family((ref, String catagory) {
  return ref
      .watch(productControllerProvider.notifier)
      .getProductByCatagory(catagory);
});

//controller

class ProductController extends StateNotifier<bool> {
  final ProductRepository _productRepository;

  ProductController({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(false);

  Stream<List<ProductModel>> getAllProducts() {
    return _productRepository.getAllProducts();
  }

  Stream<List<ProductModel>> searchProducts(String query) {
    return _productRepository.searchCommunites(query);
  }

  Stream<ProductModel> getProductById(String id) {
    return _productRepository.getProductById(id);
  }

  Stream<List<ProductModel>> getProductByCatagory(String catagory) {
    return _productRepository.getProductByCatagory(catagory);
  }
}
