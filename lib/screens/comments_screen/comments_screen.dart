import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/constants/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controller/comment_controller.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({Key? key}) : super(key: key);

  final _commentController = Get.put(CommentController());
  final _arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _commentController.getPostId(_arguments[3]);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Obx((){
                return Expanded(
                  child: ListView.builder(
                      itemCount: _commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = _commentController.comments[index];

                        final date =  DateTime.fromMillisecondsSinceEpoch(comment.time!);
                        final format =  DateFormat('dd/MM/yyyy HH:mm');
                        final dateString = format.format(date);

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.userUrl!),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comment.userName!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Text(
                                dateString,
                                style:  const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            comment.comment!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                );
              }),
              const Divider(color: Colors.black,),
              ListTile(
                title: TextFormField(
                  controller: _commentController.commentTextController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: lightPrimaryColor,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    _commentController.addComment(_arguments[0], _arguments[1], _arguments[2], _arguments[3]);
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
