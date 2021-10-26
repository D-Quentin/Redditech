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
  bool first_load = true;
  String json_content = "";
  List<Post> post_list = [];
  APIRequest api = APIRequest();
  Unserializer unserializer = Unserializer();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _firstLoad() async {
    await api.RequestNewPost(this.secret).then((String string) {
      post_list = unserializer.getPostFromJson(string);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  void _onRefresh() async {
    await api.RequestNewPost(this.secret).then((String string) {
      post_list = unserializer.getPostFromJson(string);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    Map header = {"after": post_list.last.after, "count": post_list.length};
    await api.RequestNewPostAfter(this.secret, header).then((String string) {
      List<Post> post_list_after = unserializer.getPostFromJson(string);
      post_list.addAll(post_list_after);
      if (mounted) setState(() {});
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (first_load) {
      this._firstLoad();
      this.first_load = false;
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
          itemBuilder: (c, i) => Card(child: RedditPostWidget(post_list[i])),
          // itemExtent: 100.0,
          itemCount: post_list.length,
        ),
      ),
    );
  }
}
