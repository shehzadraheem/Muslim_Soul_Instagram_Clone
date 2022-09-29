import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

import '../../../models/post.dart';


class PostItem extends StatelessWidget {
  PostItem({Key? key , this.post}) : super(key: key);
  final Post? post;

  @override
  Widget build(BuildContext context) {

    final date =  DateTime.fromMillisecondsSinceEpoch(post!.time!);
    final format =  DateFormat("yMd");
    final dateString = format.format(date);

    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                NetworkImage(post!.userUrl!),
              ),
              title: Text(post!.userName!, style: Theme.of(context).textTheme.subtitle1),
              subtitle: Text(dateString),
              trailing: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).iconTheme.color,
                  ),
              ),
            ),
            const SizedBox(height: 16,),
            Text(post!.postTitle!, textAlign: TextAlign.left,),
            const SizedBox(height: 16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post!.postUrl!,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(UniconsLine.thumbs_up,
                            color: Theme.of(context).iconTheme.color)),
                    IconButton(
                        onPressed: null,
                        icon: Icon(UniconsLine.comment_lines,
                            color: Theme.of(context).iconTheme.color))
                  ],
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      UniconsLine.telegram_alt,
                      color: Theme.of(context).iconTheme.color,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
