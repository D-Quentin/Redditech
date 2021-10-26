import "package:flutter/cupertino.dart";
import "package:redditech/post_model.dart";

class RedditPostWidget extends StatelessWidget {
  RedditPostWidget(this.post);

  final Post post;

  Widget build(BuildContext context) {
    return Center(child: Text(post.title));
  }
}
