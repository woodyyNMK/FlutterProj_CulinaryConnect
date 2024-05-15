import '/backend/backend.dart';
import '/base_structure/base_util.dart';
import 'browser_page_widget.dart' show BrowserPageWidget;
import 'package:flutter/material.dart';

class BrowserPageModel extends BaseModel<BrowserPageWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchRecipe widget.
  final searchRecipeKey = GlobalKey();
  FocusNode? searchRecipeFocusNode;
  TextEditingController? searchRecipeTextController;
  String? searchRecipeSelectedOption;
  String? Function(BuildContext, String?)? searchRecipeTextControllerValidator;
  List<RecipeRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    searchRecipeFocusNode?.dispose();
  }
}
