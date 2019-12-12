import 'package:meta/meta.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/bloc/states/login.dart';
import 'package:rescue/bloc/states/register.dart';

@immutable
class AppState {

  AppState({
    @required this.loginState,
    @required this.registerState,
    @required this.status
  });

  final LoginState loginState;
  final RegisterState registerState;
  final Status status;

  const AppState.initialState()
    : loginState = const LoginState.initialState(),
      registerState = const RegisterState.initialState(),
      status = Status.UNLOADED;

  AppState copyWith({
    LoginState loginState,
    RegisterState registerState,
    Status status
  }) {
    return AppState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      status: status ?? this.status
    );
  }

   @override
  String toString() => "AppState_$status";
}

