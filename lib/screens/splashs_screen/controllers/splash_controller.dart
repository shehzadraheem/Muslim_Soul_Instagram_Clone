import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // after 3 seconds go to next screen
    User? user = FirebaseAuth.instance.currentUser;
    // user is already logged in go to main screen
    if(user != null){
      Timer(const Duration(seconds: 3),(){
        Get.offNamed('/main_screen');
      });
    }else{
      Timer(const Duration(seconds: 3),(){
        Get.offNamed('/login_screen');
      });
    }

  }
}