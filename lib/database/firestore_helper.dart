import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:least_app/entity/post.dart';
import 'package:least_app/entity/user.dart';

class FirestoreHelper {
  static const userRef = 'users';
  static const postRef = 'postItems';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  Future registerUser() async {
    final _userCol = await _firestore.collection(userRef).doc('user').get();
    if (_userCol.exists) {
      return;
    }
    return await _firestore.collection(userRef).doc(_user!.email).set(
        UserModel(userName: _user!.email, imgUrl: _user!.photoURL ?? "")
            .toMap());
  }

  Future fetchUser() async {
    final _userCol = _firestore.collection(userRef);
    final _doc = await _userCol.doc(_user!.email).get();
    if (_doc.exists) {
      return UserModel.fromMap(_doc);
    }
  }

  Future updateUser(UserModel user) async {
    final _userCol = _firestore.collection(userRef);
    await _userCol.doc(_user!.email).update(user.toMap());
  }

  Future registerNewPost(PostItem item) async {
    final _postCol = _firestore.collection(postRef);
    return await _postCol.doc().set(item.toMap());
  }

  Future deletePost(String docId) async {
    final _postCol = _firestore.collection(postRef);
    await _postCol.doc(docId).delete();
  }

  Stream<List<PostItem>> fetchPosts() {
    return _firestore.collection(postRef).snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => PostItem.fromMap(document.data(), document))
        .toList());
  }

  Stream<List<UserModel>> fetchUsers() {
    return _firestore.collection(userRef).snapshots().map((snapshot) =>
        snapshot.docs.map((document) => UserModel.fromMap(document)).toList());
  }

  Future modifyLike(String docId, PostItem item) async {
    UserModel user = await fetchUser();
    user.likes!.contains(docId)
        ? user.likes!.removeWhere((element) => element == docId)
        : user.likes!.add(docId);
    final _postCol = _firestore.collection(postRef);
    item.likes =
        user.likes!.contains(docId) ? (item.likes! + 1) : (item.likes! - 1);
    await updateUser(user);
    await _postCol.doc(docId).update(item.toMap());
  }

  Future getSpecificUser(PostItem post) async {
    final _userCol = _firestore.collection(userRef).doc(post.user);
    final _doc = await _userCol.get();
    return UserModel.fromMap(_doc).imgUrl;
  }
}
