import '/base_structure/base_icon_button.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:flutter/material.dart';
import 'add_instruction_with_d_e_l_e_t_e_alert_model.dart';
export 'add_instruction_with_d_e_l_e_t_e_alert_model.dart';

class AddInstructionWithDELETEAlertWidget extends StatefulWidget {
  const AddInstructionWithDELETEAlertWidget({
    super.key,
    required this.instructionEditRef,
    required this.instructionIndex,
  });

  final String? instructionEditRef;
  final int? instructionIndex;

  @override
  State<AddInstructionWithDELETEAlertWidget> createState() =>
      _AddInstructionWithDELETEAlertWidgetState();
}

class _AddInstructionWithDELETEAlertWidgetState
    extends State<AddInstructionWithDELETEAlertWidget> {
  late AddInstructionWithDELETEAlertModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddInstructionWithDELETEAlertModel());

    _model.textController ??=
        TextEditingController(text: widget.instructionEditRef);
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: 325.0,
          height: 410.0,
          decoration: BoxDecoration(
            color: BaseTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit An Instruction Step',
                      textAlign: TextAlign.center,
                      style: BaseTheme.of(context).titleMedium.override(
                            fontFamily: 'Playfair Display',
                            color: BaseTheme.of(context).primary,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    BaseIconButton(
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 33.0,
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: BaseTheme.of(context).error,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        _model.updatePage(() {
                          FFAppState().removeFromTempInstructionAppState(
                              widget.instructionEditRef!);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: BaseTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  letterSpacing: 0.0,
                                ),
                            hintStyle: BaseTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  color: BaseTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).tertiary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            filled: true,
                            fillColor: Color(0x4BD0CDC8),
                          ),
                          style: BaseTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Playfair Display',
                                color:
                                    BaseTheme.of(context).secondaryText,
                                fontSize: 11.0,
                                letterSpacing: 0.0,
                              ),
                          maxLines: 14,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FFButtonWidget(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: 'CANCEL',
                            options: FFButtonOptions(
                              width: 114.0,
                              height: 44.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: BaseTheme.of(context)
                                  .primaryBackground,
                              textStyle: BaseTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Playfair Display',
                                    color: BaseTheme.of(context).error,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).secondary,
                              ),
                              hoverBorderSide: BorderSide(
                                color: BaseTheme.of(context).error,
                              ),
                              hoverTextColor:
                                  BaseTheme.of(context).error,
                            ),
                          ),
                        ),
                        Flexible(
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                FFAppState()
                                    .updateTempInstructionAppStateAtIndex(
                                  widget.instructionIndex!,
                                  (_) => _model.textController.text,
                                );
                              });
                              Navigator.pop(context);
                            },
                            text: 'EDIT',
                            options: FFButtonOptions(
                              width: 114.0,
                              height: 44.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: BaseTheme.of(context).primary,
                              textStyle: BaseTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Playfair Display',
                                    color: BaseTheme.of(context)
                                        .primaryText,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).secondary,
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 15.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
