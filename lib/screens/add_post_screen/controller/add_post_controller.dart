import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as log;

class AddPostController extends GetxController{

  RxBool isImgAvailable = false.obs;
  final _picker = ImagePicker();
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  RxBool isLoading = false.obs;

  late TextEditingController postTxtController;
  CollectionReference userDatBaseReference = FirebaseFirestore.instance.collection("post");


  @override
  void onInit() {
    postTxtController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    postTxtController.dispose();
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      selectedImageSize.value = "${((File(selectedImagePath.value)).
      lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
    }
  }

  Future<String?> uploadImage() async{
    File file = File(selectedImagePath.value);
    FirebaseStorage storage = FirebaseStorage.instance;

    const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // first we upload image
    // then we will get download url that we will save in database
    try {
      await storage
          .ref('uploads/post/${randomStr}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      log.log(e.code.toString());
    }

    String downloadURL = await storage
        .ref('uploads/post/${randomStr}')
        .getDownloadURL();

    return downloadURL;
  }

  Future<void> addPost({required String userName, required String userUrl}) async{

    if(isImgAvailable.value && postTxtController.text.isNotEmpty){

      isLoading.value = true;
      uploadImage().then((url){

        if(url != null){

          saveDataToDb(url: url, userName: userName, userUrl: userUrl).then((value){
            isLoading.value = false;

            postTxtController.text = '';
            selectedImagePath.value = '';
          });

        }else{
          isLoading.value = false;
        }
      });

    }else{
      Get.snackbar("Warning", "Please enter details",
      snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red,colorText: Colors.white);
    }
  }

  Future<void> saveDataToDb ({
    required String url,
    required String userName,
    required String userUrl }) async {
    User? user = FirebaseAuth.instance.currentUser;
    await userDatBaseReference.add({
      'postTitle': postTxtController.text, // add this line in your code
      'userUid': user!.uid,
      'userName': userName,
      'userUrl': userUrl,
      'postUrl': url,
      'time': DateTime.now().millisecondsSinceEpoch,
      'likes' : []
    });
    return;
  }

}