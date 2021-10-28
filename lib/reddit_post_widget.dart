import "package:flutter/cupertino.dart";
import "package:redditech/post_model.dart";

class RedditechPostWidget extends StatefulWidget {
  RedditechPostWidget(this.post);

  final Post post;
  @override
  RedditechPostWidgetState createState() => RedditechPostWidgetState();
}

class RedditechPostWidgetState extends State<RedditechPostWidget> {
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PostBanner(
              subreddit: widget.post.subreddit, author: widget.post.author),
          // PostImage(url: widget.post.imageUrl),
          // PostFooter(ups: widget.post.ups, downs: widget.post.downs),
        ],
      ),
    );
  }
}

class PostBanner extends StatelessWidget {
  PostBanner({Key? key, required this.subreddit, required this.author})
      : super(key: key);

  final String author;
  final String subreddit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.subreddit),
          SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
