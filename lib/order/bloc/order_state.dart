part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderFetchLoadingState extends OrderState {}

final class OrderFetchErrorState extends OrderState {
  final String error;

  OrderFetchErrorState(this.error);
}

final class OrderStoreSuccessState extends OrderState {
  final String successMessage;

  OrderStoreSuccessState(this.successMessage);
}

final class OrderFetchSuccessState extends OrderState {
  final List<OrderModel> orderList;

  OrderFetchSuccessState(this.orderList);
}
