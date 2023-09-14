import 'package:ecommerce_app/cart/bloc/carton_bloc.dart';
import 'package:ecommerce_app/cart/repos/cart_repo.dart';
import 'package:ecommerce_app/login/bloc/login_bloc.dart';
import 'package:ecommerce_app/login/repos/login_repo.dart';
import 'package:ecommerce_app/order/bloc/order_bloc.dart';
import 'package:ecommerce_app/order/repos/order_repo.dart';
import 'package:ecommerce_app/products/bloc/products_bloc.dart';
import 'package:ecommerce_app/products/repos/products_repo.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<LoginRepo>(() => LoginRepo());
  locator.registerLazySingleton<ProductsRepo>(() => ProductsRepo());
  locator.registerLazySingleton<CartRepo>(() => CartRepo());
  locator.registerLazySingleton<OrderRepo>(() => OrderRepo());
  locator.registerLazySingleton<LoginBloc>(() => LoginBloc());
  locator.registerLazySingleton<ProductsBloc>(() => ProductsBloc());
  locator.registerLazySingleton<CartonBloc>(() => CartonBloc());
  locator.registerLazySingleton<OrderBloc>(() => OrderBloc());
}
