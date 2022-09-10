import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  var email = '';
  var password = '';
  var isLoading = false.obs;

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

  Future<void> login()async{
    // implement in next part
  }
}