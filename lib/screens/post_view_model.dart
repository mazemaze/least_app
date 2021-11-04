import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:least_app/database/firestore_helper.dart';
import 'package:least_app/entity/post.dart';

class PostViewModel extends ChangeNotifier {
  FirestoreHelper firestoreHelper = FirestoreHelper();

  PostViewModel() {
    _item = PostItem(
      createdAt: DateTime.now(),
      likes: 0,
      user: FirebaseAuth.instance.currentUser!.email,
    );
  }

  PostItem? _item;
  PostItem? get item => _item;

  String? _content;
  String? get content => _content;

  void registerNewPostItem(BuildContext context) async {
    _item!.content = _content;
    await firestoreHelper.registerNewPost(_item!);
    Navigator.of(context).pop();
  }

  void getContent(String value) {
    _content = value;
    notifyListeners();
  }
}
