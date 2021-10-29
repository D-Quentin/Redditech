import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "package:photo_view/photo_view.dart";

class PostContent extends StatefulWidget {
  PostContent(
      {Key? key,
      required this.title,
      required this.url,
      required this.selftext,
      required this.link})
      : super(key: key);

  final String url;
  final String link;
  final String title;
  final String selftext;

  @override
  PostContentState createState() => PostContentState();
}

class PostContentState extends State<PostContent> {
  bool visualize = false;

  getContentBody() {
    List<Widget> widgets = [];
    if (widget.title.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 15),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (widget.selftext.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Text(
            widget.selftext,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.start,
          ),
        ),
      );
    }
    if (widget.url.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: GestureDetector(
            child: Image.network(
              widget.url,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageVisualizerWidget(url: widget.url);
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
