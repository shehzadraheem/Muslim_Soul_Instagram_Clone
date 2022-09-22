import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString url = ''.obs;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getUserData() async {
    FirebaseFirestore.instance.collection("user")
        .doc(user!.uid).get().then((DocumentSnapshot documentSnapshot) {

      name.value = documentSnapshot['name'];
      email.value = documentSnapshot['email'];
      url.value = documentSnapshot['url'];
    });
  }

  @override
  void onInit() async {
    getUserData();
    super.onInit();
  }
}