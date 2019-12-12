import 'package:rebloc/rebloc.dart';
import 'package:meta/meta.dart';
import 'package:rescue/bloc/methods/status.dart';

class LoginUser extends Action {
  LoginUser({
    @required this.email,
    @required this.password
  });

  final String email;
  final String password;
}

class LoginError extends Action {

  LoginError({
     this.emailError,
     this.passwordError,
     this.loginMessage,
     this.status
  });

  final String emailError;
  final String passwordError;
  final String loginMessage;
  final Status status;
}

class LoginSuccess extends Action {
  LoginSuccess();
}

class ResetLogin extends Action {
  ResetLogin();
}

class ChangeLoginStatus extends Action {
  ChangeLoginStatus();
}