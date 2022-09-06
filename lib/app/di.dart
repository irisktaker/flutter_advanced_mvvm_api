import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:advanced_flutter/app/app_prefs.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async 
{ // app module, it's a module where we put all generic dependencies injection (di)
  
  // shared preference instance
  final sharedPref = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // app preference instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>()));

}

Future<void> initLoginModule() async {}