import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var name = '';
  var email = '';
  var password = '';
  var isLoading = false.obs;

  var isImgAvailable = false.obs;
  final _picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  CollectionReference userDatBaseReference = FirebaseFirestore.instance.collection("user");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  String? validName(String value) {
    if (value.length < 3) {
      return "Name must be 3 characters";
    }
    return null;
  }

  String? validEmail(String value) {
    if (!GetUtils.isEmail(value.trim())) {
      return "Please Provide Valid Email";
    }
    return null;
  }

  String? validPassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      selectedImageSize.value = "${((File(selectedImagePath.value)).
      lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      isImgAvailable.value = true;
    } else {
      isImgAvailable.value = false;
    }
  }

  Future<UserCredential?> userRegister() async {
    isLoading.value = true;
    UserCredential? userCredential;
    try {

      // first upload image in Firebase Storage
      // second authenticate user
      // then save user data in database and go to login screen
      uploadFile().then((url)async{
        if(url != null){
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: emailController.text.trim(),
              password: passwordController.text.trim()).then((value) async {

            saveDataToDb(url).then((value) async {
              isLoading.value = false;
              Get.offAllNamed('/login_screen');
            });

            return;
          });

        }
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }

    return userCredential;
  }

  Future<String?> uploadFile() async {
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
          .ref('uploads/pic/${randomStr}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }

    String downloadURL = await storage
        .ref('uploads/pic/${randomStr}')
        .getDownloadURL();

    return downloadURL;
  }

  Future<void> saveDataToDb(var url) async {
    User? user = FirebaseAuth.instance.currentUser;
    await userDatBaseReference.doc(user!.uid).set({
      'uid': user.uid,
      'name': nameController.text,
      'email': emailController.text,
      'url': url,
    });
    return;
  }
}