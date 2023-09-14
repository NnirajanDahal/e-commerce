part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

final class ProductsInitial extends ProductsState {}

abstract class ProductActionState extends ProductsState {}

class ProductsFetchingLoadingState extends ProductsState {}

class ProductsFetchingErrorState extends ProductsState {}

class ProductsFetchingSuccessfulState extends ProductsState {
  final List<ProductModel> products;

  ProductsFetchingSuccessfulState({required this.products});
}

class ProductDetailFetchingSuccessState extends ProductsState {
  final Product product;
  ProductDetailFetchingSuccessState({required this.product});
}
