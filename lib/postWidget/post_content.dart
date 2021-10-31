import "package:redditech/secret.dart";
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:redditech/post_model.dart";
import "package:photo_view/photo_view.dart";

class PostContent extends StatefulWidget {
  PostContent({Key? key, required this.post, required this.secret})
      : super(key: key);

  final Post post;
  final Secret secret;

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
                        post: widget.post, secret: widget.secret);
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
      {Key? key, required this.post, required this.secret})
      : super(key: key);

  final Post post;
  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          child: Padding(
            padding:
                EdgeInsets.only(top: 50, left: 16.0, right: 16.0, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    this.post.title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Text(
                  this.post.selftext,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
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
