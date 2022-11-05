import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewFullScreen extends StatefulWidget {

  @override
  State<StoryViewFullScreen> createState() => _StoryViewFullScreenState();
}

class _StoryViewFullScreenState extends State<StoryViewFullScreen> {

  late final story;
  final controller = StoryController();
  // this is StoryView ( StoryController the library we are using)
  // don't confused
  final List<StoryItem> storyItems = [];

  void retrieveStories() {
    /// and story has a [list] of urls
    /// you can add comparison here in this loop for [video] and [image]
    /// for video use [StoryItem.pageVideo]
    /// for image use [StoryItem.pageImage]
    for (var element in story.url!) {
      storyItems.add(
          StoryItem.pageImage(
            url: element,
            controller: controller,
          )
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    story = Get.arguments[0];
    retrieveStories();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: storyItems, // list of stories
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Get.back(); // go back as complete
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: controller,
      ),
    );
  }
}