import "package:flutter/cupertino.dart";

class PostBanner extends StatelessWidget {
  PostBanner({Key? key, required this.subreddit, required this.author})
      : super(key: key);

  final String author;
  final String subreddit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.subreddit,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(this.author, textAlign: TextAlign.right),
      ],
    );
  }
}
