import 'ext.dart';

void main() {}

//a 模块入口
@pragma('vm:entry-point')
void greetingMain() {
  a_module_main();
}

//b 模块入口
@pragma('vm:entry-point')
void feedbackMain() {
  b_module_main();
}
