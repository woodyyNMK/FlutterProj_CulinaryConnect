import '/auth/base_auth_user_provider.dart';
import '/backend/backend.dart';
import '/components/log_in_required_widget.dart';
import '/base_structure/icon_button.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'browse_page_widget.dart' show BrowsePageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
