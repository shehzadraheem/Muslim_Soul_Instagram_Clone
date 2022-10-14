import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? postId;
  String? userName;
  String? userUrl;
  String? userUid;
  String? comment;
  int? time;

  Comment(this.postId, this.userName, this.userUrl, this.userUid, this.comment, this.time);

  Comment.fromDocumentSnapshot( DocumentSnapshot documentSnapshot ) {
    postId = documentSnapshot['postId'];
    userName = documentSnapshot['userName'];
    userUrl = documentSnapshot['userUrl'];
    userUid = documentSnapshot['userUid'];
    comment = documentSnapshot['comment'];
    time = documentSnapshot['time'];
  }
}