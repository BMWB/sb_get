import 'package:flutter/material.dart';
import 'package:interface_repository/page_repository/a_module_splash.dart';
import 'package:interface_repository/page_repository/a_module_page.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class MyModuleSplashScreen extends AModuleSplashScreen {
  @override
  Future<void> loadModuleResources() async {
    // 加载模块所需的资源
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void navigateToNextPage(BuildContext context) {
    // 跳转到下一个页面
    Get.offAll(sl.get<A_Module_Page_Service>());
  }
}

void main() {
  runApp(MaterialApp(
    home: MyModuleSplashScreen(),
  ));
}
