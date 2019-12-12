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

class RegisterBloc extends SimpleBloc<AppState> {

  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) async {
    if(action is RegisterUser) {
      await FirebaseUtils.createUser(action.email, action.password)
        .then((response) {
          if(response.user.uid != null) {
            Map<String, dynamic> userDetails = {
              'userId' : response.user.uid,
              'email' : response.user.email,
              'name' : action.name
            };
            FirebaseUtils.postUser(userDetails, response.user.uid);
            setPreference(USER_ID, response.user.uid);
            dispatcher(RegisterSuccess());
          } else {
            dispatcher(RegisterError(
              registerMessage: 'Registration failed'
            ));
          }
        });

    }

   return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    final _registerState = state.registerState;

    if(action is RegisterError) {
      state.copyWith(
        registerState: _registerState.copyWith(
          emailError: action.emailError,
          status: Status.FAILED,
          passwordError: action.passwordError,
          registerMessage: action.registerMessage
        )
      );
    } 

    if(action is RegisterSuccess) {
      state.copyWith(
        registerState: _registerState.copyWith(
          status: Status.SUCCESSFUL
        )
      );
    }

    if(action is ResetRegister) {
      state.copyWith(
        registerState: RegisterState.initialState()
      );
    }

    if(action is ChangeRegisterStatus) {
      state.copyWith(
        registerState: _registerState.copyWith(
          status: Status.UNLOADED
        )
      );
    }

    return state;
  }

  @override
  FutureOr<Action> afterware(DispatchFunction dispatcher, AppState state, Action action) {
   if(action is RegisterSuccess) {

   }
   return action;
  }
}