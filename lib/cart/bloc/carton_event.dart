part of 'carton_bloc.dart';

@immutable
abstract class CartonEvent {}

class CartonDataStoreEvent extends CartonEvent {
  final int cartId;
  final String productTitle;
  final int productPrice;
  final int productQuantity;
  final int productTotalAmount;
  final String productThumbnail;

  CartonDataStoreEvent(this.cartId, this.productTitle, this.productPrice,
      this.productQuantity, this.productTotalAmount, this.productThumbnail);
}

class CartonDataFetchEvent extends CartonEvent {}

class CartonDataRemoveEvent extends CartonEvent {
  final String productTitle;

  CartonDataRemoveEvent(this.productTitle);
}

class CartonDataConfirmEvent extends CartonEvent {}
