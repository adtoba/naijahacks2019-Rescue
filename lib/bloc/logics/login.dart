import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/actions/login.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/bloc/states/login.dart';
import 'dart:async';
import 'package:rescue/bloc/states/main.dart';
import 'package:rescue/constants/preferences.dart';
import 'package:rescue/models/user.dart';
import 'package:rescue/utils/auth_utils.dart';
import 'package:rescue/utils/preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum authProblems {
  UserNotFound,
  PasswordNotValid,
  NetworkError,
  UserAlreadyExists
}

class LoginBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) async {
    if (action is LoginUser) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: action.email, password: action.password)
            .then((response) {
          if (response.user.uid != null) {
             setPreference(IS_LOGGED_IN, true);
             setPreference(USER_ID, response.user.uid);
            Map<String, dynamic> detailsMap = {
              "email": response.user.email,
              "userId": response.user.uid,
              "name": response.user.displayName
            };

            User user = User.fromMap(detailsMap);

            dispatcher(LoginSuccess());
            print('Login successful: ${user.userId}');
            print('Login successful: ${user.email}');

          } else {
            dispatcher(LoginError(loginMessage: 'An error occured'));
          }
        });
      } catch (error) {
        authProblems errorType;
        switch (error.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            dispatcher(LoginError(loginMessage: 'User not found'));
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            dispatcher(LoginError(loginMessage: 'Incorrect password'));
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occured.':
            errorType = authProblems.NetworkError;
            dispatcher(LoginError(loginMessage: 'An exception occured'));
            break;

          default:
            print('Case ${error.message} is not yet implemented');
            dispatcher(LoginError(loginMessage: 'An exception occured'));
        }
        dispatcher(LoginError(loginMessage: 'Check details and try again'));
      }
    }

    return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    final _loginState = state.loginState;

    if (action is LoginError) {
      return state.copyWith(
          loginState: _loginState.copyWith(
              emailError: action.emailError,
              passwordError: action.passwordError,
              loginMessage: action.loginMessage,
              status: Status.FAILED));
    }

    if (action is LoginSuccess) {
      return state.copyWith(
          loginState: _loginState.copyWith(status: Status.SUCCESSFUL));
    }

    if (action is ResetLogin) {
      return state.copyWith(loginState: LoginState.initialState());
    }

    if (action is ChangeLoginStatus) {
      return state.copyWith(
          loginState: _loginState.copyWith(status: Status.UNLOADED));
    }
    return state;
  }

  @override
  FutureOr<Action> afterware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is LoginSuccess) {}
    return action;
  }
}
