import 'package:basic_module/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_module/ext.dart' as model;
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

final sl = GetIt.instance;

Future<void> main() async {
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

  //模块注册
  model.a_model_init();
  model.b_model_init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(seconds: 0),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      // home:,
    );
  }
}
