import 'package:flutter/material.dart';
import 'package:rescue/bloc/methods/status.dart';


@immutable
class LoginState {
  const LoginState({
    @required this.emailError,
    @required this.passwordError,
    @required this.loginMessage,
    @required this.status
  });

  final String emailError;
  final String passwordError;
  final String loginMessage;
  final Status status;

  const LoginState.initialState()
    : status = Status.UNLOADED,
      emailError = '',
      passwordError = '',
      loginMessage = '';

  
  LoginState copyWith({
    String emailError,
    String passwordError,
    String loginMessage,
    Status status
  }) {
    return LoginState(
      status: status ?? this.status,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      loginMessage: loginMessage ?? this.loginMessage

    );
  }

  @override
  String toString() => '"LoginState_$status$loginMessage';
}