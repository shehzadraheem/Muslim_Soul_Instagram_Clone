import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/screens/authentication_screens/login_screen.dart';
import 'package:flutter_muslim_soul_instagram/screens/authentication_screens/register_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/splashs_screen/splash_screen.dart';


// I'm using Getx for state management

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(name: "/", page: ()=>  SplashScreen()),
    GetPage(name: "/login_screen", page: ()=>  LoginScreen()),
    GetPage(name: "/register_screen", page: ()=>  RegisterScreen()),
  ];
}