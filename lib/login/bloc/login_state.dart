part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginFetchingLoadingState extends LoginState {}

class LoginFetchingErrorState extends LoginState {
  final String error;

  LoginFetchingErrorState(this.error);
}

class LoginSuccessState extends LoginState {
  final LoginModel user;

  LoginSuccessState(this.user);
}
