import '/base_structure/base_util.dart';
import 'add_instruction_alert_widget.dart' show AddInstructionAlertWidget;
import 'package:flutter/material.dart';

class AddInstructionAlertModel
    extends BaseModel<AddInstructionAlertWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
