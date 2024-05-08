import '/base_structure/base_util.dart';
import 'browse_page_widget.dart' show BrowsePageWidget;
import 'package:flutter/material.dart';

class BrowsePageModel extends BaseModel<BrowsePageWidget> {
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
