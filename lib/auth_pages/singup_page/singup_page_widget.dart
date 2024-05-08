import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'singup_page_model.dart';
export 'singup_page_model.dart';

class SingupPageWidget extends StatefulWidget {
  const SingupPageWidget({super.key});

  @override
  State<SingupPageWidget> createState() => _SingupPageWidgetState();
}

class _SingupPageWidgetState extends State<SingupPageWidget> {
  late SingupPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SingupPageModel());

    _model.fullnameTextController ??= TextEditingController();
    _model.fullnameFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.passwordretypedTextController ??= TextEditingController();
    _model.passwordretypedFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: BaseTheme.of(context).primaryBackground,
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                BaseTheme.of(context).primary,
                BaseTheme.of(context).secondary
              ],
              stops: [0, 0.75],
              begin: AlignmentDirectional(0, -1),
              end: AlignmentDirectional(0, 1),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 55, 0, 10),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('Login_Page');
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: BaseTheme.of(context).primaryBackground,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: BaseTheme.of(context).bodyMedium.override(
                            fontFamily: 'Playfair Display',
                            fontSize: 32,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 11, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Please sign up to get started',
                        textAlign: TextAlign.center,
                        style: BaseTheme.of(context).bodyMedium.override(
                              fontFamily: 'Playfair Display',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 1,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: BaseTheme.of(context).tertiary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 24, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'NAME',
                                      style: BaseTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Playfair Display',
                                            color: BaseTheme.of(context)
                                                .secondaryText,
                                            fontSize: 13,
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 8, 15, 0),
                                        child: Container(
                                          height: 62,
                                          decoration: BoxDecoration(
                                            color: BaseTheme.of(context)
                                                .accent3,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            width: 327,
                                            child: TextFormField(
                                              controller:
                                                  _model.fullnameTextController,
                                              focusNode:
                                                  _model.fullnameFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          letterSpacing: 0,
                                                        ),
                                                alignLabelWithHint: true,
                                                hintText: 'john doe',
                                                hintStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFA0A5BA),
                                                          letterSpacing: 0,
                                                        ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16, 14, 0, 0),
                                              ),
                                              style: BaseTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Playfair Display',
                                                    color: BaseTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              validator: _model
                                                  .fullnameTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 24, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'EMAIL',
                                      style: BaseTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Playfair Display',
                                            color: BaseTheme.of(context)
                                                .secondaryText,
                                            fontSize: 13,
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 8, 15, 0),
                                        child: Container(
                                          height: 62,
                                          decoration: BoxDecoration(
                                            color: BaseTheme.of(context)
                                                .accent3,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            width: 327,
                                            child: TextFormField(
                                              controller:
                                                  _model.emailTextController,
                                              focusNode: _model.emailFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          letterSpacing: 0,
                                                        ),
                                                alignLabelWithHint: true,
                                                hintText: 'example@gmail.com',
                                                hintStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFA0A5BA),
                                                          letterSpacing: 0,
                                                        ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16, 14, 0, 0),
                                              ),
                                              style: BaseTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Playfair Display',
                                                    color: BaseTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              validator: _model
                                                  .emailTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 24, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'PASSWORD',
                                      style: BaseTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Playfair Display',
                                            color: BaseTheme.of(context)
                                                .secondaryText,
                                            fontSize: 13,
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 8, 15, 0),
                                        child: Container(
                                          height: 62,
                                          decoration: BoxDecoration(
                                            color: BaseTheme.of(context)
                                                .accent3,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            width: 327,
                                            child: TextFormField(
                                              controller:
                                                  _model.passwordTextController,
                                              focusNode:
                                                  _model.passwordFocusNode,
                                              autofocus: false,
                                              obscureText:
                                                  !_model.passwordVisibility,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          letterSpacing: 0,
                                                        ),
                                                alignLabelWithHint: true,
                                                hintText: '*  * * * * * * * *',
                                                hintStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFA0A5BA),
                                                          letterSpacing: 0,
                                                        ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16, 24, 0, 0),
                                                suffixIcon: InkWell(
                                                  onTap: () => setState(
                                                    () => _model
                                                            .passwordVisibility =
                                                        !_model
                                                            .passwordVisibility,
                                                  ),
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  child: Icon(
                                                    _model.passwordVisibility
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color: Color(0xFFB4B9CA),
                                                    size: 19,
                                                  ),
                                                ),
                                              ),
                                              style: BaseTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Playfair Display',
                                                    color: BaseTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              validator: _model
                                                  .passwordTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 24, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'RE-TYPE PASSWORD',
                                      style: BaseTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Playfair Display',
                                            color: BaseTheme.of(context)
                                                .secondaryText,
                                            fontSize: 13,
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 8, 15, 0),
                                        child: Container(
                                          height: 62,
                                          decoration: BoxDecoration(
                                            color: BaseTheme.of(context)
                                                .accent3,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            width: 327,
                                            child: TextFormField(
                                              controller: _model
                                                  .passwordretypedTextController,
                                              focusNode: _model
                                                  .passwordretypedFocusNode,
                                              autofocus: false,
                                              obscureText: !_model
                                                  .passwordretypedVisibility,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          letterSpacing: 0,
                                                        ),
                                                alignLabelWithHint: true,
                                                hintText: '*  * * * * * * * *',
                                                hintStyle:
                                                    BaseTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFA0A5BA),
                                                          letterSpacing: 0,
                                                        ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16, 24, 0, 0),
                                                suffixIcon: InkWell(
                                                  onTap: () => setState(
                                                    () => _model
                                                            .passwordretypedVisibility =
                                                        !_model
                                                            .passwordretypedVisibility,
                                                  ),
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  child: Icon(
                                                    _model.passwordretypedVisibility
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color: Color(0xFFB4B9CA),
                                                    size: 19,
                                                  ),
                                                ),
                                              ),
                                              style: BaseTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Playfair Display',
                                                    color: BaseTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              validator: _model
                                                  .passwordretypedTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 29, 15, 29),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          GoRouter.of(context)
                                              .prepareAuthEvent();
                                          if (_model.passwordTextController
                                                  .text !=
                                              _model
                                                  .passwordretypedTextController
                                                  .text) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Passwords don\'t match!',
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          final user = await authManager
                                              .createAccountWithEmail(
                                            context,
                                            _model.emailTextController.text,
                                            _model.passwordTextController.text,
                                          );
                                          if (user == null) {
                                            return;
                                          }

                                          await UsersRecord.collection
                                              .doc(user.uid)
                                              .update(createUsersRecordData(
                                                displayName: _model
                                                    .fullnameTextController
                                                    .text,
                                                email: _model
                                                    .emailTextController.text,
                                              ));

                                          context.pushNamedAuth(
                                              'Login_Page', context.mounted);
                                        },
                                        text: 'SIGN UP',
                                        options: FFButtonOptions(
                                          width: 327,
                                          height: 62,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 0, 24, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: BaseTheme.of(context)
                                              .primary,
                                          textStyle:
                                              BaseTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        'Playfair Display',
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                  ),
                                          elevation: 3,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 12,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
