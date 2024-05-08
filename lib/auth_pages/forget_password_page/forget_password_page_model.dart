import '/base_structure/base_util.dart';
import 'forget_password_page_widget.dart' show ForgetPasswordPageWidget;
import 'package:flutter/material.dart';

class ForgetPasswordPageModel
    extends BaseModel<ForgetPasswordPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
