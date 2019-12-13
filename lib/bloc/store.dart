import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/logics/logger.dart';
import 'package:rescue/bloc/logics/login.dart';
import 'package:rescue/bloc/logics/register.dart';
import 'package:rescue/bloc/states/main.dart';


final appStore = Store<AppState>(
  initialState: AppState.initialState(),
  blocs: [
    LoginBloc(),
    RegisterBloc(),
    Logger()
  ]
);