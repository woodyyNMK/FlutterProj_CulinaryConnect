import '/base_structure/base_util.dart';
import 'authors_profile_page_widget.dart' show AuthorsProfilePageWidget;
import 'package:flutter/material.dart';

class AuthorsProfilePageModel
    extends BaseModel<AuthorsProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
