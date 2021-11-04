import 'package:flutter/material.dart';
import 'package:least_app/database/firestore_helper.dart';
import 'package:least_app/entity/post.dart';
import 'package:least_app/entity/user.dart';
import 'package:least_app/screens/post_item_page.dart';

class HomeViewModel extends ChangeNotifier {
  FirestoreHelper _firestoreHelper = FirestoreHelper();

  HomeViewModel() {
    getUser();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  void getUser() async {
    onLoading();
    _userModel = await _firestoreHelper.fetchUser() ?? UserModel();
    endLoading();
  }

  void addLike(String docId, PostItem item) async {
    await _firestoreHelper.modifyLike(docId, item);
    notifyListeners();
  }

  void deletePost(String docId) async {
    await _firestoreHelper.deletePost(docId);
    notifyListeners();
  }

  void navigateToPostItemPage(BuildContext context) {
    Navigator.of(context).pushNamed(PostItemPage.routeName);
  }

  Future<String> getSpecifyUser(docId) async {
    return await _firestoreHelper.getSpecificUser(docId);
  }

  void onLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
