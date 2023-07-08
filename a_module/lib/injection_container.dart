import 'package:a_module/features/data/model/feed_model.dart';
import 'package:a_module/features/presentation/pages/feed/feed_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:a_module/core/config/db_provider.dart';
import 'package:a_module/core/config/my_shared_pref.dart';
import 'package:a_module/core/network/network_info.dart';
import 'package:a_module/features/data/client/client.dart';
import 'package:a_module/features/data/datasource/local_datasource.dart';
import 'package:a_module/features/data/datasource/remote_datasource.dart';
import 'package:a_module/features/data/repositories/repository_impl.dart';
import 'package:a_module/features/domain/repositories/repository.dart';
import 'package:a_module/features/domain/usecase/add_new_feed_post_usecase.dart';
import 'package:a_module/features/domain/usecase/get_feed_stream_usecase.dart';
import 'package:a_module/features/domain/usecase/get_feeds_use_case.dart';
import 'package:a_module/features/presentation/authentication/authentication_bloc.dart';
import 'package:a_module/features/presentation/pages/feed/feed_bloc.dart';
import 'package:a_module/features/presentation/pages/new_post/add_new_feed_post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:interface_repository/page_repository/a_module_page.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:a_module/core/config/localization.dart';
import 'package:a_module/core/utils/constants.dart';
import 'package:a_module/core/utils/routes.dart';

import 'package:a_module/features/presentation/authentication/authentication_event.dart';
import 'package:a_module/features/presentation/pages/new_post/add_new_feed_post_screen.dart';
import 'package:a_module/features/presentation/pages/splash_screen/splash_screen.dart';

import 'injection_container.dart' as di;

Future<void> a_model_init() async {
  final sl = GetIt.instance;

  await Hive.initFlutter();
  await Hive.openBox<FeedModel>(Constants.FEED_DB);

  //page
  sl.registerFactory<A_Module_Page_Service>(() => FeedScreen());

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

final sl = GetIt.instance;

Future<void> a_module_main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Hive.openBox<FeedModel>(Constants.FEED_DB);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    // this will change the brightness of the icons
    statusBarColor: Color(0xFFffcb05),
    // or any color you want
    systemNavigationBarIconBrightness:
        Brightness.dark, //navigation bar icons' color
  ));

  await di.a_model_init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => sl.get<AuthenticationBloc>()..add(AppStarted()),
      child: MaterialApp(
        title: Constants.APP_NAME,
        locale: Locale('en'),
        localizationsDelegates: [const MyLocalizationsDelegate()],
        supportedLocales: [Locale('en')],
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash_screen,
        routes: _registerRoutes(),
      ),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoutes.splash_screen: (context) => SplashScreen(),
      AppRoutes.feed_screen: (context) => BlocProvider<FeedBloc>(
            create: (context) => sl<FeedBloc>(),
            child: FeedScreen(),
          ),
      AppRoutes.add_new_post_screen: (context) =>
          BlocProvider<AddNewFeedPostBloc>(
            create: (context) => sl<AddNewFeedPostBloc>(),
            child: AddNewFeedPostScreen(),
          ),
    };
  }
}
