import 'dart:async';
// import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/injector.dart';
import 'package:ecommerce_app/products/models/product_data_model.dart';
import 'package:ecommerce_app/products/repos/products_repo.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsInitialFetchEvent>(productsInitialFetchEvent);
    on<ProductDetailFetchEvent>(productDetailFetchEvent);
  }

  ProductsRepo productsRepo = locator<ProductsRepo>();
  FutureOr<void> productsInitialFetchEvent(
      ProductsInitialFetchEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsFetchingLoadingState());
    List<ProductModel> products = await productsRepo.fetchProducts();
    emit(ProductsFetchingSuccessfulState(products: products));
  }

  FutureOr<void> productDetailFetchEvent(
      ProductDetailFetchEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsFetchingLoadingState());
    Product? product = await productsRepo.fetchProductsDetail(event.productId);
    emit(ProductDetailFetchingSuccessState(product: product!));
  }
}
