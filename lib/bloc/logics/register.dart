import 'package:firebase_auth/firebase_auth.dart';
import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/actions/login.dart';
import 'package:rescue/bloc/actions/register.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'dart:async';

import 'package:rescue/bloc/states/main.dart';
import 'package:rescue/bloc/states/register.dart';
import 'package:rescue/constants/preferences.dart';
import 'package:rescue/utils/auth_utils.dart';
import 'package:rescue/utils/preferences.dart';

enum authProblems {
  UserNotFound,
  PasswordNotValid,
  NetworkError,
  UserAlreadyExists
}

class RegisterBloc extends SimpleBloc<AppState> {
  @override
  Future<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) async {
    if (action is RegisterUser) {
      try {
        FirebaseAuth _auth = FirebaseAuth.instance;

        await _auth
            .createUserWithEmailAndPassword(
                email: action.email, password: action.password)
            .then((response) async {
          if (response.user.uid != null) {
            Map<String, dynamic> userDetails = {
              'userId': response.user.uid,
              'email': response.user.email,
              'name': action.name
            };
            dispatcher(RegisterSuccess());
          } else {
            dispatcher(RegisterError(registerMessage: 'Registration failed'));
          }
        });
      } catch (error) {
        authProblems errorType;
        switch (error.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            dispatcher(RegisterError(registerMessage: 'An exception occured:'));
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            dispatcher(RegisterError(registerMessage: 'An exception occured:'));
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occured.':
            errorType = authProblems.NetworkError;
            dispatcher(RegisterError(registerMessage: 'An exception occured:'));
            break;

          default:
            print('Case ${error.message} is not yet implemented');
            dispatcher(RegisterError(registerMessage: 'An exception occured:'));
        }
        dispatcher(RegisterError(registerMessage: 'An exception occured:'));
      }
    }

    return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    final _registerState = state.registerState;

    if (action is RegisterError) {
      return state.copyWith(
          registerState: _registerState.copyWith(
              emailError: action.emailError,
              status: Status.FAILED,
              passwordError: action.passwordError,
              registerMessage: action.registerMessage));
    }

    if (action is RegisterSuccess) {
      return state.copyWith(
          registerState: _registerState.copyWith(status: Status.SUCCESSFUL));
    }

    if (action is ResetRegister) {
      return state.copyWith(registerState: RegisterState.initialState());
    }

    if (action is ChangeRegisterStatus) {
      return state.copyWith(
          registerState: _registerState.copyWith(status: Status.UNLOADED));
    }

    return state;
  }

  // @override
  // Future<Action> afterware(
  //     DispatchFunction dispatcher, AppState state, Action action) async{
  //   if (action is RegisterSuccess) {}
  //   return action;
  // }
}
