import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/controller/home_controller.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/widgets/post_item.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx((){
        return ListView.builder(
          itemCount: _homeController.posts.length,
          itemBuilder: (context,index){
            return PostItem(
              post: _homeController.posts[index],
            );
          },
        );
      }),
    );
  }
}
