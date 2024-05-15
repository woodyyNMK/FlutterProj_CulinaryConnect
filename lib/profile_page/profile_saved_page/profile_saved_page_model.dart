import '/backend/backend.dart';
import '/base_structure/base_util.dart';
import 'profile_saved_page_widget.dart' show ProfileSavedPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileSavedPageModel extends BaseModel<ProfileSavedPageWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> savedPosts = [];
  void addToSavedPosts(DocumentReference item) => savedPosts.add(item);
  void removeFromSavedPosts(DocumentReference item) => savedPosts.remove(item);
  void removeAtIndexFromSavedPosts(int index) => savedPosts.removeAt(index);
  void insertAtIndexInSavedPosts(int index, DocumentReference item) =>
      savedPosts.insert(index, item);
  void updateSavedPostsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      savedPosts[index] = updateFn(savedPosts[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
