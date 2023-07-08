import 'package:flutter/material.dart';

abstract class AModuleSplashScreen extends StatefulWidget {
  const AModuleSplashScreen({Key? key}) : super(key: key);

  @override
  _AModuleSplashScreenState createState() => _AModuleSplashScreenState();

  // 子类需要实现的方法，用于加载模块所需资源
  Future<void> loadModuleResources();

  // 子类需要实现的方法，用于跳转到下一个页面
  void navigateToNextPage(BuildContext context);
}

class _AModuleSplashScreenState extends State<AModuleSplashScreen> {
  @override
  void initState() {
    super.initState();
    loadResources();
  }

  Future<void> loadResources() async {
    try {
      await widget.loadModuleResources();
      widget.navigateToNextPage(context);
    } catch (e) {
      // 处理异常情况
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
