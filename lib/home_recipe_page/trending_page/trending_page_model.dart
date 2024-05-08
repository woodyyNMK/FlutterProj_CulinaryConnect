import '/base_structure/base_util.dart';
import 'trending_page_widget.dart' show TrendingPageWidget;
import 'package:flutter/material.dart';

class TrendingPageModel extends BaseModel<TrendingPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchRecipe widget.
  FocusNode? searchRecipeFocusNode;
  TextEditingController? searchRecipeTextController;
  String? Function(BuildContext, String?)? searchRecipeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    searchRecipeFocusNode?.dispose();
    searchRecipeTextController?.dispose();
  }
}
