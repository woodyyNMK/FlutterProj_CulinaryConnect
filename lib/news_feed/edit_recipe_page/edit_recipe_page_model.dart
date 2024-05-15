import '/base_structure/base_util.dart';
import 'edit_recipe_page_widget.dart' show EditRecipePageWidget;
import 'package:flutter/material.dart';

class EditRecipePageModel extends BaseModel<EditRecipePageWidget> {
  ///  Local state fields for this page.

  String? categoryPageStateVariable;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for RecipeNameTextField widget.
  FocusNode? recipeNameTextFieldFocusNode1;
  TextEditingController? recipeNameTextFieldTextController1;
  String? Function(BuildContext, String?)?
      recipeNameTextFieldTextController1Validator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for RecipeNameTextField widget.
  FocusNode? recipeNameTextFieldFocusNode2;
  TextEditingController? recipeNameTextFieldTextController2;
  String? Function(BuildContext, String?)?
      recipeNameTextFieldTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    recipeNameTextFieldFocusNode1?.dispose();
    recipeNameTextFieldTextController1?.dispose();

    recipeNameTextFieldFocusNode2?.dispose();
    recipeNameTextFieldTextController2?.dispose();
  }
}
