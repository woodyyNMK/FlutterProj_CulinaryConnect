import '/base_structure/base_util.dart';
import 'friend_list_page_widget.dart' show FriendListPageWidget;
import 'package:flutter/material.dart';

class FriendListPageModel extends BaseModel<FriendListPageWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for FriendListTabBar widget.
  TabController? friendListTabBarController;
  int get friendListTabBarCurrentIndex => friendListTabBarController != null
      ? friendListTabBarController!.index
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    friendListTabBarController?.dispose();
  }
}
