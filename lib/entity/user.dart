import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userName;
  String? imgUrl;
  List<dynamic>? likes;
  bool? isFirstLogin;
  String? nickName;

  UserModel(
      {this.imgUrl,
      this.userName,
      this.likes,
      this.isFirstLogin,
      this.nickName});

  Map<String, dynamic> toMap() {
    return {
      'user_name': userName,
      'img_url': imgUrl,
      'likes': likes ?? [],
      'is_first_login': isFirstLogin ?? true,
      'nick_name': nickName ?? "名無し",
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
      userName: map['user_name'],
      imgUrl: map['img_url'],
      likes: map['likes'],
      isFirstLogin: map['is_first_login'],
      nickName: map['nick_name'],
    );
  }
}
