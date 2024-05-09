import '/auth/firebase_auth/auth_util.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:flutter/material.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        context.pushNamed('Home_Page');
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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Log In',
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Please sign in to your  account',
                            textAlign: TextAlign.center,
                            style: BaseTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: BaseTheme.of(context).tertiary,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            alignment: AlignmentDirectional(0, 1),
                            child: Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                                color:
                                                    BaseTheme.of(context)
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    25, 8, 25, 0),
                                            child: Container(
                                              height: 62,
                                              decoration: BoxDecoration(
                                                color:
                                                    BaseTheme.of(context)
                                                        .accent3,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                width: 327,
                                                child: TextFormField(
                                                  controller: _model
                                                      .emailTextController,
                                                  focusNode:
                                                      _model.emailFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelStyle:
                                                        BaseTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Playfair Display',
                                                              letterSpacing: 0,
                                                            ),
                                                    alignLabelWithHint: true,
                                                    hintText:
                                                        'example@gmail.com',
                                                    hintStyle: BaseTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFA0A5BA),
                                                          letterSpacing: 0,
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 14, 0, 0),
                                                  ),
                                                  style: BaseTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Playfair Display',
                                                        color:
                                                            BaseTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                color:
                                                    BaseTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 13,
                                                letterSpacing: 0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25, 0, 25, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Opacity(
                                            opacity: 0.5,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Container(
                                                width: 327,
                                                height: 62,
                                                decoration: BoxDecoration(
                                                  color: BaseTheme.of(
                                                          context)
                                                      .accent3,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                  width: 327,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .passwordTextController,
                                                    focusNode: _model
                                                        .passwordFocusNode,
                                                    autofocus: false,
                                                    obscureText: !_model
                                                        .passwordVisibility,
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          BaseTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Playfair Display',
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                      alignLabelWithHint: true,
                                                      hintText:
                                                          '*  * * * * * * * *',
                                                      hintStyle:
                                                          BaseTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Playfair Display',
                                                                color: Color(
                                                                    0xFFA0A5BA),
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 24, 0, 0),
                                                      suffixIcon: InkWell(
                                                        onTap: () => setState(
                                                          () => _model
                                                                  .passwordVisibility =
                                                              !_model
                                                                  .passwordVisibility,
                                                        ),
                                                        focusNode: FocusNode(
                                                            skipTraversal:
                                                                true),
                                                        child: Icon(
                                                          _model.passwordVisibility
                                                              ? Icons
                                                                  .visibility_outlined
                                                              : Icons
                                                                  .visibility_off_outlined,
                                                          color:
                                                              Color(0xFFB4B9CA),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    style: BaseTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color: BaseTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 24, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            unselectedWidgetColor:
                                                BaseTheme.of(context)
                                                    .secondaryText,
                                          ),
                                          child: Checkbox(
                                            value: _model.checkboxValue ??=
                                                true,
                                            onChanged: (newValue) async {
                                              setState(() => _model
                                                  .checkboxValue = newValue!);
                                            },
                                            side: BorderSide(
                                              width: 2,
                                              color:
                                                  BaseTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            activeColor:
                                                BaseTheme.of(context)
                                                    .primary,
                                            checkColor:
                                                BaseTheme.of(context)
                                                    .info,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Text(
                                            'Remember me ',
                                            style: BaseTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      'Playfair Display',
                                                  color: Color(0xFF7E8A97),
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 25, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'ForgetPassword_Page',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    'Forgot Password',
                                                    style: BaseTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFFF7622),
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25, 0, 25, 0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              GoRouter.of(context)
                                                  .prepareAuthEvent();

                                              final user = await authManager
                                                  .signInWithEmail(
                                                context,
                                                _model.emailTextController.text,
                                                _model.passwordTextController
                                                    .text,
                                              );
                                              if (user == null) {
                                                return;
                                              }

                                              context.goNamedAuth(
                                                  'Home_Page', context.mounted);
                                            },
                                            text: 'LOG IN',
                                            options: FFButtonOptions(
                                              width: 327,
                                              height: 62,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 0, 24, 0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              color:
                                                  BaseTheme.of(context)
                                                      .accent1,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 24, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: Text(
                                            'Don’t have an account?',
                                            style: BaseTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      'Playfair Display',
                                                  color: Color(0xFF646982),
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 25, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'Singup_Page',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    'Sign Up',
                                                    style: BaseTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Playfair Display',
                                                          color:
                                                              Color(0xFFFF7622),
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 27, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Or',
                                          style: BaseTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Playfair Display',
                                                color: Color(0xFF646982),
                                                fontSize: 16,
                                                letterSpacing: 0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25, 15, 25, 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            final user = await authManager
                                                .signInWithGoogle(context);
                                            if (user == null) {
                                              return;
                                            }

                                            context.goNamedAuth(
                                                'Home_Page', context.mounted);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(62),
                                            child: Image.asset(
                                              'assets/images/Google.png',
                                              width: 62,
                                              height: 62,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 30)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
