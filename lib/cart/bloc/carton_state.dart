part of 'carton_bloc.dart';

@immutable
sealed class CartonState {}

final class CartonInitial extends CartonState {}

class CartonDataFetchingLoadingState extends CartonState {}

class CartonDataFetchingErrorState extends CartonState {
  final String error;
  CartonDataFetchingErrorState(this.error);
}

class CartonDataStoreSuccessState extends CartonState {
  final String successMessage;

  CartonDataStoreSuccessState(this.successMessage);
}

class CartonDataFetchSuccessState extends CartonState {
  final List<CartModel> carts;

  CartonDataFetchSuccessState(this.carts);
}
