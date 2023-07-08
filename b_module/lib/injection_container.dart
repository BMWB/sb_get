import 'package:b_module/features/presentation/pages/new_post/add_new_feed_post_screen.dart';
import 'package:b_module/features/presentation/pages/splash_screen/my_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:interface_repository/page_repository/a_module_splash.dart';
import 'package:interface_repository/page_repository/b_module_page.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:b_module/core/config/db_provider.dart';
import 'package:b_module/core/config/my_shared_pref.dart';
import 'package:b_module/core/network/network_info.dart';
import 'package:b_module/features/data/client/client.dart';
import 'package:b_module/features/data/datasource/local_datasource.dart';
import 'package:b_module/features/data/datasource/remote_datasource.dart';
import 'package:b_module/features/data/repositories/repository_impl.dart';
import 'package:b_module/features/domain/repositories/repository.dart';
import 'package:b_module/features/domain/usecase/add_new_feed_post_usecase.dart';
import 'package:b_module/features/domain/usecase/get_feed_stream_usecase.dart';
import 'package:b_module/features/domain/usecase/get_feeds_use_case.dart';
import 'package:b_module/features/presentation/authentication/authentication_bloc.dart';
import 'package:b_module/features/presentation/pages/feed/feed_bloc.dart';
import 'package:b_module/features/presentation/pages/new_post/add_new_feed_post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> b_model_init() async {
  final sl = GetIt.instance;

  //page
  sl.registerFactory<B_Module_Page_Service>(() => AddNewFeedPostScreen());
  sl.registerFactory<AModuleSplashScreen>(() => MyModuleSplashScreen());

  // Bloc
  sl.registerFactory(() => AuthenticationBloc(
        localDataSource: sl(),
      ));

  sl.registerFactory(() => FeedBloc(
        getFeedsUseCase: sl(),
        getFeedStreamUseCase: sl(),
      ));

  sl.registerFactory(() => AddNewFeedPostBloc(
        addNewFeedPostUseCase: sl(),
      ));

  // usecases
  sl.registerLazySingleton(() => GetFeedsUseCase(sl()));
  sl.registerLazySingleton(() => GetFeedStreamUseCase(sl()));
  sl.registerLazySingleton(() => AddNewFeedPostUseCase(sl()));

  // repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  // No access to DB provider, job of LocalDataSource to choose which source
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(mySharedPref: sl(), dbProvider: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));

  // initializing dio
  final dio = Dio();
  if (kDebugMode)
    dio.interceptors.add(LogInterceptor(request: true, responseBody: true));

  // External
  final dbProvider = DBProvider();

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DBProvider>(() => dbProvider);
  sl.registerLazySingleton(() => RestClient(dio, sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
