import '/base_structure/base_util.dart';
import 'feed_page_widget.dart' show FeedPageWidget;
import 'package:flutter/material.dart';

class FeedPageModel extends BaseModel<FeedPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
