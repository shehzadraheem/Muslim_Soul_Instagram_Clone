import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({
    Key? key,
    required this.comments,
    required this.onPressed
  }) : super(key: key);

  final int comments;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(UniconsLine.comment_lines,
              color: Theme.of(context).iconTheme.color),
        ),
        Text('$comments comment'),
      ],
    );
  }
}
