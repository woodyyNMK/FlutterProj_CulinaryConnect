import '/base_structure/base_util.dart';
import 'on_boarding3_widget.dart' show OnBoarding3Widget;
import 'package:flutter/material.dart';

class OnBoarding3Model extends BaseModel<OnBoarding3Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
