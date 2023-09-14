part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginRequestEvent extends LoginEvent {
  final String username;
  final String password;
  LoginRequestEvent({required this.password, required this.username});
}
