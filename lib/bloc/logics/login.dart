import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/actions/login.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/bloc/states/login.dart';
import 'dart:async';
import 'package:rescue/bloc/states/main.dart';
import 'package:rescue/constants/preferences.dart';
import 'package:rescue/utils/auth_utils.dart';
import 'package:rescue/utils/preferences.dart';


class LoginBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) async {
    if(action is LoginUser) {
      try {
        await FirebaseUtils.loginUser(action.email, action.password)
          .then((response) {
            if(response.user.uid != null) {
              setPreference(USER_ID, response.user.uid);
              setPreference(IS_LOGGED_IN, true);
              dispatcher(LoginSuccess());

            } else {
              dispatcher(LoginError(
                loginMessage: 'Login not successful'
              ));
            }
          }); 


      } catch(e) {
        print(e);
      }
    }

    return action;  
  }

  @override
  AppState reducer(AppState state, Action action) {
   final _loginState = state.loginState;

   if(action is LoginError) {
     state.copyWith(
       loginState: _loginState.copyWith(
         emailError: action.emailError,
         passwordError: action.passwordError,
         loginMessage: action.loginMessage,
         status: Status.FAILED
       )
     );
   }

   if(action is LoginSuccess) {
     state.copyWith(
       loginState: _loginState.copyWith(
         status: Status.SUCCESSFUL
       )
     );
   }

   if(action is ResetLogin) {
     state.copyWith(
       loginState: LoginState.initialState()
     );
   }

   if(action is ChangeLoginStatus) {
     state.copyWith(
       loginState: _loginState.copyWith(
         status: Status.UNLOADED
       )
     );
   }
    return state;
  }


  @override
  FutureOr<Action> afterware(DispatchFunction dispatcher, AppState state, Action action) {
    if(action is LoginSuccess) {

    }
    return action;
  }


}