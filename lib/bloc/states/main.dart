import 'package:meta/meta.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/bloc/states/login.dart';

@immutable
class AppState {

  AppState({
    @required this.loginState,
    @required this.status
  });

  final LoginState loginState;
  final Status status;

  const AppState.initialState()
    : loginState = const LoginState.initialState(),
      status = Status.UNLOADED;

  AppState copyWith({
    LoginState loginState,
    Status status
  }) {
    return AppState(
      loginState: loginState ?? this.loginState,
      status: status ?? this.status
    );
  }

   @override
  String toString() => "AppState_$status";
}

