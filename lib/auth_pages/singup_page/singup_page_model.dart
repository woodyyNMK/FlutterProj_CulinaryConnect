import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'singup_page_widget.dart' show SingupPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingupPageModel extends BaseModel<SingupPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for fullname widget.
  FocusNode? fullnameFocusNode;
  TextEditingController? fullnameTextController;
  String? Function(BuildContext, String?)? fullnameTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for passwordretyped widget.
  FocusNode? passwordretypedFocusNode;
  TextEditingController? passwordretypedTextController;
  late bool passwordretypedVisibility;
  String? Function(BuildContext, String?)?
      passwordretypedTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordretypedVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    fullnameFocusNode?.dispose();
    fullnameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    passwordretypedFocusNode?.dispose();
    passwordretypedTextController?.dispose();
  }
}
