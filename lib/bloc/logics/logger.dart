import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/states/main.dart';
import 'dart:async';

class Logger extends SimpleBloc<AppState> {
  @override
  Future<Action> afterware(dispatcher, state, action) async{
   return action;
  }

  @override
  Future<Action> middleware(dispatcher, state, action) async {
    
    print("[ACTION RAN]: ${action.runtimeType}");

    return await Future.delayed(Duration.zero, () => action);
  }
}