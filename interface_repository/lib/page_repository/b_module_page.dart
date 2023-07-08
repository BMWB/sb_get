import 'package:flutter/cupertino.dart';

class BUserModel {
  final String? name;
  final int? age;

  BUserModel({this.name, this.age});
}

abstract class B_Module_Page_Service extends StatefulWidget {
  final String? title;
  final VoidCallback? onButtonPressed;
  final BUserModel? userModel;
  final Map<String, dynamic>? data;
  final List<String>? items;

  B_Module_Page_Service(
      {this.title,
      this.onButtonPressed,
      this.userModel,
      this.data,
      this.items});

  @override
  State<StatefulWidget> createState() => B_Module_Page_State();
}

class B_Module_Page_State extends State<B_Module_Page_Service> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('b module demo'),
    );
  }
}
