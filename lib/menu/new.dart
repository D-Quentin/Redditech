import "package:flutter/material.dart";
import "package:redditech/reddit_post_widget.dart";
import "package:redditech/secret.dart";
import "package:redditech/post_model.dart";
import "package:flutter/cupertino.dart";
import "package:redditech/api_request.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";

class SubredditNewWidget extends StatefulWidget {
  SubredditNewWidget(this.secret);

  final Secret secret;

  @override
  SubredditNewWidgetState createState() => SubredditNewWidgetState(secret);
}

class SubredditNewWidgetState extends State<SubredditNewWidget> {
  SubredditNewWidgetState(this.secret);

  final Secret secret;
  bool firstLoad = true;
  String jsonContent = "";
  List<Post> postList = [];
  APIRequest api = APIRequest();
  Unserializer unserializer = Unserializer();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _firstLoad() async {
    await api.requestNewPost(this.secret).then((String string) {
      postList = unserializer.getPostFromJson(string);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  void _onRefresh() async {
    await api.requestNewPost(this.secret).then((String string) {
      postList = unserializer.getPostFromJson(string);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await api
        .requestNewPostAfter(this.secret,
            "?after=${postList.last.after}&count=${postList.length}")
        .then((String string) {
      List<Post> postListAfter = unserializer.getPostFromJson(string);
      postList.addAll(postListAfter);
      if (mounted) setState(() {});
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      this._firstLoad();
      this.firstLoad = false;
    }
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed! Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 100.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: RedditechPostWidget(postList[i])),
          // itemExtent: 100.0,
          itemCount: postList.length,
        ),
      ),
    );
  }
}
