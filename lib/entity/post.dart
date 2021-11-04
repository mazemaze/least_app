import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostItem {
  String? content;
  String? user;
  int? likes;
  DateTime? createdAt;
  String? docId;

  PostItem({this.content, this.user, this.likes, this.createdAt, this.docId});

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'user': user,
      'likes': likes,
      'created_at': createdAt.toString(),
    };
  }

  factory PostItem.fromMap(
      Map<String, dynamic> map, DocumentSnapshot? document) {
    return PostItem(
      docId: document!.id,
      content: map['content'],
      user: map['user'],
      likes: map['likes'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String getFormattedDate() {
    final formater = DateFormat("y年MM月dd日");
    return formater.format(createdAt!);
  }
}
