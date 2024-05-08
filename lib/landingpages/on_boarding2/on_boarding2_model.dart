import '/base_structure/base_util.dart';
import 'on_boarding2_widget.dart' show OnBoarding2Widget;
import 'package:flutter/material.dart';

class OnBoarding2Model extends BaseModel<OnBoarding2Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
