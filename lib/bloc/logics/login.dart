import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/actions/login.dart';
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
        await FirebaseService().loginUser(action.email, action.password)
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


}