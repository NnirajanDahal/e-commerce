import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/injector.dart';
import 'package:ecommerce_app/order/repos/order_repo.dart';
import 'package:meta/meta.dart';

import '../../cart/model/cart_model.dart';
import '../model/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepo orderRepo = locator<OrderRepo>();
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});

    on<OrderStoreEvent>((event, emit) async {
      try {
        emit(OrderFetchLoadingState());
        String successMessage = await orderRepo.storeOrderData(
            event.orderId, event.dateTime, event.totalAmount, event.carts);
        emit(OrderStoreSuccessState(successMessage));
      } catch (e) {
        emit(OrderFetchErrorState(e.toString()));
      }
    });

    on<OrderFetchEvent>((event, emit) async {
      emit(OrderFetchLoadingState());
      List<OrderModel> orderList = await orderRepo.fetchOrderData();
      emit(OrderFetchSuccessState(orderList));
    });
  }
}
