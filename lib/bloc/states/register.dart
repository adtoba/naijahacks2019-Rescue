import 'package:meta/meta.dart';
import 'package:rescue/bloc/methods/status.dart';

@immutable
class RegisterState {
  const RegisterState({
    @required this.emailError,
    @required this.passwordError,
    @required this.registerMessage,
    @required this.status
  });

  final String emailError;
  final String passwordError;
  final String registerMessage;
  final Status status;

  const RegisterState.initialState() 
    : status = Status.UNLOADED,
      emailError = '',
      passwordError = '',
      registerMessage = '';

  RegisterState copyWith({
    String emailError,
    String passwordError,
    String registerMessage,
    Status status
  }) {
    return RegisterState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      registerMessage: registerMessage ?? this.registerMessage,
      status: status ?? this.status
    );
  }

  @override
  String toString() => 'RegisterState_$status$registerMessage';
}