import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/base_structure/base_icon_button.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_toggle_icon.dart';
import '/base_structure/base_util.dart';
import '/base_structure/base_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'recipe_page_model.dart';
export 'recipe_page_model.dart';

class RecipePageWidget extends StatefulWidget {
  const RecipePageWidget({
    super.key,
    required this.recipeRef,
    bool? upVoteValue,
    required this.downVoteValue,
    required this.savedPostValue,
  }) : this.upVoteValue = upVoteValue ?? true;

  final DocumentReference? recipeRef;
  final bool upVoteValue;
  final bool? downVoteValue;
  final bool? savedPostValue;

  @override
  State<RecipePageWidget> createState() => _RecipePageWidgetState();
}

class _RecipePageWidgetState extends State<RecipePageWidget>
    with TickerProviderStateMixin {
  late RecipePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecipePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.upVoteToggleValue = widget.upVoteValue;
        _model.downVoteToggleValue = widget.downVoteValue!;
        _model.savedToggleValue = widget.savedPostValue!;
      });
    });

    _model.instructionNReviewTAbBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RecipeRecord>(
      stream: RecipeRecord.getDocument(widget.recipeRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: BaseTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    BaseTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final recipePageRecipeRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: BaseTheme.of(context).primaryBackground,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BaseTheme.of(context).primary,
                    BaseTheme.of(context).secondary
                  ],
                  stops: [0.0, 0.75],
                  begin: AlignmentDirectional(0.0, -1.0),
                  end: AlignmentDirectional(0, 1.0),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              110.0, 0.0, 100.0, 0.0),
                          child: Text(
                            'Recipe',
                            style: BaseTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  fontSize: 32.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 55.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.safePop();

                            await recipePageRecipeRecord.reference
                                .update(createRecipeRecordData(
                              uPvoteTotal: valueOrDefault<int>(
                                recipePageRecipeRecord.uPvoteList.length,
                                0,
                              ),
                            ));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color:
                                BaseTheme.of(context).primaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 5.0),
                        child: Transform.scale(
                          scaleX: -1.0,
                          scaleY: 1.0,
                          origin: Offset(0.0, 0),
                          child: Visibility(
                            visible: loggedIn,
                            child: ToggleIcon(
                              onPressed: () async {
                                setState(() => _model.savedToggleValue =
                                    !_model.savedToggleValue);
                                if (_model.savedToggleValue) {
                                  await currentUserReference!.update({
                                    ...mapToFirestore(
                                      {
                                        'FavouriteRecipe':
                                            FieldValue.arrayUnion([
                                          recipePageRecipeRecord.reference
                                        ]),
                                      },
                                    ),
                                  });
                                  setState(() {
                                    _model.savedToggleValue = true;
                                  });
                                } else {
                                  await currentUserReference!.update({
                                    ...mapToFirestore(
                                      {
                                        'FavouriteRecipe':
                                            FieldValue.arrayRemove([
                                          recipePageRecipeRecord.reference
                                        ]),
                                      },
                                    ),
                                  });
                                  setState(() {
                                    _model.savedToggleValue = false;
                                  });
                                }
                              },
                              value: _model.savedToggleValue,
                              onIcon: Icon(
                                Icons.bookmark,
                                color: BaseTheme.of(context)
                                    .primaryBackground,
                                size: 30.0,
                              ),
                              offIcon: Icon(
                                Icons.bookmark_border,
                                color: Color(0xFF6E6C68),
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 90.0, 0.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.sizeOf(context).height * 1.35,
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.6,
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional(-1.41, -0.38),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 350.0, 0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/Ellipse_9.png',
                                          width: 145.0,
                                          height: 145.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.6,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        100.0, 260.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Ellipse_9.png',
                                        width: 145.0,
                                        height: 145.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.6,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        200.0, 660.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Ellipse_9.png',
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.6,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        200.0, 450.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Ellipse_9.png',
                                        width: 130.0,
                                        height: 130.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.6,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        100.0, 580.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Ellipse_9.png',
                                        width: 90.0,
                                        height: 90.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      200.0, 50.0, 0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/Ellipse_10_(1).png',
                                      width: 175.0,
                                      height: 190.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.7, -1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/bg_recope.png',
                                      width: MediaQuery.sizeOf(context).width *
                                          0.93,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.43,
                                      fit: BoxFit.cover,
                                      alignment: Alignment(2.0, 0.0),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 20.0, 0.0, 0.0),
                                      child: Text(
                                        recipePageRecipeRecord.recipeName,
                                        style: BaseTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Playfair Display',
                                              color:
                                                  BaseTheme.of(context)
                                                      .secondary,
                                              fontSize: 28.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 395.0, 0.0, 0.0),
                                        child: StreamBuilder<UsersRecord>(
                                          stream: UsersRecord.getDocument(
                                              recipePageRecipeRecord.userId!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      BaseTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final rowUsersRecord =
                                                snapshot.data!;
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, -1.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (currentUserUid ==
                                                                recipePageRecipeRecord
                                                                    .userId
                                                                    ?.id) {
                                                              context.pushNamed(
                                                                  'ProfileRecipePage');
                                                            } else {
                                                              context.pushNamed(
                                                                'AuthorsProfilePage',
                                                                queryParameters:
                                                                    {
                                                                  'authorRef':
                                                                      serializeParam(
                                                                    recipePageRecipeRecord
                                                                        .userId,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  kTransitionInfoKey:
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                  ),
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 42.0,
                                                            height: 42.0,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              rowUsersRecord
                                                                  .photoUrl,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (currentUserUid ==
                                                                recipePageRecipeRecord
                                                                    .userId
                                                                    ?.id) {
                                                              context.pushNamed(
                                                                  'ProfileRecipePage');
                                                            } else {
                                                              context.pushNamed(
                                                                'AuthorsProfilePage',
                                                                queryParameters:
                                                                    {
                                                                  'authorRef':
                                                                      serializeParam(
                                                                    recipePageRecipeRecord
                                                                        .userId,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  kTransitionInfoKey:
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                  ),
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            rowUsersRecord
                                                                .displayName,
                                                            style: BaseTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Spline Sans',
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                if ((currentUserUid ==
                                                                        recipePageRecipeRecord
                                                                            .userId
                                                                            ?.id) ||
                                                                    (loggedIn ==
                                                                        false)) {
                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: BaseTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container(
                                                                    height:
                                                                        30.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        if ((currentUserDocument?.followings.toList() ?? []).contains(rowUsersRecord.reference) ==
                                                                            true)
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-2.7, 0.0),
                                                                            child:
                                                                                AuthUserStreamWidget(
                                                                              builder: (context) => FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  await currentUserReference!.update({
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'followings': FieldValue.arrayRemove([
                                                                                          recipePageRecipeRecord.userId
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });

                                                                                  await rowUsersRecord.reference.update({
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'followers': FieldValue.arrayRemove([
                                                                                          currentUserReference
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                },
                                                                                text: 'Following',
                                                                                options: FFButtonOptions(
                                                                                  width: 100.0,
                                                                                  height: 30.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 18.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: Color(0x06FFFFFF),
                                                                                  textStyle: BaseTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Playfair Display',
                                                                                        color: BaseTheme.of(context).success,
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                  elevation: 3.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: BaseTheme.of(context).primaryBackground,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        if ((currentUserDocument?.followings.toList() ?? []).contains(rowUsersRecord.reference) ==
                                                                            false)
                                                                          AuthUserStreamWidget(
                                                                            builder: (context) =>
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                await currentUserReference!.update({
                                                                                  ...mapToFirestore(
                                                                                    {
                                                                                      'followings': FieldValue.arrayUnion([
                                                                                        recipePageRecipeRecord.userId
                                                                                      ]),
                                                                                    },
                                                                                  ),
                                                                                });

                                                                                await rowUsersRecord.reference.update({
                                                                                  ...mapToFirestore(
                                                                                    {
                                                                                      'followers': FieldValue.arrayUnion([
                                                                                        currentUserReference
                                                                                      ]),
                                                                                    },
                                                                                  ),
                                                                                });
                                                                              },
                                                                              text: '             Follow            ',
                                                                              options: FFButtonOptions(
                                                                                width: 100.0,
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: BaseTheme.of(context).primaryBackground,
                                                                                textStyle: BaseTheme.of(context).titleSmall.override(
                                                                                      fontFamily: 'Spline Sans',
                                                                                      color: BaseTheme.of(context).secondaryText,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                                elevation: 2.0,
                                                                                borderSide: BorderSide(
                                                                                  color: BaseTheme.of(context).secondaryText,
                                                                                  width: 1.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (currentUserUid ==
                                                        rowUsersRecord.uid
                                                    ? true
                                                    : false)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                15.0, 0.0),
                                                    child: InkWell(
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
                                                          'EditRecipe_Page',
                                                          queryParameters: {
                                                            'editRecipeRef':
                                                                serializeParam(
                                                              widget.recipeRef,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                            ),
                                                          },
                                                        );

                                                        setState(() {
                                                          FFAppState()
                                                                  .TempIngredientAppState =
                                                              recipePageRecipeRecord
                                                                  .ingredients
                                                                  .toList()
                                                                  .cast<
                                                                      String>();
                                                          FFAppState()
                                                                  .TempInstructionAppState =
                                                              recipePageRecipeRecord
                                                                  .instructions
                                                                  .toList()
                                                                  .cast<
                                                                      String>();
                                                          FFAppState()
                                                                  .TempImgAppState =
                                                              recipePageRecipeRecord
                                                                  .photos
                                                                  .toList()
                                                                  .cast<
                                                                      String>();
                                                          FFAppState()
                                                                  .selectedCategory =
                                                              recipePageRecipeRecord
                                                                  .cuisineType;
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: BaseTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 450.0, 0.0, 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x16F2EBDF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 0.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment(-1.0, 0),
                                            child: TabBar(
                                              isScrollable: true,
                                              labelColor:
                                                  BaseTheme.of(context)
                                                      .primaryText,
                                              unselectedLabelColor:
                                                  Color(0xFF7E7C7A),
                                              labelStyle:
                                                  BaseTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            'Spline Sans',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                              unselectedLabelStyle: TextStyle(),
                                              indicatorColor:
                                                  BaseTheme.of(context)
                                                      .primaryBackground,
                                              tabs: [
                                                Tab(
                                                  text: 'Instructions',
                                                ),
                                                Tab(
                                                  text: 'Reviews',
                                                ),
                                              ],
                                              controller: _model
                                                  .instructionNReviewTAbBarController,
                                              onTap: (i) async {
                                                [() async {}, () async {}][i]();
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              controller: _model
                                                  .instructionNReviewTAbBarController,
                                              children: [
                                                KeepAliveWidgetWrapper(
                                                  builder: (context) =>
                                                      SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        15.0,
                                                                        12.0,
                                                                        0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    recipePageRecipeRecord
                                                                        .description,
                                                                    'description',
                                                                  ),
                                                                  style: BaseTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Spline Sans',
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          15.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Ingredients',
                                                                    style: BaseTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Spline Sans',
                                                                          fontSize:
                                                                              18.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        100.0,
                                                                    height: 2.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: BaseTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: BaseTheme.of(context)
                                                                            .primaryBackground,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      15.0,
                                                                      12.0,
                                                                      0.0),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final ingredientName =
                                                                  recipePageRecipeRecord
                                                                      .ingredients
                                                                      .toList();
                                                              return Wrap(
                                                                spacing: 10.0,
                                                                runSpacing:
                                                                    10.0,
                                                                alignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .start,
                                                                direction: Axis
                                                                    .horizontal,
                                                                runAlignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                verticalDirection:
                                                                    VerticalDirection
                                                                        .down,
                                                                clipBehavior:
                                                                    Clip.none,
                                                                children: List.generate(
                                                                    ingredientName
                                                                        .length,
                                                                    (ingredientNameIndex) {
                                                                  final ingredientNameItem =
                                                                      ingredientName[
                                                                          ingredientNameIndex];
                                                                  return Opacity(
                                                                    opacity:
                                                                        0.8,
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          3.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFF4A656B),
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                BaseTheme.of(context).primaryBackground,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              5.0,
                                                                              10.0,
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            ingredientNameItem,
                                                                            style: BaseTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Playfair Display',
                                                                                  color: BaseTheme.of(context).primaryText,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          15.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Steps',
                                                                    style: BaseTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Spline Sans',
                                                                          fontSize:
                                                                              18.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                  Container(
                                                                    width: 50.0,
                                                                    height: 2.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: BaseTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: BaseTheme.of(context)
                                                                            .primaryBackground,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            final instruction =
                                                                recipePageRecipeRecord
                                                                    .instructions
                                                                    .unique(
                                                                        (e) =>
                                                                            e)
                                                                    .toList();
                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  instruction
                                                                      .length,
                                                              itemBuilder: (context,
                                                                  instructionIndex) {
                                                                final instructionItem =
                                                                    instruction[
                                                                        instructionIndex];
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            25.0,
                                                                            10.0,
                                                                            12.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '•     ',
                                                                          style: BaseTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Playfair Display',
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Flexible(
                                                                          child:
                                                                              Text(
                                                                            instructionItem,
                                                                            style: BaseTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Playfair Display',
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w300,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        Opacity(
                                                          opacity: 0.0,
                                                          child: Container(
                                                            height: 20.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: BaseTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                KeepAliveWidgetWrapper(
                                                  builder: (context) => Builder(
                                                    builder: (context) {
                                                      if (loggedIn == true) {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _model.textController,
                                                                          focusNode:
                                                                              _model.textFieldFocusNode,
                                                                          autofocus:
                                                                              true,
                                                                          textCapitalization:
                                                                              TextCapitalization.none,
                                                                          textInputAction:
                                                                              TextInputAction.done,
                                                                          obscureText:
                                                                              false,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            labelStyle: BaseTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Playfair Display',
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                            hintText:
                                                                                'Give a Comment here ...',
                                                                            hintStyle: BaseTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Spline Sans',
                                                                                  color: BaseTheme.of(context).tertiary,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                            errorStyle: BaseTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Playfair Display',
                                                                                  color: BaseTheme.of(context).error,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                            enabledBorder:
                                                                                InputBorder.none,
                                                                            focusedBorder:
                                                                                InputBorder.none,
                                                                            errorBorder:
                                                                                InputBorder.none,
                                                                            focusedErrorBorder:
                                                                                InputBorder.none,
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                Color(0x40D0CDC8),
                                                                            contentPadding:
                                                                                EdgeInsets.all(20.0),
                                                                          ),
                                                                          style: BaseTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Playfair Display',
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                          validator: _model
                                                                              .textControllerValidator
                                                                              .asValidator(context),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          BaseIconButton(
                                                                        borderColor:
                                                                            BaseTheme.of(context).primary,
                                                                        borderRadius:
                                                                            20.0,
                                                                        borderWidth:
                                                                            1.0,
                                                                        buttonSize:
                                                                            40.0,
                                                                        fillColor:
                                                                            BaseTheme.of(context).accent1,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .send,
                                                                          color:
                                                                              BaseTheme.of(context).primaryText,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          var commentsRecordReference = CommentsRecord
                                                                              .collection
                                                                              .doc();
                                                                          await commentsRecordReference
                                                                              .set(createCommentsRecordData(
                                                                            userId:
                                                                                currentUserReference,
                                                                            commentText:
                                                                                _model.textController.text,
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                          ));
                                                                          _model.cmtRef = CommentsRecord.getDocumentFromData(
                                                                              createCommentsRecordData(
                                                                                userId: currentUserReference,
                                                                                commentText: _model.textController.text,
                                                                                createdAt: getCurrentTimestamp,
                                                                              ),
                                                                              commentsRecordReference);

                                                                          await widget
                                                                              .recipeRef!
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'commentList': FieldValue.arrayUnion([
                                                                                  _model.cmtRef?.reference
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                          setState(
                                                                              () {
                                                                            _model.textController?.clear();
                                                                          });

                                                                          setState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              StreamBuilder<
                                                                  List<
                                                                      CommentsRecord>>(
                                                                stream:
                                                                    queryCommentsRecord(
                                                                  queryBuilder: (commentsRecord) => commentsRecord.orderBy(
                                                                      'created_at',
                                                                      descending:
                                                                          true),
                                                                  singleRecord:
                                                                      true,
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            BaseTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<CommentsRecord>
                                                                      containerCommentsRecordList =
                                                                      snapshot
                                                                          .data!;
                                                                  // Return an empty Container when the item does not exist.
                                                                  if (snapshot
                                                                      .data!
                                                                      .isEmpty) {
                                                                    return Container();
                                                                  }
                                                                  final containerCommentsRecord = containerCommentsRecordList
                                                                          .isNotEmpty
                                                                      ? containerCommentsRecordList
                                                                          .first
                                                                      : null;
                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final cmtList = recipePageRecipeRecord
                                                                            .commentList
                                                                            .sortedList((e) =>
                                                                                dateTimeFormat('relative', containerCommentsRecord!.createdAt!))
                                                                            .toList();
                                                                        return ListView
                                                                            .separated(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          itemCount:
                                                                              cmtList.length,
                                                                          separatorBuilder: (_, __) =>
                                                                              SizedBox(height: 11.0),
                                                                          itemBuilder:
                                                                              (context, cmtListIndex) {
                                                                            final cmtListItem =
                                                                                cmtList[cmtListIndex];
                                                                            return StreamBuilder<CommentsRecord>(
                                                                              stream: CommentsRecord.getDocument(cmtListItem),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 50.0,
                                                                                      height: 50.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          BaseTheme.of(context).primary,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                final commetnRowCommentsRecord = snapshot.data!;
                                                                                return Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: StreamBuilder<UsersRecord>(
                                                                                        stream: UsersRecord.getDocument(commetnRowCommentsRecord.userId!),
                                                                                        builder: (context, snapshot) {
                                                                                          // Customize what your widget looks like when it's loading.
                                                                                          if (!snapshot.hasData) {
                                                                                            return Center(
                                                                                              child: SizedBox(
                                                                                                width: 50.0,
                                                                                                height: 50.0,
                                                                                                child: CircularProgressIndicator(
                                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                    BaseTheme.of(context).primary,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          }
                                                                                          final rowUsersRecord = snapshot.data!;
                                                                                          return Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  context.pushNamed(
                                                                                                    'AuthorsProfilePage',
                                                                                                    queryParameters: {
                                                                                                      'authorRef': serializeParam(
                                                                                                        commetnRowCommentsRecord.userId,
                                                                                                        ParamType.DocumentReference,
                                                                                                      ),
                                                                                                    }.withoutNulls,
                                                                                                    extra: <String, dynamic>{
                                                                                                      kTransitionInfoKey: TransitionInfo(
                                                                                                        hasTransition: true,
                                                                                                        transitionType: PageTransitionType.fade,
                                                                                                        duration: Duration(milliseconds: 500),
                                                                                                      ),
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 45.0,
                                                                                                  height: 45.0,
                                                                                                  clipBehavior: Clip.antiAlias,
                                                                                                  decoration: BoxDecoration(
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: Image.network(
                                                                                                    rowUsersRecord.photoUrl,
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Flexible(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                          child: Text(
                                                                                                            rowUsersRecord.displayName,
                                                                                                            style: BaseTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Spline Sans',
                                                                                                                  letterSpacing: 0.0,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                          child: Text(
                                                                                                            dateTimeFormat('relative', commetnRowCommentsRecord.createdAt!),
                                                                                                            style: BaseTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Playfair Display',
                                                                                                                  letterSpacing: 0.0,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        commetnRowCommentsRecord.commentText,
                                                                                                        style: BaseTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Spline Sans',
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w300,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(SizedBox(width: 16.0)),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              Opacity(
                                                                opacity: 0.0,
                                                                child:
                                                                    Container(
                                                                  width: 1.0,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 16.0)),
                                                          ),
                                                        );
                                                      } else {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              StreamBuilder<
                                                                  List<
                                                                      CommentsRecord>>(
                                                                stream:
                                                                    queryCommentsRecord(
                                                                  queryBuilder: (commentsRecord) => commentsRecord.orderBy(
                                                                      'created_at',
                                                                      descending:
                                                                          true),
                                                                  singleRecord:
                                                                      true,
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            BaseTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<CommentsRecord>
                                                                      containerCommentsRecordList =
                                                                      snapshot
                                                                          .data!;
                                                                  // Return an empty Container when the item does not exist.
                                                                  if (snapshot
                                                                      .data!
                                                                      .isEmpty) {
                                                                    return Container();
                                                                  }
                                                                  final containerCommentsRecord = containerCommentsRecordList
                                                                          .isNotEmpty
                                                                      ? containerCommentsRecordList
                                                                          .first
                                                                      : null;
                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final cmtList = recipePageRecipeRecord
                                                                            .commentList
                                                                            .sortedList((e) =>
                                                                                dateTimeFormat('relative', containerCommentsRecord!.createdAt!))
                                                                            .toList();
                                                                        return ListView
                                                                            .separated(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          itemCount:
                                                                              cmtList.length,
                                                                          separatorBuilder: (_, __) =>
                                                                              SizedBox(height: 11.0),
                                                                          itemBuilder:
                                                                              (context, cmtListIndex) {
                                                                            final cmtListItem =
                                                                                cmtList[cmtListIndex];
                                                                            return StreamBuilder<CommentsRecord>(
                                                                              stream: CommentsRecord.getDocument(cmtListItem),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 50.0,
                                                                                      height: 50.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          BaseTheme.of(context).primary,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                final commetnRowCommentsRecord = snapshot.data!;
                                                                                return Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: StreamBuilder<UsersRecord>(
                                                                                        stream: UsersRecord.getDocument(commetnRowCommentsRecord.userId!),
                                                                                        builder: (context, snapshot) {
                                                                                          // Customize what your widget looks like when it's loading.
                                                                                          if (!snapshot.hasData) {
                                                                                            return Center(
                                                                                              child: SizedBox(
                                                                                                width: 50.0,
                                                                                                height: 50.0,
                                                                                                child: CircularProgressIndicator(
                                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                    BaseTheme.of(context).primary,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          }
                                                                                          final rowUsersRecord = snapshot.data!;
                                                                                          return Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 45.0,
                                                                                                height: 45.0,
                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                decoration: BoxDecoration(
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: Image.network(
                                                                                                  rowUsersRecord.photoUrl,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                              Flexible(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                          child: Text(
                                                                                                            rowUsersRecord.displayName,
                                                                                                            style: BaseTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Spline Sans',
                                                                                                                  letterSpacing: 0.0,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                          child: Text(
                                                                                                            dateTimeFormat('relative', commetnRowCommentsRecord.createdAt!),
                                                                                                            style: BaseTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Playfair Display',
                                                                                                                  letterSpacing: 0.0,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        commetnRowCommentsRecord.commentText,
                                                                                                        style: BaseTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Spline Sans',
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w300,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(SizedBox(width: 16.0)),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              Opacity(
                                                                opacity: 0.0,
                                                                child:
                                                                    Container(
                                                                  width: 1.0,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 16.0)),
                                                          ),
                                                        );
                                                      }
                                                    },
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 70.0, 0.0, 0.0),
                                  child: Container(
                                    height: 300.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: Builder(
                                      builder: (context) {
                                        final photoList = recipePageRecipeRecord
                                            .photos
                                            .toList();
                                        return Container(
                                          width: double.infinity,
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 40.0),
                                                child: PageView.builder(
                                                  controller: _model
                                                          .pageViewController ??=
                                                      PageController(
                                                          initialPage: max(
                                                              0,
                                                              min(
                                                                  0,
                                                                  photoList
                                                                          .length -
                                                                      1))),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: photoList.length,
                                                  itemBuilder: (context,
                                                      photoListIndex) {
                                                    final photoListItem =
                                                        photoList[
                                                            photoListIndex];
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: Image.network(
                                                            photoListItem,
                                                          ).image,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 1.0),
                                                child: smooth_page_indicator
                                                    .SmoothPageIndicator(
                                                  controller: _model
                                                          .pageViewController ??=
                                                      PageController(
                                                          initialPage: max(
                                                              0,
                                                              min(
                                                                  0,
                                                                  photoList
                                                                          .length -
                                                                      1))),
                                                  count: photoList.length,
                                                  axisDirection:
                                                      Axis.horizontal,
                                                  onDotClicked: (i) async {
                                                    await _model
                                                        .pageViewController!
                                                        .animateToPage(
                                                      i,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                    setState(() {});
                                                  },
                                                  effect: smooth_page_indicator
                                                      .ExpandingDotsEffect(
                                                    expansionFactor: 3.0,
                                                    spacing: 8.0,
                                                    radius: 16.0,
                                                    dotWidth: 16.0,
                                                    dotHeight: 8.0,
                                                    dotColor:
                                                        BaseTheme.of(
                                                                context)
                                                            .accent1,
                                                    activeDotColor:
                                                        BaseTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    paintStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 460.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (loggedIn == true) {
                                            return Transform.scale(
                                              scaleX: -1.0,
                                              scaleY: 1.0,
                                              origin: Offset(0.0, 0),
                                              child: ToggleIcon(
                                                onPressed: () async {
                                                  setState(() => _model
                                                          .upVoteToggleValue =
                                                      !_model
                                                          .upVoteToggleValue);
                                                  if (_model
                                                      .upVoteToggleValue) {
                                                    await widget.recipeRef!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'UPvoteList':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            currentUserReference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    setState(() {
                                                      _model.upVoteToggleValue =
                                                          true;
                                                      _model.downVoteToggleValue =
                                                          false;
                                                    });

                                                    await widget.recipeRef!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'DOWNvoteList':
                                                              FieldValue
                                                                  .arrayRemove([
                                                            currentUserReference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                  } else {
                                                    await widget.recipeRef!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'UPvoteList':
                                                              FieldValue
                                                                  .arrayRemove([
                                                            currentUserReference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    setState(() {
                                                      _model.upVoteToggleValue =
                                                          false;
                                                    });
                                                  }
                                                },
                                                value: _model.upVoteToggleValue,
                                                onIcon: FaIcon(
                                                  FontAwesomeIcons.levelUpAlt,
                                                  color: BaseTheme.of(
                                                          context)
                                                      .success,
                                                  size: 22.0,
                                                ),
                                                offIcon: FaIcon(
                                                  FontAwesomeIcons.levelUpAlt,
                                                  color: Color(0xFF6E6C68),
                                                  size: 22.0,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Transform.scale(
                                              scaleX: -1.0,
                                              scaleY: 1.0,
                                              child: FaIcon(
                                                FontAwesomeIcons.levelUpAlt,
                                                color: Color(0xFF6E6C68),
                                                size: 26.0,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            recipePageRecipeRecord
                                                .uPvoteList.length
                                                .toString(),
                                            '0',
                                          ),
                                          textAlign: TextAlign.end,
                                          style: BaseTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Playfair Display',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 5.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                if (loggedIn == true) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
                                                    child: Transform.scale(
                                                      scaleX: 1.0,
                                                      scaleY: -1.0,
                                                      origin: Offset(0.0, 0),
                                                      child: ToggleIcon(
                                                        onPressed: () async {
                                                          setState(() => _model
                                                                  .downVoteToggleValue =
                                                              !_model
                                                                  .downVoteToggleValue);
                                                          if (_model
                                                              .downVoteToggleValue) {
                                                            await widget
                                                                .recipeRef!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'DOWNvoteList':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    currentUserReference
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                            setState(() {
                                                              _model.downVoteToggleValue =
                                                                  true;
                                                              _model.upVoteToggleValue =
                                                                  false;
                                                            });

                                                            await widget
                                                                .recipeRef!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'UPvoteList':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    currentUserReference
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                          } else {
                                                            await widget
                                                                .recipeRef!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'DOWNvoteList':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    currentUserReference
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                            setState(() {
                                                              _model.downVoteToggleValue =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        value: _model
                                                            .downVoteToggleValue,
                                                        onIcon: FaIcon(
                                                          FontAwesomeIcons
                                                              .levelUpAlt,
                                                          color:
                                                              Color(0xFFFF0010),
                                                          size: 22.0,
                                                        ),
                                                        offIcon: FaIcon(
                                                          FontAwesomeIcons
                                                              .levelUpAlt,
                                                          color:
                                                              Color(0xFF6E6C68),
                                                          size: 22.0,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return FaIcon(
                                                    FontAwesomeIcons
                                                        .levelDownAlt,
                                                    color: Color(0xFF6E6C68),
                                                    size: 26.0,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            recipePageRecipeRecord
                                                .dOWNvoteList.length
                                                .toString(),
                                            '0',
                                          ),
                                          style: BaseTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Playfair Display',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
      },
    );
  }
}
