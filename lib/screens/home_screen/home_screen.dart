import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/controller/home_controller.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/widgets/post_item.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<HomeController>(
        init: Get.put<HomeController>(HomeController()),
        builder: (HomeController homeController) {
          if(homeController.posts.isNotEmpty){
            return Expanded(
              child: ListView.builder(
                itemCount: homeController.posts.length,
                itemBuilder: (context,index){
                  return PostItem(post: homeController.posts[index],);
                },
              ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
