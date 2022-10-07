import 'package:flutter_muslim_soul_instagram/screens/add_post_screen/add_post_screen.dart';
import 'package:flutter_muslim_soul_instagram/screens/chat_screen/chat_screen.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/home_screen.dart';
import 'package:flutter_muslim_soul_instagram/screens/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import 'dart:developer';

class MainScreenController extends GetxController{

  RxInt selectedIndex = 0.obs;

  final widgetOptions =  [
    HomeScreen(),
    AddPostScreen(),
    const ChatScreen(),
    ProfileScreen()
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
    //log(selectedIndex.string);
  }

}