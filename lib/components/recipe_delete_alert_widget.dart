import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'recipe_delete_alert_model.dart';
export 'recipe_delete_alert_model.dart';

class RecipeDeleteAlertWidget extends StatefulWidget {
  const RecipeDeleteAlertWidget({
    super.key,
    required this.recipeRefToDelete,
  });

  final DocumentReference? recipeRefToDelete;

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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 325,
          height: 130,
          decoration: BoxDecoration(
            color: BaseTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
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
                            color: BaseTheme.of(context).error,
                            fontSize: 20,
                            letterSpacing: 0,
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
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Text(
                        'Are you sure to DELETE the recipe?',
                        style: BaseTheme.of(context).bodyMedium.override(
                              fontFamily: 'Playfair Display',
                              color: BaseTheme.of(context).secondaryText,
                              letterSpacing: 0,
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
                            width: 114,
                            height: 44,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color:
                                BaseTheme.of(context).primaryBackground,
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
                            hoverTextColor: BaseTheme.of(context).error,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FFButtonWidget(
                          onPressed: () async {
                            await widget.recipeRefToDelete!.delete();
                            Navigator.pop(context);

                            context.pushNamed(
                              'Home_Page',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 300),
                                ),
                              },
                            );
                          },
                          text: 'Yes, Confirm',
                          options: FFButtonOptions(
                            width: 114,
                            height: 44,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: BaseTheme.of(context).primary,
                            textStyle: BaseTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Playfair Display',
                                  color:
                                      BaseTheme.of(context).primaryText,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
