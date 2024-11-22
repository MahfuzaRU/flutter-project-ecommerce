import 'package:ecommerceapp/models/catagory_model.dart';
import 'package:ecommerceapp/repository/catagory_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catagoryControllerProvider = StateNotifierProvider((ref) {
  return CatagoryController(
      catagoryRepository: ref.watch(catagoryRepositoryProvider));
});

final getCatagoriesProvider = StreamProvider<List<CatagoryModel>>((ref) {
  final catagoryController = ref.watch(catagoryControllerProvider.notifier);
  return catagoryController.getCatagories();
});

class CatagoryController extends StateNotifier<bool> {
  final CatagoryRepository _catagoryRepository;

  CatagoryController({required CatagoryRepository catagoryRepository})
      : _catagoryRepository = catagoryRepository,
        super(false);

  Stream<List<CatagoryModel>> getCatagories() {
    return _catagoryRepository.getCatagories();
  }
}
