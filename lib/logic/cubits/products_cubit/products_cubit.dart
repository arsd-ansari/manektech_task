import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_task/data/modal/product_modal.dart';
import 'package:manektech_task/data/repository/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoadingState()) {
    fetchProducts();
  }

  ProductsRepository productsRepository = ProductsRepository();

  void fetchProducts() async {
    try {
      List<ProductModal> products = await productsRepository.fetchProducts(1);
      emit(ProductsLoadedState(products));
    } on DioError catch (ex) {
      emit(ProductsErrorState(ex.message.toString()));
    }
  }
}
