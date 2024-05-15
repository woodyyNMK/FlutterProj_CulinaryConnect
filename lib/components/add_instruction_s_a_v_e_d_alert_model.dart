import '/base_structure/base_util.dart';
import 'add_instruction_s_a_v_e_d_alert_widget.dart'
    show AddInstructionSAVEDAlertWidget;
import 'package:flutter/material.dart';

class AddInstructionSAVEDAlertModel
    extends BaseModel<AddInstructionSAVEDAlertWidget> {
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
