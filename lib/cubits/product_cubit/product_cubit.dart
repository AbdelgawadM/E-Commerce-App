import 'package:e_commerce/cubits/product_cubit/product_state.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/store_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final StoreService storeService;
  final String category;

  ProductCubit({required this.storeService, required this.category})
    : super(ProductInitial());

  List<ProductModel> _products = [];

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      _products = await storeService.fetchProducts(category);
      emit(ProductLoaded(_products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  List<ProductModel> get products => _products;
}
