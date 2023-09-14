import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/injector.dart';
import 'package:ecommerce_app/login/models/login_model.dart';
import 'package:ecommerce_app/login/repos/login_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepo loginRepo = locator<LoginRepo>();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<LoginRequestEvent>((event, emit) async {
      try {
        emit(LoginFetchingLoadingState());
        LoginModel user = await loginRepo.login(
            username: event.username, password: event.password);
        if (user != null && user.token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', user.token!);
          prefs.setString('userID', user.id.toString());
          emit(LoginSuccessState(user));
        } else {
          emit(LoginFetchingErrorState("Username and Password does not match"));
        }
      } catch (e) {
        emit(LoginFetchingErrorState("An error occured"));
      }
    });
  }
}
