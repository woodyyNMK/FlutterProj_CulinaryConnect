import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_bottomsheet_model.dart';
export 'login_bottomsheet_model.dart';

class LoginBottomsheetWidget extends StatefulWidget {
  const LoginBottomsheetWidget({super.key});

  @override
  State<LoginBottomsheetWidget> createState() => _LoginBottomsheetWidgetState();
}

class _LoginBottomsheetWidgetState extends State<LoginBottomsheetWidget> {
  late LoginBottomsheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginBottomsheetModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.0,
      height: 579.0,
      decoration: BoxDecoration(
        color: BaseTheme.of(context).tertiary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'EMAIL',
                      style: BaseTheme.of(context).bodyMedium.override(
                            fontFamily: 'Playfair Display',
                            color: BaseTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: Container(
                    width: 327.0,
                    height: 62.0,
                    decoration: BoxDecoration(
                      color: BaseTheme.of(context).accent3,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 327.0,
                      child: TextFormField(
                        controller: _model.textController1,
                        focusNode: _model.textFieldFocusNode1,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle:
                              BaseTheme.of(context).labelMedium.override(
                                    fontFamily: 'Playfair Display',
                                    letterSpacing: 0.0,
                                  ),
                          alignLabelWithHint: true,
                          hintText: 'example@gmail.com',
                          hintStyle:
                              BaseTheme.of(context).labelMedium.override(
                                    fontFamily: 'Playfair Display',
                                    color: Color(0xFFA0A5BA),
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 14.0, 0.0, 0.0),
                        ),
                        style: BaseTheme.of(context).bodyMedium.override(
                              fontFamily: 'Playfair Display',
                              color: Color(0xFFA0A5BA),
                              letterSpacing: 0.0,
                            ),
                        validator: _model.textController1Validator
                            .asValidator(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'PASSWORD',
                      style: BaseTheme.of(context).bodyMedium.override(
                            fontFamily: 'Playfair Display',
                            color: BaseTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: Container(
                    width: 327.0,
                    height: 62.0,
                    decoration: BoxDecoration(
                      color: BaseTheme.of(context).accent3,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 327.0,
                      child: TextFormField(
                        controller: _model.textController2,
                        focusNode: _model.textFieldFocusNode2,
                        autofocus: false,
                        obscureText: !_model.passwordVisibility,
                        decoration: InputDecoration(
                          labelStyle:
                              BaseTheme.of(context).labelMedium.override(
                                    fontFamily: 'Playfair Display',
                                    letterSpacing: 0.0,
                                  ),
                          alignLabelWithHint: true,
                          hintText: '*  * * * * * * * *',
                          hintStyle:
                              BaseTheme.of(context).labelMedium.override(
                                    fontFamily: 'Playfair Display',
                                    color: Color(0xFFA0A5BA),
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 24.0, 0.0, 0.0),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => _model.passwordVisibility =
                                  !_model.passwordVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              _model.passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFFB4B9CA),
                              size: 20.0,
                            ),
                          ),
                        ),
                        style: BaseTheme.of(context).bodyMedium.override(
                              fontFamily: 'Playfair Display',
                              letterSpacing: 0.0,
                            ),
                        validator: _model.textController2Validator
                            .asValidator(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: BaseTheme.of(context).accent3,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Remember me ',
                    style: BaseTheme.of(context).bodyMedium.override(
                          fontFamily: 'Playfair Display',
                          color: Color(0xFF7E8A97),
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(96.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Forgot Password',
                    style: BaseTheme.of(context).bodyMedium.override(
                          fontFamily: 'Playfair Display',
                          color: Color(0xFFFF7622),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 29.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: 'LOG IN',
              options: FFButtonOptions(
                width: 327.0,
                height: 62.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: BaseTheme.of(context).accent1,
                textStyle: BaseTheme.of(context).titleSmall.override(
                      fontFamily: 'Playfair Display',
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                    ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 12.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Don’t have an account?',
                    style: BaseTheme.of(context).bodyMedium.override(
                          fontFamily: 'Playfair Display',
                          color: Color(0xFF646982),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(96.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Sign Up',
                    style: BaseTheme.of(context).bodyMedium.override(
                          fontFamily: 'Playfair Display',
                          color: Color(0xFFFF7622),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 27.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Or',
                    style: BaseTheme.of(context).bodyMedium.override(
                          fontFamily: 'Playfair Display',
                          color: Color(0xFF646982),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(62.0),
                  child: Image.asset(
                    'assets/images/Google.png',
                    width: 62.0,
                    height: 62.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ].divide(SizedBox(width: 30.0)),
            ),
          ),
        ],
      ),
    );
  }
}
