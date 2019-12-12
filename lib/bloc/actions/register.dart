import 'package:meta/meta.dart';
import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/methods/status.dart';


class RegisterUser extends Action {
  const RegisterUser({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;
}

class RegisterError extends Action {
  const RegisterError({
    this.emailError,
    this.passwordError,
    this.registerMessage,
    this.status
  });

  final String emailError;
  final String passwordError;
  final String registerMessage;
  final Status status;
}

class RegisterSuccess extends Action {
  RegisterSuccess();
}

class ResetRegister extends Action {
  ResetRegister();
}

class ChangeRegisterStatus extends Action {
  ChangeRegisterStatus();
}