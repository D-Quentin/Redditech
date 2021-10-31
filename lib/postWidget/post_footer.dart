import "package:flutter/material.dart";
import 'package:redditech/secret.dart';
import "package:flutter/cupertino.dart";
import "package:redditech/post_model.dart";
import "package:redditech/api_request.dart";

class PostFooter extends StatefulWidget {
  PostFooter({
    Key? key,
    required this.post,
    required this.secret,
  }) : super(key: key);

  final Post post;
  final Secret secret;
  final APIRequest api_request = APIRequest();

  @override
  PostFooterState createState() => PostFooterState();
}

class PostFooterState extends State<PostFooter> {
  bool upvoted = false;
  bool downvoted = false;

  Widget getCommentButton() {
    if (widget.post.numComment > 1) {
      return Text("${widget.post.numComment} Comments");
    }
    return Text("${widget.post.numComment} Comment");
  }

  _handlePressUpvote() {
    if (upvoted) {
      this.upvoted = false;
      widget.api_request.votePost(widget.secret, widget.post.name, 0);
      widget.post.ups -= 1;
    } else if (downvoted) {
      this.upvoted = true;
      this.downvoted = false;
      widget.post.ups += 1;
      widget.post.downs += 1;
      widget.api_request.votePost(widget.secret, widget.post.name, 1);
    } else {
      this.upvoted = true;
      widget.post.ups += 1;
      widget.api_request.votePost(widget.secret, widget.post.name, 1);
    }
    setState(() {});
  }

  _handlePressDownvote() {
    // widget.api_request.downvotePost();
    if (downvoted) {
      this.downvoted = false;
      widget.api_request.votePost(widget.secret, widget.post.name, 0);
      widget.post.downs += 1;
    } else if (upvoted) {
      this.upvoted = false;
      this.downvoted = true;
      widget.post.ups -= 1;
      widget.post.downs -= 1;
      widget.api_request.votePost(widget.secret, widget.post.name, -1);
    } else {
      this.downvoted = true;
      widget.post.downs -= 1;
      widget.api_request.votePost(widget.secret, widget.post.name, -1);
    }
    setState(() {});
  }

  Color _getUpvoteButtonColor() {
    if (upvoted) {
      return Color.fromARGB(255, 33, 150, 243);
    } else {
      return Color.fromARGB(255, 189, 189, 189);
    }
  }

  Color _getDownvoteButtonColor() {
    if (downvoted) {
      return Color.fromARGB(255, 33, 150, 243);
    } else {
      return Color.fromARGB(255, 189, 189, 189);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.blue,
            textStyle: const TextStyle(fontSize: 12),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CommentVisualizerWidget(
                      post: widget.post, secret: widget.secret);
                },
              ),
            );
          },
          child: getCommentButton(),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                _handlePressUpvote();
              },
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_up_sharp,
                      color: _getUpvoteButtonColor()),
                  Text("${widget.post.ups}",
                      style: TextStyle(color: _getUpvoteButtonColor())),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                _handlePressDownvote();
              },
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_sharp,
                      color: _getDownvoteButtonColor()),
                  Text("${widget.post.downs}",
                      style: TextStyle(color: _getDownvoteButtonColor())),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CommentVisualizerWidget extends StatelessWidget {
  const CommentVisualizerWidget(
      {Key? key, required this.post, required this.secret})
      : super(key: key);

  final Post post;
  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 50),
          child: Column(
            children: [
              WriteCommentWidget(post: this.post, secret: this.secret),
              PreviewCommentWidget(post: this.post, secret: this.secret),
            ],
          ),
        ),
      ),
    );
  }
}

class WriteCommentWidget extends StatelessWidget {
  const WriteCommentWidget({Key? key, required this.post, required this.secret})
      : super(key: key);

  final Post post;
  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.blue,
              ),
            ),
          ],
        ),
        TextField(
          minLines: 5,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Comment',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text("Post"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Divider(
            color: Colors.grey.shade400,
            height: 10,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class PreviewCommentWidget extends StatelessWidget {
  const PreviewCommentWidget(
      {Key? key, required this.post, required this.secret})
      : super(key: key);

  final Post post;
  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("palceholder"),
      ],
    );
  }
}
