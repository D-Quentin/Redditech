import 'package:redditech/secret.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:redditech/post_model.dart";
import "package:redditech/postWidget/post_footer.dart";
import "package:redditech/postWidget/post_banner.dart";
import "package:redditech/postWidget/post_content.dart";

class RedditechPostWidget extends StatefulWidget {
  RedditechPostWidget(this.post, this.secret);

  final Post post;
  final Secret secret;

  @override
  RedditechPostWidgetState createState() => RedditechPostWidgetState();
}

class RedditechPostWidgetState extends State<RedditechPostWidget> {
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0, bottom: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PostBanner(
            subreddit: widget.post.subreddit,
            author: widget.post.author,
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 10,
            thickness: 1,
          ),
          PostContent(
              title: widget.post.title,
              url: widget.post.imageUrl,
              selftext: widget.post.selftext,
              link: widget.post.link),
          Divider(
            color: Colors.grey.shade400,
            height: 10,
            thickness: 1,
          ),
          PostFooter(
            ups: widget.post.ups,
            downs: widget.post.downs,
            nbComment: widget.post.numComment,
            name: widget.post.name,
            secret: widget.secret,
          ),
        ],
      ),
    );
  }
}
