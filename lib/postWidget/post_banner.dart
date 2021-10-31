import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "package:redditech/post_model.dart";

class PostBanner extends StatelessWidget {
  PostBanner({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.post.subreddit,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(this.post.author, textAlign: TextAlign.right),
      ],
    );
  }
}
