import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_muslim_soul_instagram/models/post.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final _postList = RxList<Post>([]);

  List<Post> get posts => _postList.value;

  final _collectionReference = FirebaseFirestore.instance.collection("post");

  @override
  void onInit() {
    super.onInit();
    _postList.bindStream(getPosts());
  }

  Stream<List<Post>> getPosts(){
    return _collectionReference
        .orderBy("time",descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot){

          List<Post> list = [];
          querySnapshot.docs.forEach((element) {
            list.add(Post.fromDocumentSnapshot(element));
          });
          return list;
    });
  }

}