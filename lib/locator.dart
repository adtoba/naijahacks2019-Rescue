import 'package:get_it/get_it.dart';
import 'package:rescue/bloc/provider/services/auth_services.dart';
import 'package:rescue/bloc/provider/viewmodels/trustee_model.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => TrusteeModel());

}