import '/base_structure/icon_button.dart';
import '/base_structure/base_theme.dart';
import '/base_structure/base_util.dart';
import 'package:flutter/material.dart';
import 'on_boarding3_model.dart';
export 'on_boarding3_model.dart';

class OnBoarding3Widget extends StatefulWidget {
  const OnBoarding3Widget({super.key});

  @override
  State<OnBoarding3Widget> createState() => _OnBoarding3WidgetState();
}

class _OnBoarding3WidgetState extends State<OnBoarding3Widget> {
  late OnBoarding3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoarding3Model());
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
              Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        BaseTheme.of(context).primary,
                        BaseTheme.of(context).secondary,
                        BaseTheme.of(context).secondary
                      ],
                      stops: [0.0, 0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/Boarding3.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Become a \nMaster Chef',
                            textAlign: TextAlign.start,
                            style: BaseTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Playfair Display',
                                  fontSize: 40.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 150.0,
                                maxWidth: 260.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur  elit, sed do eiusmod tempor incididunt ut.\n',
                                textAlign: TextAlign.start,
                                style: BaseTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                      child: Stack(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/FullProgressBar.png',
                                  width: 100.0,
                                  height: 7.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: BaseIconButton(
                              borderRadius: 40.0,
                              borderWidth: 1.0,
                              buttonSize: 45.0,
                              icon: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: BaseTheme.of(context).primaryText,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                context.pushNamed(
                                  'Home_Page',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
