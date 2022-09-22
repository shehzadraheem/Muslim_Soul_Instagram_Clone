import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../profile_screen/controller/profile_controller.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);

  // here i'm using the same controller for getting only current user image and name
  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            child: Column(
              children: [
                Obx(() {
                  return _profileController.url.value.isNotEmpty
                      ? Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                imageUrl: _profileController.url.value,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/images/account.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              _profileController.name.value,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        )
                      : Container();
                }),
                const SizedBox(
                  height: 14,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 14,
                ),
                const TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Write here...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: const Icon(Icons.image,size: 45,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
