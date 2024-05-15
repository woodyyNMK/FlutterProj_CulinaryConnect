import '/backend/backend.dart';
import '/base_structure/base_util.dart';
import 'recipe_page_widget.dart' show RecipePageWidget;
import 'package:flutter/material.dart';

class RecipePageModel extends BaseModel<RecipePageWidget> {
  ///  Local state fields for this page.

  bool upVoteToggleValue = false;

  bool downVoteToggleValue = false;

  bool savedToggleValue = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for InstructionNReviewTAbBar widget.
  TabController? instructionNReviewTAbBarController;
  int get instructionNReviewTAbBarCurrentIndex =>
      instructionNReviewTAbBarController != null
          ? instructionNReviewTAbBarController!.index
          : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  CommentsRecord? cmtRef;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    instructionNReviewTAbBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
