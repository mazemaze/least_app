import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:least_app/database/firestore_helper.dart';

class LoginViewModel extends ChangeNotifier {
  FirestoreHelper firestoreHelper = FirestoreHelper();
  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loginFlowWithGoogle() async {
    onLoading();
    try {
      await _signInWithGoogle();
      await firestoreHelper.registerUser();
    } catch (error) {
      print(error);
      return endLoading();
    }
    endLoading();
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
