import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/models/story.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/controller/home_controller.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/widgets/create_story.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/widgets/post_item.dart';
import 'package:flutter_muslim_soul_instagram/screens/home_screen/widgets/story.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../profile_screen/controller/profile_controller.dart';
import 'controller/stories_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _homeController = Get.put(HomeController());
  final _profileController = Get.put(ProfileController());
  final _storyController = Get.put(StoriesController());

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Muslim Soul Instagram',
          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: _size.height * 0.13,
              child: Row(
                children: [
                  CreateStory(
                    onTap: (){
                      _storyController.getImage().then((value){
                        if (value) {
                          _storyController.createStory(
                            userName: _profileController.name.value,
                            userUrl: _profileController.url.value,
                          );
                        }
                      });
                    },
                  ),
                  Obx((){
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _storyController.stories.length,
                        itemBuilder: (context, index){

                          return StoryWidget(
                            name: _storyController.stories[index].userName!,
                            image: _storyController.stories[index].userUrl!,
                            onTap: (){
                              Get.toNamed('/story_view_screen',arguments: [_storyController.stories[index]]);
                              // pass a story as an argument
                            },
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Obx((){
              return Expanded(
                child: ListView.builder(
                  itemCount: _homeController.posts.length,
                  itemBuilder: (context,index){
                    return PostItem(
                      post: _homeController.posts[index],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
