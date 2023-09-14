part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderStoreEvent extends OrderEvent {
  final int orderId;
  final String dateTime;
  final int totalAmount;
  final List<CartModel> carts;

  OrderStoreEvent(this.orderId, this.dateTime, this.totalAmount, this.carts);
}

class OrderFetchEvent extends OrderEvent {}
