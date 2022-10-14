import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/comment.dart';

class CommentController extends GetxController{
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  final _collectionReference = FirebaseFirestore.instance.collection("post");
  get user => FirebaseAuth.instance.currentUser;

  final TextEditingController commentTextController = TextEditingController();

  String _postId = "";

  void getPostId(String id) {
    _postId = id;
    getComments();
  }

  Future<void> getComments() async {
    _comments.bindStream(
      _collectionReference
          .doc(_postId)
          .collection("comment")
          .orderBy("time", descending: true)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {

         List<Comment> list = [];
         querySnapshot.docs.forEach((element) {
          list.add(Comment.fromDocumentSnapshot(element));
        });
        return list;
      }),
    );
  }

  Future<void> addComment(String userName, String userUrl, String userUid, String postId) async{

    const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    await _collectionReference.doc(postId).collection("comment")
        .doc(randomStr).set({
      "commentId": randomStr,
      "comment": commentTextController.text,
      "userName": userName,
      "userUrl": userUrl,
      "userUid": userUid,
      "postId": postId,
      "time": DateTime.now().millisecondsSinceEpoch,
    });

    _collectionReference.doc(postId).get().then((DocumentSnapshot snapshot) async {

      int count = snapshot['commentsCount'];
      _collectionReference
          .doc(postId)
          .update({"commentsCount": count + 1}).then((value) {
        commentTextController.text = '';
      });

    });
  }
}