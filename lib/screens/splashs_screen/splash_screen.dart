import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/screens/splashs_screen/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Text(
                'Muslim Soul Instagram',
                style: Theme.of(context).textTheme.headline2,
                // if you want to change it here, you can do it with copyWith function
                // here we are using
                // our custom text theme
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              //height: double.infinity,
              child: Image.asset('assets/islamic.png'),
            ),
          ],
        ),
      ),
    );
  }
}
