import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/constants/constants.dart';
import 'package:flutter_muslim_soul_instagram/screens/main/controller/main_screen_controller.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final _controller = Get.put(MainScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: _controller.widgetOptions.elementAt(_controller.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: lightPrimaryColor.withOpacity(0.3),
            currentIndex: _controller.selectedIndex.value,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            iconSize: 40,
            onTap: _controller.onItemTapped,
            elevation: 5
        ),
      );
    });
  }
}
