import '/base_structure/base_util.dart';
import 'add_instruction_with_d_e_l_e_t_e_alert_widget.dart'
    show AddInstructionWithDELETEAlertWidget;
import 'package:flutter/material.dart';

class AddInstructionWithDELETEAlertModel
    extends BaseModel<AddInstructionWithDELETEAlertWidget> {
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
