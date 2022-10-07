import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String? postId;
  String? postUrl;
  String? postTitle;
  String? userName;
  String? userUrl;
  String? userUid;
  int? time;
  List<String>? likes;

  Post(
      this.postId,
      this.postUrl,
      this.postTitle,
      this.userName,
      this.userUrl,
      this.userUid,
      this.time,
      this.likes );

  Post.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot
   ) {
    postId = documentSnapshot.id;
    postUrl = documentSnapshot['postUrl'];
    postTitle = documentSnapshot['postTitle'];
    userName = documentSnapshot['userName'];
    userUrl = documentSnapshot['userUrl'];
    userUid = documentSnapshot['userUid'];
    time = documentSnapshot['time'];
    likes = documentSnapshot['likes'].cast<String>();
  }

}