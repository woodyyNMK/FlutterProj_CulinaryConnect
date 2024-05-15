import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:flutter/material.dart';
import 'recipe_delete_alert_model.dart';
export 'recipe_delete_alert_model.dart';

class RecipeDeleteAlertWidget extends StatefulWidget {
  const RecipeDeleteAlertWidget({super.key});

  @override
  State<RecipeDeleteAlertWidget> createState() =>
      _RecipeDeleteAlertWidgetState();
}

class _RecipeDeleteAlertWidgetState extends State<RecipeDeleteAlertWidget> {
  late RecipeDeleteAlertModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipeDeleteAlertModel());
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
          height: 130.0,
          decoration: BoxDecoration(
            color: BaseTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delete Confirmation',
                      textAlign: TextAlign.center,
                      style: BaseTheme.of(context).titleMedium.override(
                            fontFamily: 'Playfair Display',
                            color: BaseTheme.of(context).primary,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        'Are you sure you want to DELETE the recipe?',
                        style: BaseTheme.of(context).bodyMedium.override(
                              fontFamily: 'Playfair Display',
                              color: BaseTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'No, Cancel',
                          options: FFButtonOptions(
                            width: 114.0,
                            height: 44.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                BaseTheme.of(context).primaryBackground,
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
                            hoverTextColor: BaseTheme.of(context).error,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                            setState(() {
                              FFAppState().TempIngredientAppState = [];
                              FFAppState().TempInstructionAppState = [];
                            });
                            setState(() {
                              FFAppState().ASIAN = false;
                              FFAppState().ITALIAN = false;
                              FFAppState().WESTERN = false;
                              FFAppState().EUROPEAN = false;
                              FFAppState().SOUP = false;
                              FFAppState().DESSERTS = false;
                              FFAppState().TempImgAppState = [];
                            });
                            context.safePop();
                          },
                          text: 'Yes, Confirm',
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
                                  color:
                                      BaseTheme.of(context).primaryText,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
