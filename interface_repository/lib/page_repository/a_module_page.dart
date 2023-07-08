import 'package:flutter/cupertino.dart';

class UserModel {
  final String? name;
  final int? age;

  UserModel({this.name, this.age});
}

abstract class A_Module_Page_Service extends StatefulWidget {
  final String? title;
  final VoidCallback? onButtonPressed;
  final UserModel? userModel;
  final Map<String, dynamic>? data;
  final List<String>? items;

  A_Module_Page_Service(
      {this.title,
      this.onButtonPressed,
      this.userModel,
      this.data,
      this.items});

  @override
  State<StatefulWidget> createState() => A_Module_Page_State();
}

class A_Module_Page_State extends State<A_Module_Page_Service> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('b module demo'),
    );
  }
}
