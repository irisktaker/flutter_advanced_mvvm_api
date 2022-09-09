import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/data/repository/repository_impl.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/presentation/login/viewmodel/login_viewmodel.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async 
{ // app module, it's a module where we put all generic dependencies injection (di)
  
  // shared preference instance
  final sharedPref = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // app preference instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>())); // it can be like -> instance() 

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance<AppPreferences>())); //or just instance()
  Dio dio = await instance<DioFactory>().getDio();

  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
}

initLoginModule() {
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance())); // all instance
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance<LoginUseCase>()));
  }
}