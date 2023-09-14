part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class ProductsInitialFetchEvent extends ProductsEvent {}

class ProductDetailFetchEvent extends ProductsEvent {
  final int productId;

  ProductDetailFetchEvent({required this.productId});
}
