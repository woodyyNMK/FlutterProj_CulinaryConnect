import '/base_structure/base_util.dart';
import 'on_boarding1_widget.dart' show OnBoarding1Widget;
import 'package:flutter/material.dart';

class OnBoarding1Model extends BaseModel<OnBoarding1Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
