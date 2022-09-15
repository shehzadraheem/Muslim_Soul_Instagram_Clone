import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  var email = '';
  var password = '';
  var isLoading = false.obs;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      // if user credentials are not correct then user can't login
      return;
    }
    isLoading.value = true;

    formKey.currentState!.save();

    try {

      await _auth
          .signInWithEmailAndPassword(email: email.trim(),
          password: password.trim()).then((value) async {

                Get.offAllNamed('/main_screen');
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong Password');
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}