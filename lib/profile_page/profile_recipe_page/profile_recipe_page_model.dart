import '/base_structure/base_util.dart';
import 'profile_recipe_page_widget.dart' show ProfileRecipePageWidget;
import 'package:flutter/material.dart';

class ProfileRecipePageModel extends BaseModel<ProfileRecipePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
