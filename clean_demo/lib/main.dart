import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_module/ext.dart' as model;
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'package:interface_repository/ext.dart';
import 'package:main_module/ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  //模块注册
  await model.a_model_init();
  await model.b_model_init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final sl = GetIt.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (context) => sl.get<AuthenticationBloc>()..add(AppStarted()),
        child: GetMaterialApp(
          // defaultTransition: Transition.noTransition,
          transitionDuration: const Duration(seconds: 0),
          // fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'Demo',
          home: sl.get<AModuleSplashScreen>(),
        ));
  }
}
