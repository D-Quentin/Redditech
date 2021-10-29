import "package:flutter/material.dart";
import 'package:redditech/secret.dart';
import "package:flutter/cupertino.dart";
import "package:redditech/api_request.dart";

class PostFooter extends StatefulWidget {
  PostFooter(
      {Key? key,
      required this.secret,
      required this.ups,
      required this.downs,
      required this.nbComment,
      required this.name})
      : super(key: key);

  int ups;
  int downs;
  final String name;
  final int nbComment;
  final Secret secret;
  final APIRequest api_request = APIRequest();

  @override
  PostFooterState createState() => PostFooterState();
}

class PostFooterState extends State<PostFooter> {
  bool upvoted = false;
  bool downvoted = false;

  Widget getCommentButton() {
    if (widget.nbComment > 1) {
      return Text("${widget.nbComment} Comments");
    }
    return Text("${widget.nbComment} Comment");
  }

  _handlePressUpvote() {
    print("pressed");
    if (upvoted) {
      this.upvoted = false;
      widget.api_request.VotePost(widget.secret, widget.name, 0);
      widget.ups -= 1;
    } else if (downvoted) {
      this.upvoted = true;
      this.downvoted = false;
      widget.ups += 1;
      widget.downs -= 1;
      widget.api_request.VotePost(widget.secret, widget.name, 1);
    } else {
      this.upvoted = true;
      widget.ups += 1;
      widget.api_request.VotePost(widget.secret, widget.name, 1);
    }
    setState(() {});
  }

  _handlePressDownvote() {
    // widget.api_request.downvotePost();
    if (downvoted) {
      this.downvoted = false;
      widget.api_request.VotePost(widget.secret, widget.name, 0);
      widget.downs -= 1;
    } else if (upvoted) {
      this.upvoted = false;
      this.downvoted = true;
      widget.ups -= 1;
      widget.downs += 1;
      widget.api_request.VotePost(widget.secret, widget.name, -1);
    } else {
      this.downvoted = true;
      widget.downs += 1;
      widget.api_request.VotePost(widget.secret, widget.name, -1);
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
            print("pressed");
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
                  Text("${widget.ups}",
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
                  Text("${widget.downs}",
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
