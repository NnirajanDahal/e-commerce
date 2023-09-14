import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/cart/model/cart_model.dart';
import 'package:ecommerce_app/cart/repos/cart_repo.dart';
import 'package:ecommerce_app/injector.dart';
import 'package:meta/meta.dart';

part 'carton_event.dart';
part 'carton_state.dart';

class CartonBloc extends Bloc<CartonEvent, CartonState> {
  CartRepo cartRepo = locator<CartRepo>();
  CartonBloc() : super(CartonInitial()) {
    on<CartonEvent>((event, emit) {});

    on<CartonDataStoreEvent>((event, emit) async {
      try {
        emit(CartonDataFetchingLoadingState());
        String successMessage = await cartRepo.storeCartData(
            event.cartId,
            event.productTitle,
            event.productPrice,
            event.productQuantity,
            event.productTotalAmount,
            event.productThumbnail);
        emit(CartonDataStoreSuccessState(successMessage));
      } catch (e) {
        emit(CartonDataFetchingErrorState(e.toString()));
      }
    });

    on<CartonDataFetchEvent>((event, emit) async {
      emit(CartonDataFetchingLoadingState());
      List<CartModel> carts = await cartRepo.fetchCartData();
      emit(CartonDataFetchSuccessState(carts));
    });

    on<CartonDataRemoveEvent>((event, emit) async {
      emit(CartonDataFetchingLoadingState());
      List<CartModel> carts = await cartRepo.deleteCartData(event.productTitle);
      emit(CartonDataFetchSuccessState(carts));
    });

    on<CartonDataConfirmEvent>((event, emit) async {
      emit(CartonDataFetchingLoadingState());
      List<CartModel> carts = await cartRepo.confirmCartData();
      emit(CartonDataFetchSuccessState(carts));
    });
  }
}
