import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:flutter/material.dart';
import 'add_instruction_alert_model.dart';
export 'add_instruction_alert_model.dart';

class AddInstructionAlertWidget extends StatefulWidget {
  const AddInstructionAlertWidget({super.key});

  @override
  State<AddInstructionAlertWidget> createState() =>
      _AddInstructionAlertWidgetState();
}

class _AddInstructionAlertWidgetState extends State<AddInstructionAlertWidget> {
  late AddInstructionAlertModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddInstructionAlertModel());

    _model.textController ??= TextEditingController();
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 325,
          height: 410,
          decoration: BoxDecoration(
            color: BaseTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Add An Instruction Step',
                      textAlign: TextAlign.center,
                      style: BaseTheme.of(context).titleMedium.override(
                            fontFamily: 'Playfair Display',
                            color: BaseTheme.of(context).primary,
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: BaseTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  letterSpacing: 0,
                                ),
                            hintText: 'Add One by one instruction...',
                            hintStyle: BaseTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  color: BaseTheme.of(context).tertiary,
                                  letterSpacing: 0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).tertiary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).primary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(14),
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
                                letterSpacing: 0,
                              ),
                          maxLines: 13,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
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
                              width: 114,
                              height: 44,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: BaseTheme.of(context)
                                  .primaryBackground,
                              textStyle: BaseTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Playfair Display',
                                    color: BaseTheme.of(context).error,
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              elevation: 2,
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
                              if (_model.textController.text != '') {
                                setState(() {
                                  FFAppState().addToTempInstructionAppState(
                                      _model.textController.text);
                                });
                                Navigator.pop(context);
                              }
                            },
                            text: 'ADD',
                            options: FFButtonOptions(
                              width: 114,
                              height: 44,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: BaseTheme.of(context).primary,
                              textStyle: BaseTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Playfair Display',
                                    color: BaseTheme.of(context)
                                        .primaryText,
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 2,
                              borderSide: BorderSide(
                                color: BaseTheme.of(context).secondary,
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 15)),
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
