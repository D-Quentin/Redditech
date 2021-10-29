import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:redditech/post_model.dart";
import "package:photo_view/photo_view.dart";
import "package:redditech/postWidget/reddit_post_widget.dart";

class PostContent extends StatefulWidget {
  PostContent({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  PostContentState createState() => PostContentState();
}

class PostContentState extends State<PostContent> {
  bool visualize = false;

  getContentBody() {
    List<Widget> widgets = [];
    if (widget.post.title.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 15),
          child: Text(
            widget.post.title,
            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (widget.post.selftext.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: GestureDetector(
            child: Text(
              widget.post.selftext,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
              maxLines: 10,
              overflow: TextOverflow.fade,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TextVisualizerWidget(
                        title: widget.post.title, text: widget.post.selftext);
                  },
                ),
              );
            },
          ),
        ),
      );
    }
    if (widget.post.imageUrl.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: GestureDetector(
            child: Image.network(
              widget.post.imageUrl,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageVisualizerWidget(url: widget.post.imageUrl);
              }));
            },
          ),
        ),
      );
    }
    // TODO - add a widget (if link is not empty) to visualise and launch hypertext link
    // if (widget.link.isNotEmpty) {
    // }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getContentBody(),
      ),
    );
  }
}

class TextVisualizerWidget extends StatelessWidget {
  const TextVisualizerWidget(
      {Key? key, required this.title, required this.text})
      : super(key: key);

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
              // RedditechPostWidget(widget.post);
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              // children: [
              //   Padding(
              //     padding: EdgeInsets.only(bottom: 16.0),
              //     child: Text(
              //       this.title,
              //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              //       textAlign: TextAlign.start,
              //     ),
              //   ),
              //   Text(
              //     this.text,
              //     style: TextStyle(fontSize: 15),
              //     textAlign: TextAlign.start,
              //   ),
              // ],
              ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ImageVisualizerWidget extends StatelessWidget {
  const ImageVisualizerWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(this.url),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
