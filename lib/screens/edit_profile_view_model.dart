import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:least_app/database/firestore_helper.dart';
import 'package:least_app/entity/user.dart';

class EditProfileViewModel extends ChangeNotifier {
  FirestoreHelper _firestoreHelper = FirestoreHelper();
  String? _nickName;
  String? get nickName => _nickName;

  EditProfileViewModel() {
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

  XFile? _NewimgUrl;
  XFile? get newImgUrl => _NewimgUrl;

  bool? _isSet = false;
  bool? get isSet => _isSet;

  String defaultImgUrl = FirebaseAuth.instance.currentUser!.photoURL ?? "";

  void getNickName(String value) {
    _nickName = value;
    print(_nickName);
    notifyListeners();
  }

  Future<void> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _NewimgUrl = image;
      _isSet = true;
      _userModel!.imgUrl = image.path;
      notifyListeners();
    }
  }

  void updateUser() async {
    _userModel!.nickName = _nickName;
    _userModel!.isFirstLogin = false;
    await _firestoreHelper.updateUser(_userModel!);
    notifyListeners();
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
