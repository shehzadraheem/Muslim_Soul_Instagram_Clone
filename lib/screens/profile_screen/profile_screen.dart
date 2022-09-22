import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/screens/profile_screen/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final _controller = Get.put(ProfileController());

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
                  return _controller.url.value.isNotEmpty
                      ? Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                imageUrl: _controller.url.value,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/images/account.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.name.value,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _controller.email.value,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
